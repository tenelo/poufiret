import 'package:freezed_annotation/freezed_annotation.dart';
part 'publicite_liste.freezed.dart';
part 'publicite_liste.g.dart';

/// Publicité en diffusion (carrousel, page Publicités, bandeau bas).
@freezed
abstract class PubliciteListe with _$PubliciteListe {
  const PubliciteListe._();

  const factory PubliciteListe({
    required String id,
    @Default('') String titre,
    @JsonKey(name: 'image_couverture') String? imageCouverture,
    @JsonKey(name: 'partenaire_id') int? partenaireId,
    @JsonKey(name: 'duree_affichage_secondes')
    @Default(5)
    int dureeAffichageSecondes,
    @Default(0) int priorite,
    // Fin de diffusion (ISO 8601), si le serveur l'expose : sert a ne jamais
    // afficher une pub deja terminee, notamment depuis le cache disque.
    @JsonKey(name: 'fin_diffusion') String? finDiffusion,
  }) = _PubliciteListe;

  factory PubliciteListe.fromJson(Map<String, dynamic> json) =>
      _$PubliciteListeFromJson(json);

  /// Vrai si la diffusion est terminee (fin_diffusion depassee). Sans date
  /// (ou illisible), on ne peut pas conclure : la pub reste affichable.
  bool diffusionTerminee([DateTime? maintenant]) {
    final fin = DateTime.tryParse(finDiffusion ?? '');
    if (fin == null) return false;
    return !fin.isAfter(maintenant ?? DateTime.now());
  }

  /// Durée d'un passage dans le carrousel : fixe, identique pour toutes les
  /// pubs (le champ duree_affichage_secondes du backend n'est plus utilisé).
  Duration get dureePassage => const Duration(milliseconds: 3500);
}
