import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';
import '../../../global/ui/format_montant.dart';
import 'location_models.dart';

part 'vente_models.freezed.dart';
part 'vente_models.g.dart';

/// Type d'annonce d'un logement ou d'un véhicule.
enum ModeAnnonce {
  location('location', 'Location'),
  vente('vente', 'Vente'),
  locationVente('location_vente', 'Location et vente');

  const ModeAnnonce(this.valeur, this.libelle);

  /// Valeur échangée avec le serveur.
  final String valeur;

  /// Libellé du formulaire partenaire.
  final String libelle;

  /// Une valeur inconnue ou absente vaut « location » (tout l'existant).
  static ModeAnnonce depuis(Object? valeur) => ModeAnnonce.values.firstWhere(
    (m) => m.valeur == valeur,
    orElse: () => ModeAnnonce.location,
  );

  bool get aLouer => this != ModeAnnonce.vente;
  bool get aVendre => this != ModeAnnonce.location;
}

ModeAnnonce _modeDepuis(Object? valeur) => ModeAnnonce.depuis(valeur);
String _modeVers(ModeAnnonce mode) => mode.valeur;

/// Les champs de vente sont à la racine de la fiche : on les relit tous.
Object? lireRacine(Map<dynamic, dynamic> json, String _) => json;

/// Booléen facultatif (null = non renseigné).
bool? _versBoolNullable(Object? valeur) => valeur is bool ? valeur : null;

/// Informations de vente d'une annonce (logement ou véhicule). Les champs
/// propres au véhicule ou à la maison restent null sur l'autre type.
@freezed
abstract class InfosVente with _$InfosVente {
  const InfosVente._();

  const factory InfosVente({
    @JsonKey(fromJson: _modeDepuis, toJson: _modeVers)
    @Default(ModeAnnonce.location)
    ModeAnnonce mode,
    @JsonKey(name: 'mode_libelle') @Default('') String modeLibelle,
    @JsonKey(name: 'prix_vente', fromJson: versIntNullable) int? prixVente,
    @JsonKey(name: 'prix_negociable') @Default(false) bool prixNegociable,
    @Default(false) bool vendu,
    @JsonKey(name: 'vendu_le') String? venduLe,

    // ── Véhicule ──
    String? etat,
    @JsonKey(name: 'etat_libelle') String? etatLibelle,
    @JsonKey(fromJson: versIntNullable) int? kilometrage,
    @JsonKey(fromJson: _versBoolNullable) bool? dedouane,
    @JsonKey(name: 'carte_grise', fromJson: _versBoolNullable) bool? carteGrise,
    @JsonKey(name: 'visite_technique_valide_jusqu_au')
    String? visiteTechniqueValideJusquAu,
    @JsonKey(name: 'assurance_valide_jusqu_au') String? assuranceValideJusquAu,
    @JsonKey(name: 'nb_proprietaires', fromJson: versIntNullable)
    int? nbProprietaires,

    // ── Maison ──
    @JsonKey(name: 'type_document') String? typeDocument,
    @JsonKey(name: 'type_document_libelle') String? typeDocumentLibelle,
    @JsonKey(name: 'surface_terrain_m2', fromJson: versIntNullable)
    int? surfaceTerrainM2,
    @JsonKey(name: 'est_lotie', fromJson: _versBoolNullable) bool? estLotie,
  }) = _InfosVente;

  factory InfosVente.fromJson(Map<String, dynamic> json) =>
      _$InfosVenteFromJson(json);

  /// Badge « À vendre » : annonce en vente (seule ou aussi en location).
  bool get aVendre => mode.aVendre;

  /// Actions proposées sur la fiche.
  ActionsAnnonce get actions => ActionsAnnonce.pour(mode, vendu: vendu);

  /// « 12 500 000 FCFA » ; vide sans prix de vente.
  String get prixVenteLisible =>
      prixVente == null ? '' : formatPrixVente(prixVente!);

  /// Lignes de la section « Vente » d'un véhicule : seulement les champs
  /// renseignés.
  List<(String, String)> get lignesVehicule => [
    if ((etatLibelle ?? '').isNotEmpty) ('État', etatLibelle!),
    if (kilometrage != null) ('Kilométrage', formatKilometrage(kilometrage!)),
    if (dedouane != null) ('Dédouané', dedouane! ? 'Oui' : 'Non'),
    if (carteGrise != null) ('Carte grise', carteGrise! ? 'Oui' : 'Non'),
    if ((visiteTechniqueValideJusquAu ?? '').isNotEmpty)
      (
        'Visite technique valide jusqu\'au',
        formatDateCourte(visiteTechniqueValideJusquAu),
      ),
    if ((assuranceValideJusquAu ?? '').isNotEmpty)
      ('Assurance valide jusqu\'au', formatDateCourte(assuranceValideJusquAu)),
    if (nbProprietaires != null)
      ('Propriétaires précédents', '$nbProprietaires'),
  ];

  /// Lignes de la section « Vente » d'une maison.
  List<(String, String)> get lignesLogement => [
    if ((typeDocumentLibelle ?? '').isNotEmpty)
      ('Document', typeDocumentLibelle!),
    if (surfaceTerrainM2 != null)
      ('Surface du terrain', '${formatNombre(surfaceTerrainM2!)} m²'),
    if (estLotie != null) ('Terrain loti', estLotie! ? 'Oui' : 'Non'),
  ];
}

/// « 12 500 000 FCFA ».
String formatPrixVente(int prix) => '${formatMontant(prix)}CFA';

/// « 1 250 000 » (séparateur de milliers).
String formatNombre(int n) {
  final montant = formatMontant(n);
  return montant.substring(0, montant.length - 2);
}

/// « 85 000 km ».
String formatKilometrage(int km) => '${formatNombre(km)} km';

/// Boutons de la fiche selon le type d'annonce : réservation / visite si
/// l'annonce est à louer, « Je suis intéressé » si elle est à vendre ;
/// aucun bouton une fois vendue.
class ActionsAnnonce {
  const ActionsAnnonce({
    required this.louer,
    required this.acheter,
    required this.vendu,
  });

  factory ActionsAnnonce.pour(ModeAnnonce mode, {required bool vendu}) => vendu
      ? const ActionsAnnonce(louer: false, acheter: false, vendu: true)
      : ActionsAnnonce(louer: mode.aLouer, acheter: mode.aVendre, vendu: false);

  final bool louer;
  final bool acheter;
  final bool vendu;
}

/// Règle des prix, identique au serveur : prix de location obligatoire si
/// l'annonce est à louer, prix de vente si elle est à vendre. Renvoie
/// {champ: message} (vide si conforme).
Map<String, String> erreursPrixAnnonce({
  required ModeAnnonce mode,
  required int? prixLocation,
  required int? prixVente,
}) => {
  if (mode.aLouer && prixLocation == null)
    'prix': 'Le prix de location est obligatoire pour une annonce en location.',
  if (mode.aVendre && prixVente == null)
    'prix_vente': 'Le prix de vente est obligatoire pour une annonce à vendre.',
};

/// Condition d'affichage d'un champ du formulaire (`visible_si`).
class ConditionChamp {
  const ConditionChamp({required this.champ, required this.valeurs});

  factory ConditionChamp.fromJson(Map<String, dynamic> json) => ConditionChamp(
    champ: '${json['champ'] ?? ''}',
    valeurs: [for (final v in (json['valeurs'] as List? ?? const [])) '$v'],
  );

  final String champ;
  final List<String> valeurs;

  bool verifiee(Map<String, Object?> valeurs) =>
      this.valeurs.contains('${valeurs[champ]}');
}

/// Description d'un champ de vente (`/locations/meta/` → champs_vente).
class ChampVente {
  const ChampVente({
    required this.cle,
    required this.libelle,
    required this.type,
    this.choix = const [],
    this.obligatoire = false,
    this.defaut,
    this.visibleSi,
  });

  factory ChampVente.fromJson(Map<String, dynamic> json) => ChampVente(
    cle: '${json['cle'] ?? ''}',
    libelle: '${json['libelle'] ?? ''}',
    type: '${json['type'] ?? ''}',
    choix: [
      for (final c in (json['choix'] as List? ?? const []))
        if (c is Map<String, dynamic>) OptionMeta.fromJson(c),
    ],
    obligatoire: json['obligatoire'] == true,
    defaut: json['defaut'],
    visibleSi: json['visible_si'] is Map<String, dynamic>
        ? ConditionChamp.fromJson(json['visible_si'] as Map<String, dynamic>)
        : null,
  );

  final String cle;
  final String libelle;

  /// choix | entier | booleen | date
  final String type;
  final List<OptionMeta> choix;
  final bool obligatoire;
  final Object? defaut;
  final ConditionChamp? visibleSi;

  /// Affiché pour ces valeurs du formulaire.
  bool visible(Map<String, Object?> valeurs) =>
      visibleSi?.verifiee(valeurs) ?? true;
}

/// Champs de vente par type d'annonce.
class ChampsVente {
  const ChampsVente({this.vehicule = const [], this.logement = const []});

  factory ChampsVente.fromJson(Object? json) {
    if (json is! Map) return const ChampsVente();
    List<ChampVente> lire(Object? liste) => [
      for (final c in (liste as List? ?? const []))
        if (c is Map<String, dynamic>) ChampVente.fromJson(c),
    ];
    return ChampsVente(
      vehicule: lire(json['vehicule']),
      logement: lire(json['logement']),
    );
  }

  final List<ChampVente> vehicule;
  final List<ChampVente> logement;
}
