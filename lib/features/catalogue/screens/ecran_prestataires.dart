import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poufiret/core/errors/api_exception.dart';
import 'package:poufiret/features/catalogue/data/catalogue_providers.dart';
import 'package:poufiret/features/catalogue/domain/partenaire_categorie.dart';
import 'package:poufiret/features/catalogue/screens/ecran_articles.dart';
import 'package:poufiret/features/partenaire/screens/ecran_vitrine_partenaire.dart';
import 'package:poufiret/features/analytics/data/analytics_providers.dart';
import 'package:poufiret/features/chat/data/chat_providers.dart';
import 'package:poufiret/features/chat/screens/ecran_discussion.dart';

/// Annuaire d'une catégorie : les prestataires/commerces (couverture + nom).
/// Le client choisit un commerce avant de voir ses articles.
class EcranPrestataires extends ConsumerWidget {
  const EcranPrestataires({
    super.key,
    required this.categorieId,
    required this.categorieNom,
    required this.categorieSlug,
    this.modeTransaction = '',
    this.afficheCatalogue = true,
  });

  /// Faux pour les metiers de service pur : on va droit a la fiche partenaire.
  final bool afficheCatalogue;

  final int categorieId;
  final String categorieNom;
  final String categorieSlug;
  final String modeTransaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // L affichage de la liste des prestataires = une visite de categorie.
    ref.watch(visiteCategorieProvider(categorieId: categorieId));
    final annuaireAsync =
        ref.watch(partenairesParCategorieProvider(slug: categorieSlug));
    return Scaffold(
      appBar: AppBar(title: Text(categorieNom)),
      body: annuaireAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) {
          final message = err is ApiException
              ? err.messageLisible
              : 'Erreur de chargement.';
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(
                      partenairesParCategorieProvider(slug: categorieSlug)),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        },
        data: (prestataires) {
          if (prestataires.isEmpty) {
            return const Center(
              child: Text('Aucun prestataire dans cette catégorie.'),
            );
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur = contraintes.maxWidth > 700
                  ? 700.0
                  : contraintes.maxWidth;
              // Colonnes selon la largeur disponible (tuiles ~330px).
              final colonnes = (largeur / 330).floor().clamp(1, 2);
              return Center(
                child: SizedBox(
                  width: largeur,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: colonnes,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 16 / 11,
                    ),
                    itemCount: prestataires.length,
                    itemBuilder: (context, i) => _CartePrestataire(
                      prestataire: prestataires[i],
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => afficheCatalogue
                                ? EcranArticles(
                                    categorieId: categorieId,
                                    categorieNom:
                                        prestataires[i].nomCommerce,
                                    modeTransaction: modeTransaction,
                                    partenaireId: prestataires[i].id,
                                  )
                                : EcranVitrinePartenaire(
                                    partenaireId: prestataires[i].id,
                                    modeTransaction: modeTransaction,
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CartePrestataire extends ConsumerWidget {
  const _CartePrestataire({required this.prestataire, required this.onTap});

  final PartenaireCategorie prestataire;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Photo de couverture (ou fond neutre si absente).
            Expanded(
              child: prestataire.photoCouverture.isNotEmpty
                  ? Image.network(
                      prestataire.photoCouverture,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          _FondNeutre(theme: theme),
                    )
                  : _FondNeutre(theme: theme),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  if (prestataire.logo.isNotEmpty) ...[
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(prestataire.logo),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      prestataire.nomCommerce,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.whatsapp,
                        color: theme.colorScheme.primary),
                    tooltip: 'Discuter',
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      final nav = Navigator.of(context);
                      try {
                        final conv = await ref
                            .read(chatRepositoryProvider)
                            .contacter(partenaireId: prestataire.id);
                        nav.push(MaterialPageRoute(
                          builder: (_) => EcranDiscussion(
                            conversationId: conv.id,
                            titre: prestataire.nomCommerce,
                          ),
                        ));
                      } catch (_) {
                        messenger.showSnackBar(const SnackBar(
                            content: Text(
                                'Connexion requise pour discuter.')));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FondNeutre extends StatelessWidget {
  const _FondNeutre({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(Icons.storefront,
          size: 48, color: theme.colorScheme.outline),
    );
  }
}
