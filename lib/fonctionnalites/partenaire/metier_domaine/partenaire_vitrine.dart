import 'package:freezed_annotation/freezed_annotation.dart';

import '../../geo/metier_domaine/localisation.dart';

part 'partenaire_vitrine.freezed.dart';
part 'partenaire_vitrine.g.dart';

@freezed
abstract class PartenaireVitrine with _$PartenaireVitrine {
  const PartenaireVitrine._();

  const factory PartenaireVitrine({
    required int id,
    @JsonKey(name: 'nom_commerce') @Default('') String nomCommerce,
    @JsonKey(name: 'type_partenaire') @Default('') String typePartenaire,
    @JsonKey(name: 'type_partenaire_libelle') @Default('') String typeLibelle,
    @Default('') String description,
    String? logo,
    @JsonKey(name: 'photo_couverture') String? photoCouverture,
    @Default('') String adresse,
    @Default('') String quartier,
    @Default('') String secteur,
    @Default('') String ville,
    @Default('') String departement,
    @Default('') String region,

    // Rattachement a la geographie de l'admin ; `ville` et `quartier`
    // ci-dessus sont les anciens textes, gardes en repli.
    @JsonKey(name: 'localite_id') int? localiteId,
    @JsonKey(name: 'localite_nom') String? localiteNom,
    @JsonKey(name: 'quartier_id') int? quartierId,
    @JsonKey(name: 'quartier_nom') String? quartierNom,
    @JsonKey(name: 'description_acces') @Default('') String descriptionAcces,
    @JsonKey(name: 'telephone_pro') @Default('') String telephonePro,
    @Default('') String whatsapp,
    @JsonKey(name: 'email_pro') @Default('') String emailPro,
    @JsonKey(name: 'nb_vues') @Default(0) int nbVues,
    @JsonKey(name: 'nombre_likes') @Default(0) int nombreLikes,
    @JsonKey(name: 'est_like_par_moi') @Default(false) bool estLikeParMoi,
    @JsonKey(name: 'est_favori_par_moi') @Default(false) bool estFavoriParMoi,
  }) = _PartenaireVitrine;

  factory PartenaireVitrine.fromJson(Map<String, dynamic> json) =>
      _$PartenaireVitrineFromJson(json);

  /// « Quartier, Localité (Département) », avec repli sur les anciens textes.
  String get localisationLisible => formatLocalisation(
    quartierNom: quartierNom,
    localiteNom: localiteNom,
    departement: departement,
    ancienQuartier: quartier,
    ancienneVille: ville,
  );
}
