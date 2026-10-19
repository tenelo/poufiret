import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/prix_promo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/config.dart';
import '../../../global/errors/api_exception.dart';
import '../../partenaire/screens/ecran_vitrine_partenaire.dart';
import '../donnees/catalogue_providers.dart';
import '../metier_domaine/resultats_recherche.dart';
import 'aiguillage_categorie.dart';
import 'ecran_article_detail.dart';
import '../../../global/widgets/image_reseau.dart';
import '../../auth/widgets/mur_inscription.dart';
import '../../auth/screens/auth_notifier.dart';
import '../../../global/ui/notificateur.dart';
import '../../restaurants/screens/ecran_restaurant.dart';
import '../../restaurants/widgets/feuille_plat.dart';
import '../metier_domaine/article_detail.dart';
import '../metier_domaine/categorie.dart';

/// Recherche unifiee : categories, partenaires, articles.
///
/// L'ordre n'est pas anodin. Poufiret est un annuaire avant d'etre un
/// catalogue : un terme generique ("chaussure", "plombier") cherche un
/// metier, un terme precis ("doliprane") cherche un produit. On montre
/// les deux chemins et le client choisit.
class EcranRecherche extends ConsumerStatefulWidget {
  const EcranRecherche({super.key});

  @override
  ConsumerState<EcranRecherche> createState() => _EcranRechercheState();
}

class _EcranRechercheState extends ConsumerState<EcranRecherche> {
  final _controleur = TextEditingController();
  Timer? _debounce;
  String _terme = '';

  void _surSaisie(String valeur) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (mounted) setState(() => _terme = valeur.trim());
    });
  }

  void _effacer() {
    _debounce?.cancel();
    _controleur.clear();
    setState(() => _terme = '');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controleur.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controleur,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onChanged: _surSaisie,
              decoration: InputDecoration(
                hintText: 'Un métier, un commerce, un produit…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _controleur.text.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: _effacer,
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: _terme.length < 2
                ? const _Invite()
                : _Resultats(terme: _terme),
          ),
        ],
      ),
    );
  }
}

class _Invite extends StatelessWidget {
  const _Invite();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search,
                size: 64, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'Cherchez un métier (plombier, coiffure),\n'
              'un commerce, ou un produit précis.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _Resultats extends ConsumerWidget {
  const _Resultats({required this.terme});
  final String terme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(rechercheUnifieeProvider(terme: terme));
    final connecte = ref.watch(authProvider).value != null;

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(err is ApiException
                  ? err.messageLisible
                  : 'Erreur lors de la recherche.'),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () =>
                    ref.invalidate(rechercheUnifieeProvider(terme: terme)),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
      data: (r) {
        if (r.estVide) return _Aucun(terme: terme);

        return LayoutBuilder(
          builder: (context, contraintes) {
            final largeur =
                contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
            return Center(
              child: SizedBox(
                width: largeur,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 24),
                  children: [
                    if (r.categories.isNotEmpty) ...[
                      const _TitreSection(
                          titre: 'Catégories', icone: Icons.category_outlined),
                      for (final c in r.categories) _LigneCategorie(categorie: c),
                    ],
                    if (r.partenaires.isNotEmpty) ...[
                      const _TitreSection(
                          titre: 'Commerces',
                          icone: Icons.storefront_outlined),
                      for (final p in r.partenaires)
                        _LignePartenaire(partenaire: p, connecte: connecte),
                    ],
                    if (r.articles.isNotEmpty) ...[
                      const _TitreSection(
                          titre: 'Produits',
                          icone: Icons.shopping_bag_outlined),
                      for (final a in r.articles)
                        _LigneArticle(article: a, connecte: connecte),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TitreSection extends StatelessWidget {
  const _TitreSection({required this.titre, required this.icone});
  final String titre;
  final IconData icone;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
        child: Row(
          children: [
            Icon(icone, size: 16, color: Config.couleurPrimaire),
            const SizedBox(width: 8),
            Text(
              titre,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Config.couleurPrimaire,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      );
}

class _LigneCategorie extends StatelessWidget {
  const _LigneCategorie({required this.categorie});
  final CategorieTrouvee categorie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        categorie.icone.isNotEmpty ? categorie.icone : '📦',
        style: const TextStyle(fontSize: 28),
      ),
      title: Text(categorie.nom,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: const Text('Voir tous les professionnels'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => EcranCategorieTrouvee(categorie: categorie),
        ),
      ),
    );
  }
}

class _LignePartenaire extends StatelessWidget {
  const _LignePartenaire({required this.partenaire, required this.connecte});
  final bool connecte;
  final PartenaireTrouve partenaire;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Config.couleurFond,
        backgroundImage: partenaire.logo.isNotEmpty
            ? imageReseauProvider(partenaire.logo)
            : null,
        child: partenaire.logo.isEmpty
            ? Icon(Icons.storefront_outlined,
                color: Config.couleurTexteSecondaire)
            : null,
      ),
      title: Text(partenaire.nomCommerce,
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        partenaire.typePartenaire,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => murInscriptionSi(
        context,
        connecte: connecte,
        action: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) =>
                EcranVitrinePartenaire(partenaireId: partenaire.id),
          ),
        ),
      ),
    );
  }
}

/// Un produit trouvé. Toucher : son ajout au panier, directement — la
/// feuille plat (variantes, options, quantité) pour un plat de restaurant,
/// le parcours habituel de la fiche produit sinon. « Voir le partenaire »
/// mène à sa page.
class _LigneArticle extends ConsumerStatefulWidget {
  const _LigneArticle({required this.article, required this.connecte});
  final bool connecte;
  final ArticleTrouve article;

  @override
  ConsumerState<_LigneArticle> createState() => _LigneArticleState();
}

class _LigneArticleState extends ConsumerState<_LigneArticle> {
  bool _chargement = false;

  /// Fiche détaillée (cache d'abord) : elle seule dit s'il s'agit d'un plat
  /// et chez quel partenaire.
  Future<ArticleDetail?> _detail() async {
    if (_chargement) return null;
    setState(() => _chargement = true);
    try {
      return await ref.read(
        articleDetailProvider(slug: widget.article.slug).future,
      );
    } catch (e) {
      if (mounted) {
        Notificateur.erreur(
          context,
          e is ApiException ? e.messageLisible : 'Erreur de chargement.',
        );
      }
      return null;
    } finally {
      if (mounted) setState(() => _chargement = false);
    }
  }

  static bool _estPlat(ArticleDetail d) =>
      d.type == 'plat' && d.partenaire != null;

  Future<void> _ajouter() async {
    final detail = await _detail();
    if (detail == null || !mounted) return;
    if (_estPlat(detail)) {
      await ouvrirFeuillePlat(
        context,
        restaurantId: detail.partenaire!,
        platId: detail.id,
      );
      return;
    }
    // Autre produit : la fiche produit, avec le mode de sa catégorie (son
    // bouton « Commander » ajoute au panier).
    String mode = '';
    try {
      final categories = await ref.read(categoriesProvider.future);
      mode = categories.feuilles
              .where((c) => c.id == detail.categorie)
              .firstOrNull
              ?.modeTransaction ??
          '';
    } catch (_) {
      // Catégories indisponibles : fiche en mode « Contacter ».
    }
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            EcranArticleDetail(slug: detail.slug, modeTransaction: mode),
      ),
    );
  }

  Future<void> _voirPartenaire() async {
    final detail = await _detail();
    final id = detail?.partenaire;
    if (detail == null || id == null || !mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _estPlat(detail)
            ? EcranRestaurant(
                restaurantId: id,
                nom: detail.partenaireNom,
                siIntrouvable: EcranVitrinePartenaire(partenaireId: id),
              )
            : EcranVitrinePartenaire(partenaireId: id),
      ),
    );
  }

  void _siConnecte(Future<void> Function() action) => murInscriptionSi(
    context,
    connecte: widget.connecte,
    action: action,
  );

  @override
  Widget build(BuildContext context) {
    final article = widget.article;
    return ListTile(
      leading: SizedBox(
        width: 48,
        height: 48,
        child: article.imagePrincipale.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ImageReseau(
                  article.imagePrincipale,
                  fit: BoxFit.cover,
                  errorBuilder: (_, e, s) => const _Vignette(),
                ),
              )
            : const _Vignette(),
      ),
      title:
          Text(article.nom, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.departement.isNotEmpty
                ? '${article.partenaireNom} · ${article.departement}'
                : article.partenaireNom,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _siConnecte(_voirPartenaire),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'Voir le partenaire',
                style: TextStyle(
                  color: Config.couleurSecondaire,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      trailing: _chargement
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : PrixPromo(
              prixNormal: article.prixNormal,
              prixEffectif: article.prixEffectif,
              pourcentageReduction: article.pourcentageReduction,
              taillePrix: 14,
              aligneADroite: true,
            ),
      onTap: () => _siConnecte(_ajouter),
    );
  }
}

class _Vignette extends StatelessWidget {
  const _Vignette();

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Config.couleurFond,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.image_outlined,
            size: 22, color: Config.couleurTexteSecondaire),
      );
}

class _Aucun extends StatelessWidget {
  const _Aucun({required this.terme});
  final String terme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off,
                size: 56, color: theme.colorScheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'Aucun résultat pour « $terme ».',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 6),
            Text(
              'Essayez un autre mot : le nom du métier, '
              'du commerce, ou du produit.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}
