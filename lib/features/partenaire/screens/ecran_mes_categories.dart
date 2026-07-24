import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/config/config.dart';
import '../../../core/errors/api_exception.dart';
import '../data/espace_partenaire_providers.dart';
import '../domain/ma_categorie.dart';
import '../../../core/widgets/image_reseau.dart';

/// Categories du partenaire : il y depose une image differente par
/// categorie, celle que les clients verront dans l'annuaire.
class EcranMesCategories extends ConsumerWidget {
  const EcranMesCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(mesCategoriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes catégories')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(err is ApiException
                    ? err.messageLisible
                    : 'Erreur de chargement.'),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => ref.invalidate(mesCategoriesProvider),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
        data: (categories) {
          if (categories.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Vous n\'êtes rattaché à aucune catégorie.\n'
                  'Contactez l\'administration Poufiret.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return LayoutBuilder(
            builder: (context, contraintes) {
              final largeur =
                  contraintes.maxWidth > 700 ? 700.0 : contraintes.maxWidth;
              return Center(
                child: SizedBox(
                  width: largeur,
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        ref.invalidate(mesCategoriesProvider),
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(4, 0, 4, 12),
                          child: Text(
                            'Choisissez une image par catégorie. C\'est '
                            'celle que les clients verront en vous '
                            'cherchant dans cette catégorie.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Config.couleurTexteSecondaire,
                            ),
                          ),
                        ),
                        for (final c in categories)
                          _CarteCategorie(categorie: c),
                      ],
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

class _CarteCategorie extends ConsumerStatefulWidget {
  const _CarteCategorie({required this.categorie});
  final MaCategorie categorie;

  @override
  ConsumerState<_CarteCategorie> createState() => _CarteCategorieState();
}

class _CarteCategorieState extends ConsumerState<_CarteCategorie> {
  bool _envoi = false;

  Future<void> _changerImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (image == null || !mounted) return;

    setState(() => _envoi = true);
    try {
      await ref
          .read(espacePartenaireRepositoryProvider)
          .changerImageCategorie(widget.categorie.id, image.path);
      ref.invalidate(mesCategoriesProvider);
      _message('Image mise à jour.');
    } on ApiException catch (e) {
      _message(e.messageLisible);
    } catch (_) {
      _message('Envoi impossible. Réessayez.');
    } finally {
      if (mounted) setState(() => _envoi = false);
    }
  }

  void _message(String texte) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(texte)));
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.categorie;
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (c.aUneImage)
                  ImageReseau(
                    c.imageCouverture!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, e, s) => _Vide(),
                  )
                else
                  _Vide(),
                if (_envoi)
                  Container(
                    color: Colors.black38,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: Text(
              c.icone.isNotEmpty ? c.icone : '📦',
              style: const TextStyle(fontSize: 26),
            ),
            title: Row(
              children: [
                Flexible(
                  child: Text(c.nom,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                if (c.estPrincipale) ...[
                  const SizedBox(width: 6),
                  const Icon(Icons.star,
                      size: 16, color: Config.couleurPrimaire),
                ],
              ],
            ),
            subtitle: Text(
              c.aUneImage
                  ? 'Image personnalisée'
                  : 'Aucune image — votre photo de profil sera utilisée',
              style: theme.textTheme.bodySmall,
            ),
            trailing: TextButton.icon(
              onPressed: _envoi ? null : _changerImage,
              icon: const Icon(Icons.photo_camera_outlined, size: 18),
              label: Text(c.aUneImage ? 'Changer' : 'Ajouter'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Vide extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        color: Config.couleurFond,
        child: const Center(
          child: Icon(Icons.image_outlined,
              size: 36, color: Config.couleurTexteSecondaire),
        ),
      );
}
