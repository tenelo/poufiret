import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Affichage de la grille des catégories de l'accueil (bouton flottant) :
/// [images] montre l'image de la catégorie si elle en a une, sinon son
/// icône ; [icones] montre l'icône partout, sans télécharger d'image.
enum ModeGrille { images, icones }

/// Mode choisi par l'utilisateur, mémorisé sur l'appareil.
final modeGrilleProvider = NotifierProvider<ModeGrilleNotifier, ModeGrille>(
  ModeGrilleNotifier.new,
);

/// Valeur lue au démarrage par main.dart avant le premier rendu, pour ne pas
/// afficher les images une fraction de seconde avant de passer aux icônes.
final modeGrilleInitialProvider = Provider<ModeGrille>(
  (ref) => ModeGrille.images,
);

class ModeGrilleNotifier extends Notifier<ModeGrille> {
  static const _cle = 'poufiret_mode_grille';
  static const _stockage = FlutterSecureStorage();

  /// Lit le mode mémorisé (images par défaut, ou en cas d'erreur).
  static Future<ModeGrille> lire() async {
    try {
      final valeur = await _stockage.read(key: _cle);
      return ModeGrille.values.firstWhere(
        (m) => m.name == valeur,
        orElse: () => ModeGrille.images,
      );
    } catch (_) {
      return ModeGrille.images;
    }
  }

  @override
  ModeGrille build() => ref.read(modeGrilleInitialProvider);

  /// Passe d'un mode à l'autre et le mémorise.
  Future<void> basculer() async {
    state = state == ModeGrille.images ? ModeGrille.icones : ModeGrille.images;
    try {
      await _stockage.write(key: _cle, value: state.name);
    } catch (_) {
      // Non mémorisé : le choix vaut pour la session en cours.
    }
  }
}
