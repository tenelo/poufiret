import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/cache/contexte_cache.dart';
import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../../global/ui/format_montant.dart';
import '../../analytics/donnees/service_suivi.dart';
import '../../../global/ui/squelette.dart';
import '../../../global/widgets/message_erreur.dart';
import '../../restaurants/metier_domaine/commande_plat.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import '../donnees/commerces_providers.dart';
import '../metier_domaine/elevage.dart';
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
            commerceId: detail.commerceId,
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
    Gabarit.elevage => Icons.agriculture_outlined,
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
    Gabarit.elevage => [
      ('Espèce', p.espece),
      ('État de vente', p.etatVente),
      ('Âge', p.age),
      (
        'Poids moyen',
        p.poidsMoyenKg == null
            ? ''
            : formatQuantite(p.poidsMoyenKg!, unite: 'kg'),
      ),
      (
        'Quantité disponible',
        p.quantiteDisponible == null
            ? ''
            : formatQuantiteUnite(p.quantiteDisponible!, p.unitePrix),
      ),
      (
        'Délai de commande',
        p.commandeAvanceJours == null
            ? ''
            : "${p.commandeAvanceJours} ${p.commandeAvanceJours! > 1 ? 'jours' : 'jour'} à l'avance",
      ),
      ('Livraison', p.livraisonPossible ? 'Possible' : 'Non proposée'),
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
    this.commerceId,
  });

  final Plat produit;
  final List<Plat> autres;
  final Gabarit gabarit;
  final String telephone;

  /// Commerce du produit (pour noter l'appel).
  final int? commerceId;

  @override
  ConsumerState<_Fiche> createState() => _FicheState();
}

class _FicheState extends ConsumerState<_Fiche> {
  int? _varianteId;
  bool _envoi = false;

  /// Pièces ou kg choisis (éleveur) ; null = un pas (1 pièce, 0,5 kg).
  num? _quantite;

  Plat get _p => widget.produit;

  bool get _elevage => widget.gabarit == Gabarit.elevage;

  /// Quantité retenue, sur la grille de l'unité et sous le stock.
  num get _quantiteRetenue => _elevage
      ? ajusterQuantite(
          _quantite ?? _p.unitePrix.pas,
          _p.unitePrix,
          max: _p.quantiteMax,
        )
      : 1;

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
    await ajouterProduitAuPanier(
      context,
      ref,
      produit: _p,
      variante: variante,
      quantite: _quantiteRetenue,
    );
    if (mounted) setState(() => _envoi = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = _p;
    final g = widget.gabarit;
    final variantes = p.variantesActives;
    final variante = _variante;
    final prixUnitaire = variante?.prixPour(p.prixEffectif) ?? p.prixEffectif;
    final prix = _elevage
        ? formatPrixUnite(prixUnitaire, p.unitePrix, suffixe: p.suffixePrix)
        : variante == null
        ? prixLisible(p)
        : formatMontant(prixUnitaire);
    final surTitre = switch (g) {
      Gabarit.mode => p.marque,
      Gabarit.librairie => p.auteur,
      Gabarit.elevage => p.espece,
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
        partenaireId: widget.commerceId,
        envoi: _envoi,
        elevage: _elevage,
        quantite: _quantiteRetenue,
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            prix,
                            key: const ValueKey('prix-produit'),
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
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
                    if (_elevage && p.commandable && !p.toutEpuise)
                      _Section(
                        titre: p.unitePrix == UnitePrix.kg
                            ? 'Poids (kg)'
                            : 'Nombre de ${p.unitePrix.libelle}s',
                        child: _SelecteurQuantite(
                          produit: p,
                          quantite: _quantiteRetenue,
                          prixUnitaire: prixUnitaire,
                          onChanged: (q) => setState(() => _quantite = q),
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
    this.partenaireId,
    this.elevage = false,
    this.quantite = 1,
  });

  /// Éleveur : total = prix unitaire × [quantite], et un bouton désactivé
  /// (plutôt qu'absent) quand le produit n'est pas commandable.
  final bool elevage;
  final num quantite;

  final Plat produit;
  final VariantePlat? variante;
  final bool exigeVariante;
  final String consigneVariante;
  final String telephone;
  final int? partenaireId;
  final bool envoi;
  final VoidCallback onAjouter;

  @override
  Widget build(BuildContext context) {
    final p = produit;
    final Widget bouton;
    if (p.surOrdonnance) {
      if (telephone.isEmpty) return const SizedBox.shrink();
      bouton = FilledButton.icon(
        onPressed: () =>
            appelerPartenaire(context, telephone, partenaireId: partenaireId),
        icon: const Icon(Icons.call_outlined),
        label: const Text('Appeler la pharmacie'),
      );
    } else if (!p.commandable && !elevage) {
      return const SizedBox.shrink();
    } else if (elevage) {
      final bloque = !p.commandable || p.toutEpuise;
      final total = totalElevage(
        variante?.prixPour(p.prixEffectif) ?? p.prixEffectif,
        quantite,
      );
      bouton = FilledButton(
        onPressed: bloque || envoi ? null : onAjouter,
        child: envoi
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(
                !p.commandable
                    ? 'Indisponible à la commande'
                    : p.toutEpuise
                    ? 'Épuisé'
                    : 'Ajouter au panier · ${formatMontant(total)}',
              ),
      );
    } else {
      final epuise = p.toutEpuise;
      final manque = exigeVariante && variante == null;
      final prix = variante == null
          ? prixAPartirDe(p)
          : variante!.prixPour(p.prixEffectif);
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
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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

/// Sélecteur « − quantité + » d'un produit d'éleveur (pièces entières ou
/// kg par 0,5), plafonné par le stock, avec le total recalculé en direct.
class _SelecteurQuantite extends StatelessWidget {
  const _SelecteurQuantite({
    required this.produit,
    required this.quantite,
    required this.prixUnitaire,
    required this.onChanged,
  });

  final Plat produit;
  final num quantite;
  final int prixUnitaire;
  final ValueChanged<num> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unite = produit.unitePrix;
    final max = produit.quantiteMax;
    final peutAjouter = max == null || quantite + unite.pas <= max;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton.outlined(
              tooltip: 'Moins',
              onPressed: quantite > unite.pas
                  ? () => onChanged(quantite - unite.pas)
                  : null,
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: 96,
              child: Text(
                formatQuantiteUnite(quantite, unite),
                key: const ValueKey('quantite-elevage'),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton.outlined(
              tooltip: 'Plus',
              onPressed: peutAjouter
                  ? () => onChanged(quantite + unite.pas)
                  : null,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          libelleTotalElevage(prixUnitaire, quantite, unite),
          key: const ValueKey('total-elevage'),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
