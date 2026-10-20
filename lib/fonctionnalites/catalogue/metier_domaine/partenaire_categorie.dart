import 'package:freezed_annotation/freezed_annotation.dart';

import '../../geo/metier_domaine/localisation.dart' as geo;

part 'partenaire_categorie.freezed.dart';
part 'partenaire_categorie.g.dart';

/// Type(s) de partenaire de la carte : `type_partenaire` (texte ou liste),
/// ou `types_partenaire`.
Object? _lireTypes(Map<dynamic, dynamic> json, String _) {
  final brut = json['type_partenaire'] ?? json['types_partenaire'];
  if (brut is List) return [for (final t in brut) if (t != null) '$t'];
  if (brut is String && brut.isNotEmpty) return [brut];
  return const <String>[];
}

/// Prestataire/commerce listé dans l'annuaire d'une catégorie.
@freezed
abstract class PartenaireCategorie with _$PartenaireCategorie {
  const factory PartenaireCategorie({
    required int id,
    @JsonKey(name: 'nom_commerce') @Default('') String nomCommerce,
    @Default('') String description,
    @Default('') String logo,
    @JsonKey(name: 'photo_couverture') @Default('') String photoCouverture,
    @Default('') String departement,
    @Default('') String region,
    double? latitude,
    double? longitude,
    @Default('') String adresse,
    @Default('') String quartier,
    @Default('') String ville,
    @Default('') String secteur,

    // Noms rattaches a la geographie de l'admin ; `ville` et `quartier`
    // ci-dessus sont les anciens textes, gardes en repli.
    @JsonKey(name: 'localite_nom') String? localiteNom,
    @JsonKey(name: 'quartier_nom') String? quartierNom,

    /// Gabarit de page dédiée (« pharmacie », « mode »...) ; vide sinon.
    @Default('') String gabarit,
    @JsonKey(readValue: _lireTypes)
    @Default(<String>[])
    List<String> typesPartenaire,
  }) = _PartenaireCategorie;

  const PartenaireCategorie._();

  /// Ligne de localisation de la carte : « Localite - Quartier - Secteur ».
  /// Localite : nom rattache, sinon l'ancienne ville, sinon le departement
  /// (seul connu tant que l'annuaire ne renvoie ni l'un ni l'autre).
  String get ligneLocalisation {
    String retenir(String? rattache, String ancien) =>
        (rattache ?? '').trim().isNotEmpty ? rattache! : ancien;
    final localite = retenir(localiteNom, ville);
    return geo.ligneLocalisation(
      localite: localite.trim().isNotEmpty ? localite : departement,
      quartier: retenir(quartierNom, quartier),
      secteur: secteur,
    );
  }

  /// Vrai si le partenaire a des coordonnees GPS exploitables sur la carte.
  bool get aPosition => latitude != null && longitude != null;

  factory PartenaireCategorie.fromJson(Map<String, dynamic> json) =>
      _$PartenaireCategorieFromJson(json);
}
