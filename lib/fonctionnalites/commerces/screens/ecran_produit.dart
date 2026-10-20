import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../../global/ui/liens_externes.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../restaurants/metier_domaine/commande_plat.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../donnees/commerces_providers.dart';
import '../metier_domaine/fiche_produit.dart';
import '../metier_domaine/gabarits.dart';
import '../widgets/ajout_panier.dart';
import '../widgets/galerie_miniatures.dart';
import '../widgets/tuiles_produits.dart';

/// Fiche d'un produit de commerce : galerie à miniatures, informations du
/// gabarit (pointures, auteur, forme et dosage...), prix selon la variante,
/// ajout au panier (ou appel de la pharmacie), puis autres produits.
class EcranProduit extends ConsumerWidget {
  const EcranProduit({
    super.key,
    required this.produitId,
    required this.gabarit,
    this.titre = '',
    this.telephoneCommerce = '',
  });

  final int produitId;
  final Gabarit gabarit;

  /// Nom déjà connu, affiché pendant le chargement.
  final String titre;

  /// Numéro du commerce : « Appeler la pharmacie » d'un produit sur
  /// ordonnance.
  final String telephoneCommerce;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = produitDetailProvider(id: produitId);
    return ref
        .watch(provider)
        .when(
          skipLoadingOnReload: true,
          loading: () => Scaffold(
            appBar: AppBar(title: Text(titre)),
            body: const SqueletteDetailArticle(),
          ),
          error: (err, _) => Scaffold(
            appBar: AppBar(title: Text(titre)),
            body: MessageErreur(
              message: messageErreurApi(
                err,
                repli: 'Impossible de charger ce produit.',
              ),
              onReessayer: () => ref.invalidate(provider),
            ),
          ),
          data: (detail) => _Fiche(
            produit: detail.produit,
            autres: detail.autres,
            gabarit: gabarit,
            telephone: telephoneCommerce,
          ),
        );
  }
}

/// Libellés propres au gabarit.
extension on Gabarit {
  String get titreVariantes => switch (this) {
    Gabarit.mode => 'Pointure',
    _ => 'Choix',
  };

  String get consigneVariante => this == Gabarit.mode
      ? 'Choisissez une pointure'
      : 'Choisissez une option';

  String get titreAutres => switch (this) {
    Gabarit.mode => 'Autres articles',
    Gabarit.librairie => 'Autres livres',
    _ => 'Autres produits',
  };

  double get ratioPhoto => this == Gabarit.librairie ? 3 / 4 : 1;

  IconData get icone => switch (this) {
    Gabarit.pharmacie => Icons.medication_outlined,
    Gabarit.mode => Icons.checkroom_outlined,
    Gabarit.librairie => Icons.menu_book_outlined,
    _ => Icons.bakery_dining_outlined,
  };
}

/// Informations « libellé · valeur » d'un produit, selon son gabarit.
List<(String, String)> informationsProduit(Plat p, Gabarit gabarit) => [
  ...switch (gabarit) {
    Gabarit.mode => [
      ('Marque', p.marque),
      ('Couleur', p.couleur),
      ('Matière', p.matiere),
      ('Genre', p.genre),
    ],
    Gabarit.librairie => [
      ('Auteur', p.auteur),
      ('Éditeur', p.editeur),
      ('Année', p.annee),
      ('ISBN', p.isbn),
      ('Langue', p.langue),
      ('Niveau et classe', p.niveauClasse),
      ('État', p.etatLivre),
    ],
    Gabarit.pharmacie => [
      ('Forme et dosage', p.formeDosage),
      ('Laboratoire', p.laboratoire),
    ],
    _ => const <(String, String)>[],
  },
].where((e) => e.$2.isNotEmpty).toList();

class _Fiche extends ConsumerStatefulWidget {
  const _Fiche({
    required this.produit,
    required this.autres,
    required this.gabarit,
    required this.telephone,
  });

  final Plat produit;
  final List<Plat> autres;
  final Gabarit gabarit;
  final String telephone;

  @override
  ConsumerState<_Fiche> createState() => _FicheState();
}

class _FicheState extends ConsumerState<_Fiche> {
  int? _varianteId;
  bool _envoi = false;

  Plat get _p => widget.produit;

  /// Variante retenue : celle choisie, sinon (hors mode, où la pointure se
  /// choisit) la variante par défaut si elle est en stock.
  VariantePlat? get _variante {
    final variantes = _p.variantesActives;
    final choisie = variantes.where((v) => v.id == _varianteId).firstOrNull;
    if (choisie != null && !choisie.epuisee) return choisie;
    if (widget.gabarit == Gabarit.mode) return null;
    final defaut = varianteParDefaut(_p);
    if (defaut != null && !defaut.epuisee) return defaut;
    return variantes.where((v) => !v.epuisee).firstOrNull;
  }

  Future<void> _ajouter(VariantePlat? variante) async {
    setState(() => _envoi = true);
    await ajouterProduitAuPanier(context, ref, produit: _p, variante: variante);
    if (mounted) setState(() => _envoi = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = _p;
    final g = widget.gabarit;
    final variantes = p.variantesActives;
    final variante = _variante;
    final prix = variante == null
        ? prixLisible(p)
        : formatMontant(p.prixEffectif + variante.prixSupplement);
    final surTitre = switch (g) {
      Gabarit.mode => p.marque,
      Gabarit.librairie => p.auteur,
      _ => '',
    };
    final mention = [
      if (p.surOrdonnance) 'Sur ordonnance',
      p.mentionSurCommande,
    ].where((m) => m.isNotEmpty).join(' · ');

    return Scaffold(
      appBar: AppBar(title: Text(p.nom)),
      bottomNavigationBar: _BarreAction(
        produit: p,
        variante: variante,
        exigeVariante: variantes.isNotEmpty,
        consigneVariante: g.consigneVariante,
        telephone: widget.telephone,
        envoi: _envoi,
        onAjouter: () => _ajouter(variante),
      ),
      body: LayoutBuilder(
        builder: (context, contraintes) {
          final largeur = contraintes.maxWidth > 700
              ? 700.0
              : contraintes.maxWidth;
          return Center(
            child: SizedBox(
              width: largeur,
              child: RefreshIndicator(
                onRefresh: () =>
                    rafraichir(ref, produitDetailProvider(id: p.id)),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    GalerieMiniatures(
                      images: p.images,
                      titre: p.nom,
                      ratio: g.ratioPhoto,
                      iconeVide: g.icone,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (surTitre.isNotEmpty)
                            Text(
                              surTitre,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: Config.couleurTexteSecondaire,
                              ),
                            ),
                          Text(
                            p.nom,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            prix,
                            key: const ValueKey('prix-produit'),
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (mention.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                mention,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: p.surOrdonnance
                                      ? Config.couleurErreur
                                      : Config.couleurTexteSecondaire,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (variantes.isNotEmpty)
                      _Section(
                        titre: g.titreVariantes,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final v in variantes)
                              ChoiceChip(
                                key: ValueKey('variante-${v.id}'),
                                label: Text(v.nom),
                                selected: v.id == variante?.id,
                                // Épuisée : grisée, non sélectionnable.
                                onSelected: v.epuisee
                                    ? null
                                    : (_) => setState(() => _varianteId = v.id),
                                tooltip: v.epuisee ? '${v.nom} : épuisé' : null,
                              ),
                          ],
                        ),
                      ),
                    if (informationsProduit(p, g) case final infos
                        when infos.isNotEmpty)
                      _Section(
                        titre: 'Informations',
                        child: Column(
                          children: [
                            for (final (libelle, valeur) in infos)
                              _Info(libelle, valeur),
                          ],
                        ),
                      ),
                    if (p.description.isNotEmpty)
                      _Section(
                        titre: 'Description',
                        child: Text(p.description),
                      ),
                    if (widget.autres.isNotEmpty)
                      _Section(
                        titre: g.titreAutres,
                        child: SizedBox(
                          height: 250,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.autres.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, i) {
                              final autre = widget.autres[i];
                              return SizedBox(
                                width: 150,
                                child: TuileGrilleProduit(
                                  key: ValueKey('autre-${autre.id}'),
                                  produit: autre,
                                  surTitre: g == Gabarit.mode
                                      ? autre.marque
                                      : g == Gabarit.librairie
                                      ? autre.auteur
                                      : '',
                                  icone: g.icone,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => EcranProduit(
                                        produitId: autre.id,
                                        gabarit: g,
                                        titre: autre.nom,
                                        telephoneCommerce: widget.telephone,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Bas de fiche : « Ajouter au panier · prix », « Appeler la pharmacie »
/// pour un produit sur ordonnance, rien si le produit n'est pas commandable.
class _BarreAction extends StatelessWidget {
  const _BarreAction({
    required this.produit,
    required this.variante,
    required this.exigeVariante,
    required this.consigneVariante,
    required this.telephone,
    required this.envoi,
    required this.onAjouter,
  });

  final Plat produit;
  final VariantePlat? variante;
  final bool exigeVariante;
  final String consigneVariante;
  final String telephone;
  final bool envoi;
  final VoidCallback onAjouter;

  @override
  Widget build(BuildContext context) {
    final p = produit;
    final Widget bouton;
    if (p.surOrdonnance) {
      if (telephone.isEmpty) return const SizedBox.shrink();
      bouton = FilledButton.icon(
        onPressed: () => ouvrirLien(context, uriAppel(telephone)),
        icon: const Icon(Icons.call),
        label: const Text('Appeler la pharmacie'),
      );
    } else if (!p.commandable) {
      return const SizedBox.shrink();
    } else {
      final epuise = p.toutEpuise;
      final manque = exigeVariante && variante == null;
      final prix = variante == null
          ? prixAPartirDe(p)
          : p.prixEffectif + variante!.prixSupplement;
      bouton = FilledButton(
        onPressed: epuise || manque || envoi ? null : onAjouter,
        child: envoi
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                epuise
                    ? 'Épuisé'
                    : manque
                    ? consigneVariante
                    : 'Ajouter au panier · ${formatMontant(prix)}',
              ),
      );
    }
    return SafeArea(
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: SizedBox(width: double.infinity, child: bouton),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.titre, required this.child});

  final String titre;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titre,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info(this.libelle, this.valeur);

  final String libelle;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              libelle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Config.couleurTexteSecondaire,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              valeur,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
