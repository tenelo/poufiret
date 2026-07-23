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
    @JsonKey(name: 'duree_affichage_secondes') @Default(5) int dureeAffichageSecondes,
    @Default(0) int priorite,
  }) = _PubliciteListe;

  factory PubliciteListe.fromJson(Map<String, dynamic> json) =>
      _$PubliciteListeFromJson(json);

  /// Durée d'un passage, bornée pour éviter les valeurs aberrantes.
  Duration get dureePassage =>
      Duration(seconds: dureeAffichageSecondes.clamp(2, 30));
}
