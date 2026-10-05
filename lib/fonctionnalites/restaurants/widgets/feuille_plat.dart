import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/notificateur.dart';
import '../../../global/widgets/carrousel_images.dart';
import '../../orders/donnees/orders_providers.dart';
import '../../orders/screens/ecran_panier.dart';
import '../donnees/restaurants_providers.dart';
import '../metier_domaine/commande_plat.dart';
import '../metier_domaine/restaurant_models.dart';

/// Ouvre la fiche d'un plat en feuille plein écran : un plat de la carte
/// ([platId]) ou une ligne du menu du jour ([ligneId]).
Future<void> ouvrirFeuillePlat(
  BuildContext context, {
  required int restaurantId,
  int? platId,
  int? ligneId,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    clipBehavior: Clip.antiAlias,
    constraints: const BoxConstraints(maxWidth: 700),
    builder: (_) => FeuillePlat(
      restaurantId: restaurantId,
      platId: platId,
      ligneId: ligneId,
    ),
  );
}

/// Fiche plat : photos, variantes, groupes d'options, quantité et bouton
/// d'ajout au panier avec le total recalculé en direct.
class FeuillePlat extends ConsumerStatefulWidget {
  const FeuillePlat({
    super.key,
    required this.restaurantId,
    this.platId,
    this.ligneId,
  });

  final int restaurantId;
  final int? platId;

  /// Ligne du menu du jour : le plat est alors vendu à son prix de menu,
  /// dans la limite du stock restant.
  final int? ligneId;

  @override
  ConsumerState<FeuillePlat> createState() => _FeuillePlatState();
}

class _FeuillePlatState extends ConsumerState<FeuillePlat> {
  /// null = variante par défaut du plat.
  int? _varianteId;
  Set<int> _options = {};
  int _quantite = 1;
  bool _envoi = false;

  /// Refus du serveur (ou de la revalidation), affiché tel quel.
  String? _erreur;

  Future<void> _ajouter({
    required Plat plat,
    required LigneMenu? ligne,
    required VariantePlat? variante,
    required int quantite,
  }) async {
    if (_envoi) return;
    setState(() {
      _envoi = true;
      _erreur = null;
    });
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final provider = restaurantDetailProvider(id: widget.restaurantId);
    try {
      if (ligne != null) {
        // Menu du jour : le stock et l'heure limite sont relus sur le
        // serveur, jamais crus sur la seule foi du cache.
        final frais = await ref
            .read(restaurantsRepositoryProvider)
            .detailFrais(widget.restaurantId);
        final trouve = frais.ligneParId(ligne.id);
        final motif = trouve == null
            ? "Ce plat n'est plus au menu du jour"
            : motifIndisponible(
                restaurant: frais,
                plat: frais.platDeLigne(trouve.ligne),
                ligne: trouve.ligne,
                menu: trouve.menu,
                maintenant: DateTime.now(),
              );
        final stock = trouve?.ligne.stockRestant;
        if (motif != null || (stock != null && quantite > stock)) {
          // L'écran derrière la feuille reflète l'état réel.
          ref.invalidate(provider);
          if (!mounted) return;
          setState(() {
            _erreur = motif ?? 'Il ne reste que $stock en stock';
            if (motif == null) _quantite = stock!;
          });
          return;
        }
      }
      await ref
          .read(ordersRepositoryProvider)
          .ajouterLigne(
            articleId: ligne == null ? plat.id : null,
            varianteId: ligne == null ? variante?.id : null,
            ligneMenuId: ligne?.id,
            optionIds: _options.toList(),
            quantite: quantite,
          );
      ref.invalidate(paniersProvider);
      navigator.pop();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Notificateur.snackSucces(
            'Ajouté au panier.',
            action: SnackBarAction(
              label: 'Voir',
              textColor: Colors.white,
              onPressed: () => navigator.push(
                MaterialPageRoute(builder: (_) => const EcranPanier()),
              ),
            ),
          ),
        );
    } catch (e) {
      if (!mounted) return;
      setState(
        () => _erreur = messageErreurApi(
          e,
          repli: "Impossible d'ajouter au panier. Réessayez.",
        ),
      );
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final restaurant = ref
        .watch(restaurantDetailProvider(id: widget.restaurantId))
        .value;
    final trouve = widget.ligneId == null
        ? null
        : restaurant?.ligneParId(widget.ligneId!);
    final ligne = trouve?.ligne;
    final plat = ligne != null
        ? restaurant!.platDeLigne(ligne)
        : widget.platId == null
        ? null
        : restaurant?.platParId(widget.platId!);
    if (restaurant == null || plat == null) {
      return const _PlatRetire();
    }

    // Un plat du menu du jour est vendu à son prix de menu, sans variante.
    final variantes = ligne == null
        ? plat.variantesActives
        : const <VariantePlat>[];
    final variante =
        variantes.where((v) => v.id == _varianteId).firstOrNull ??
        (ligne == null ? varianteParDefaut(plat) : null);
    final groupes = plat.groupesActifs;

    final motif = motifIndisponible(
      restaurant: restaurant,
      plat: plat,
      ligne: ligne,
      menu: trouve?.menu,
      maintenant: DateTime.now(),
    );
    final stock = quantiteMax(ligne);
    final quantite = stock == null ? _quantite : math.min(_quantite, stock);
    final erreurChoix = erreurSelection(plat, _options);
    final total = prixTotal(
      plat,
      ligne: ligne,
      variante: variante,
      optionIds: _options,
      quantite: math.max(quantite, 1),
    );
    final peutAjouter = motif == null && erreurChoix == null && !_envoi;

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              _Photos(plat: plat),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plat.nom,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (plat.tempsPreparationMin != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule_outlined,
                            size: 15,
                            color: Config.couleurTexteSecondaire,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Préparation : ${plat.tempsPreparationMin} min',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Config.couleurTexteSecondaire,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (plat.description.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(plat.description, style: theme.textTheme.bodyMedium),
                    ],
                    if (ligne != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Menu du jour · ${formatMontant(ligne.prixEffectif)}'
                        '${stock != null && stock > 0 ? ' · plus que $stock' : ''}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                    if (motif != null) ...[
                      const SizedBox(height: 12),
                      _Explication(motif),
                    ],
                  ],
                ),
              ),
              if (variantes.isNotEmpty) ...[
                const _TitreGroupe(
                  titre: 'Variante',
                  contrainte: 'Choisissez 1',
                ),
                RadioGroup<int>(
                  groupValue: variante?.id,
                  onChanged: (id) => setState(() => _varianteId = id),
                  child: Column(
                    children: [
                      for (final v in variantes)
                        RadioListTile<int>(
                          value: v.id,
                          dense: true,
                          title: Text(v.nom),
                          secondary: Text(
                            formatMontant(prixVariante(plat, v)),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              for (final groupe in groupes)
                _GroupeOptions(
                  groupe: groupe,
                  choix: _options,
                  onBasculer: (optionId) => setState(() {
                    _options = basculerOption(groupe, _options, optionId);
                    _erreur = null;
                  }),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const Divider(height: 1),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Refus du serveur en priorité, sinon ce qu'il reste à choisir.
                if (_erreur != null || (motif == null && erreurChoix != null))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      _erreur ?? erreurChoix!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: _erreur != null
                            ? Config.couleurErreur
                            : Config.couleurTexteSecondaire,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Moins',
                      onPressed: motif == null && quantite > 1
                          ? () => setState(() => _quantite = quantite - 1)
                          : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$quantite', style: theme.textTheme.titleMedium),
                    IconButton(
                      tooltip: 'Plus',
                      // Menu du jour : jamais plus que le stock restant.
                      onPressed:
                          motif == null && (stock == null || quantite < stock)
                          ? () => setState(() => _quantite = quantite + 1)
                          : null,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        onPressed: peutAjouter
                            ? () => _ajouter(
                                plat: plat,
                                ligne: ligne,
                                variante: variante,
                                quantite: quantite,
                              )
                            : null,
                        child: _envoi
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                motif != null
                                    ? 'Indisponible'
                                    : 'Ajouter au panier · '
                                          '${formatMontant(total)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Photos du plat en carrousel, avec le bouton de fermeture de la feuille.
class _Photos extends StatelessWidget {
  const _Photos({required this.plat});

  final Plat plat;

  @override
  Widget build(BuildContext context) {
    final fermer = Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton.filledTonal(
        icon: const Icon(Icons.close),
        tooltip: 'Fermer',
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
    if (plat.images.isEmpty) {
      return Align(alignment: Alignment.centerRight, child: fermer);
    }
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CarrouselImages(images: plat.images, titre: plat.nom),
          Align(alignment: Alignment.topRight, child: fermer),
        ],
      ),
    );
  }
}

/// Encadré expliquant pourquoi le plat ne peut pas être commandé.
class _Explication extends StatelessWidget {
  const _Explication(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Config.couleurErreur.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Config.couleurErreur.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Config.couleurErreur, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Config.couleurErreur,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitreGroupe extends StatelessWidget {
  const _TitreGroupe({required this.titre, required this.contrainte});

  final String titre;
  final String contrainte;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Config.couleurFond,
      child: Row(
        children: [
          Expanded(
            child: Text(
              titre,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            contrainte,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Config.couleurTexteSecondaire,
            ),
          ),
        ],
      ),
    );
  }
}

/// Un groupe d'options : boutons radio si un seul choix est possible, cases
/// à cocher sinon.
class _GroupeOptions extends StatelessWidget {
  const _GroupeOptions({
    required this.groupe,
    required this.choix,
    required this.onBasculer,
  });

  final GroupeOptions groupe;
  final Set<int> choix;
  final ValueChanged<int> onBasculer;

  Widget? _surcout(BuildContext context, OptionPlat option) =>
      option.prixSupplement > 0
      ? Text(
          formatSupplement(option.prixSupplement),
          style: Theme.of(context).textTheme.bodyMedium,
        )
      : null;

  @override
  Widget build(BuildContext context) {
    final titre = _TitreGroupe(
      titre: groupe.libelle,
      contrainte: libelleContrainte(groupe),
    );
    if (estChoixUnique(groupe)) {
      final choisie = groupe.options
          .where((o) => choix.contains(o.id))
          .firstOrNull;
      return Column(
        children: [
          titre,
          RadioGroup<int>(
            groupValue: choisie?.id,
            // null = l'option choisie vient d'être décochée.
            onChanged: (id) {
              final cible = id ?? choisie?.id;
              if (cible != null) onBasculer(cible);
            },
            child: Column(
              children: [
                for (final option in groupe.options)
                  RadioListTile<int>(
                    value: option.id,
                    dense: true,
                    // Un choix facultatif peut être retiré.
                    toggleable: groupe.minChoix < 1,
                    title: Text(option.nom),
                    secondary: _surcout(context, option),
                  ),
              ],
            ),
          ),
        ],
      );
    }
    final plein =
        groupe.options.where((o) => choix.contains(o.id)).length >=
        maxChoix(groupe);
    return Column(
      children: [
        titre,
        for (final option in groupe.options)
          CheckboxListTile(
            value: choix.contains(option.id),
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
            // Plafond atteint : seules les options cochées restent actives.
            enabled: !plein || choix.contains(option.id),
            onChanged: (_) => onBasculer(option.id),
            title: Text(option.nom),
            secondary: _surcout(context, option),
          ),
      ],
    );
  }
}

/// Le plat a disparu de la carte entre-temps (rafraîchissement).
class _PlatRetire extends StatelessWidget {
  const _PlatRetire();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Ce plat n'est plus proposé."),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }
}
