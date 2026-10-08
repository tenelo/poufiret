import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';
import '../../../global/ui/format_montant.dart';
import '../../geo/metier_domaine/localisation.dart';

part 'location_models.freezed.dart';
part 'location_models.g.dart';

/// Types de partenaire servis par l'expérience « location » (page loueur,
/// fiche du bien) au lieu de la vitrine générique.
const typeLoueurMaison = 'loueur_maison';
const typeLoueurVoiture = 'loueur_voiture';
const typeHotelier = 'hotelier';

/// Ce que loue un loueur : la page loueur est la même, seuls la liste, ses
/// filtres et la fiche ouverte en dépendent.
enum TypeLocation { logement, vehicule, hebergement }

/// Type de location d'une catégorie portant ces types de partenaire, ou
/// null si elle n'en relève pas.
TypeLocation? typeLocation(Iterable<String> typesPartenaire) =>
    typesPartenaire.contains(typeLoueurMaison)
    ? TypeLocation.logement
    : typesPartenaire.contains(typeLoueurVoiture)
    ? TypeLocation.vehicule
    : typesPartenaire.contains(typeHotelier)
    ? TypeLocation.hebergement
    : null;

/// « 50 000 F/mois ».
String formatLoyer(int loyer) => '${formatMontant(loyer)}/mois';

/// « 25 000 F/jour ».
String formatPrixJour(int prix) => '${formatMontant(prix)}/jour';

/// « 25 000 F/nuit ».
String formatPrixNuit(int prix) => '${formatMontant(prix)}/nuit';

/// « 1 chambre », « 3 chambres ».
String pluriel(int nombre, String singulier, [String? plurielle]) =>
    '$nombre ${nombre > 1 ? plurielle ?? '${singulier}s' : singulier}';

/// Choix d'une liste de référence : `{valeur, libelle}`.
@freezed
abstract class OptionMeta with _$OptionMeta {
  const factory OptionMeta({
    @Default('') String valeur,
    @Default('') String libelle,
  }) = _OptionMeta;

  factory OptionMeta.fromJson(Map<String, dynamic> json) =>
      _$OptionMetaFromJson(json);
}

/// Listes de référence des locations (`GET /locations/meta/`).
@freezed
abstract class MetaLocations with _$MetaLocations {
  const MetaLocations._();

  const factory MetaLocations({
    @JsonKey(name: 'types_logement')
    @Default(<OptionMeta>[])
    List<OptionMeta> typesLogement,
    @Default(<OptionMeta>[]) List<OptionMeta> equipements,
    @Default(<OptionMeta>[]) List<OptionMeta> disponibilites,
    @JsonKey(name: 'categories_vehicule')
    @Default(<OptionMeta>[])
    List<OptionMeta> categoriesVehicule,
    @Default(<OptionMeta>[]) List<OptionMeta> boites,
    @Default(<OptionMeta>[]) List<OptionMeta> carburants,
    @JsonKey(name: 'equipements_vehicule')
    @Default(<OptionMeta>[])
    List<OptionMeta> equipementsVehicule,
    @JsonKey(name: 'equipements_etablissement')
    @Default(<OptionMeta>[])
    List<OptionMeta> equipementsEtablissement,
    @JsonKey(name: 'equipements_hebergement')
    @Default(<OptionMeta>[])
    List<OptionMeta> equipementsHebergement,
  }) = _MetaLocations;

  factory MetaLocations.fromJson(Map<String, dynamic> json) =>
      _$MetaLocationsFromJson(json);

  /// Libellé d'un équipement de logement ; à défaut, sa valeur brute.
  String libelleEquipement(String valeur) => _libelle(equipements, valeur);

  /// Libellé d'un équipement de véhicule ; à défaut, sa valeur brute.
  String libelleEquipementVehicule(String valeur) =>
      _libelle(equipementsVehicule, valeur);

  /// Libellé d'un équipement d'hôtel (établissement ou hébergement) ; à
  /// défaut, la valeur rendue lisible (« salle_de_sport » → « Salle de
  /// sport »).
  String libelleEquipementHotel(String valeur) {
    for (final o in [...equipementsEtablissement, ...equipementsHebergement]) {
      if (o.valeur == valeur) return o.libelle;
    }
    return lisible(valeur);
  }

  static String _libelle(List<OptionMeta> options, String valeur) => options
      .firstWhere(
        (e) => e.valeur == valeur,
        orElse: () => OptionMeta(valeur: valeur, libelle: valeur),
      )
      .libelle;
}

/// « salle_de_sport » → « Salle de sport ».
String lisible(String valeur) {
  final texte = valeur.replaceAll('_', ' ').trim();
  if (texte.isEmpty) return texte;
  return texte[0].toUpperCase() + texte.substring(1);
}

/// Le loueur, tel qu'il accompagne la liste de ses logements.
@freezed
abstract class Loueur with _$Loueur {
  const factory Loueur({
    required int id,
    @Default('') String nom,
    @Default('') String logo,
    @Default('') String couverture,
    @JsonKey(name: 'telephone_pro') @Default('') String telephonePro,
    @Default('') String whatsapp,
  }) = _Loueur;

  factory Loueur.fromJson(Map<String, dynamic> json) => _$LoueurFromJson(json);
}

/// Un logement dans une liste (page loueur, « autres logements »).
@freezed
abstract class LogementResume with _$LogementResume {
  const LogementResume._();

  const factory LogementResume({
    required int id,
    @Default('') String titre,
    @Default('') String photo,
    @JsonKey(name: 'type_logement') @Default('') String typeLogement,
    @JsonKey(name: 'type_logement_libelle')
    @Default('')
    String typeLogementLibelle,
    @JsonKey(name: 'localisation_texte') @Default('') String localisationTexte,
    @JsonKey(fromJson: versInt) @Default(0) int loyer,
    @JsonKey(name: 'nb_chambres', fromJson: versInt) @Default(0) int nbChambres,
    @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)
    @Default(0)
    int nbSallesDeBain,
    @Default(false) bool meuble,
    @Default('') String disponibilite,
  }) = _LogementResume;

  factory LogementResume.fromJson(Map<String, dynamic> json) =>
      _$LogementResumeFromJson(json);

  /// Puces de la carte : « 3 chambres », « 2 sdb », « Meublé ».
  List<String> get puces => [
    if (nbChambres > 0) pluriel(nbChambres, 'chambre'),
    if (nbSallesDeBain > 0) '$nbSallesDeBain sdb',
    if (meuble) 'Meublé',
  ];
}

/// Page d'un loueur : lui-même et ses logements.
@freezed
abstract class PageLoueur with _$PageLoueur {
  const factory PageLoueur({
    required Loueur loueur,
    @Default(<LogementResume>[]) List<LogementResume> resultats,
  }) = _PageLoueur;

  factory PageLoueur.fromJson(Map<String, dynamic> json) =>
      _$PageLoueurFromJson(json);
}

/// Une vue de la visite immersive.
@freezed
abstract class Panorama with _$Panorama {
  const Panorama._();

  const factory Panorama({
    required int id,
    @Default('') String image,
    @Default('') String titre,

    /// photo_360 | panoramique
    @JsonKey(name: 'type_vue') @Default('panoramique') String typeVue,
    @JsonKey(fromJson: versInt) @Default(0) int ordre,
    @JsonKey(name: 'est_active') @Default(true) bool estActive,
  }) = _Panorama;

  factory Panorama.fromJson(Map<String, dynamic> json) =>
      _$PanoramaFromJson(json);

  /// Vue sphérique, que l'on tourne du doigt ; sinon photo large à glisser.
  bool get est360 => typeVue == 'photo_360';
}

/// Fiche complète d'un logement.
@freezed
abstract class Logement with _$Logement {
  const Logement._();

  const factory Logement({
    required int id,
    @Default('') String titre,
    @Default('') String description,
    @Default(<String>[]) List<String> galerie,
    @Default(<Panorama>[]) List<Panorama> panoramas,
    @JsonKey(name: 'type_logement') @Default('') String typeLogement,
    @JsonKey(name: 'type_logement_libelle')
    @Default('')
    String typeLogementLibelle,
    @JsonKey(name: 'nb_chambres', fromJson: versInt) @Default(0) int nbChambres,
    @JsonKey(name: 'nb_salons', fromJson: versInt) @Default(0) int nbSalons,
    @JsonKey(name: 'nb_salles_de_bain', fromJson: versInt)
    @Default(0)
    int nbSallesDeBain,
    @JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? surfaceM2,
    @Default(false) bool meuble,
    @JsonKey(fromJson: versInt) @Default(0) int loyer,
    @JsonKey(name: 'caution_mois', fromJson: versIntNullable) int? cautionMois,
    @JsonKey(name: 'avance_mois', fromJson: versIntNullable) int? avanceMois,
    @JsonKey(name: 'frais_agence', fromJson: versIntNullable) int? fraisAgence,
    @JsonKey(name: 'compteur_eau_individuel')
    @Default(false)
    bool compteurEauIndividuel,
    @JsonKey(name: 'compteur_electricite_individuel')
    @Default(false)
    bool compteurElectriciteIndividuel,
    @Default(<String>[]) List<String> equipements,
    @Default('') String disponibilite,
    @JsonKey(name: 'disponible_a_partir_du') String? disponibleAPartirDu,
    @JsonKey(name: 'localite_nom') String? localiteNom,
    @JsonKey(name: 'quartier_nom') String? quartierNom,
    @Default('') String secteur,
    @JsonKey(name: 'adresse_reperes') @Default('') String adresseReperes,
    @JsonKey(fromJson: versDoubleNullable) double? latitude,
    @JsonKey(fromJson: versDoubleNullable) double? longitude,
    Loueur? loueur,
    @JsonKey(name: 'autres_logements')
    @Default(<LogementResume>[])
    List<LogementResume> autresLogements,
  }) = _Logement;

  factory Logement.fromJson(Map<String, dynamic> json) =>
      _$LogementFromJson(json);

  /// « Localité - Quartier - Secteur », comme sur les cartes de partenaires.
  String get localisation => ligneLocalisation(
    localite: localiteNom ?? '',
    quartier: quartierNom ?? '',
    secteur: secteur,
  );

  /// Vues de la visite immersive : actives, dans l'ordre voulu.
  List<Panorama> get panoramasActifs =>
      panoramas.where((p) => p.estActive && p.image.isNotEmpty).toList()
        ..sort((a, b) => a.ordre.compareTo(b.ordre));

  bool get aPosition => latitude != null && longitude != null;

  bool get estDisponible => disponibilite == 'disponible';
}

/// Filtres de la liste des logements d'un loueur.
class FiltreLogements {
  const FiltreLogements({
    this.type,
    this.quartier = '',
    this.loyerMax,
    this.chambresMin,
    this.meuble = false,
  });

  final String? type;
  final String quartier;
  final int? loyerMax;
  final int? chambresMin;
  final bool meuble;

  /// Nombre de critères actifs (pastille du bouton « Filtrer »).
  int get nombre => [
    type != null,
    quartier.trim().isNotEmpty,
    loyerMax != null,
    chambresMin != null,
    meuble,
  ].where((actif) => actif).length;

  /// Paramètres de requête. Seuls les logements disponibles sont demandés.
  Map<String, dynamic> get parametres => {
    'disponible': 1,
    'type': ?type,
    if (quartier.trim().isNotEmpty) 'quartier': quartier.trim(),
    'loyer_max': ?loyerMax,
    'chambres_min': ?chambresMin,
    if (meuble) 'meuble': 1,
  };

  /// Signature stable, pour la clé de cache.
  String get cle =>
      (parametres.entries.map((e) => '${e.key}=${e.value}').toList()..sort())
          .join('&');

  @override
  bool operator ==(Object other) =>
      other is FiltreLogements && other.cle == cle;

  @override
  int get hashCode => cle.hashCode;
}

/// Une demande faite par le client : visite d'un logement ou réservation
/// d'un véhicule.
@freezed
abstract class DemandeReservation with _$DemandeReservation {
  const DemandeReservation._();

  const factory DemandeReservation({
    required int id,
    @Default('') String numero,

    /// visite | reservation
    @Default('') String nature,
    @JsonKey(name: 'nature_libelle') @Default('') String natureLibelle,

    /// logement | vehicule
    @JsonKey(name: 'objet_type') @Default('') String objetType,
    @JsonKey(name: 'objet_nom') @Default('') String objetNom,
    @JsonKey(name: 'partenaire_nom') @Default('') String partenaireNom,
    @JsonKey(name: 'date_souhaitee') String? dateSouhaitee,
    @JsonKey(name: 'date_debut') String? dateDebut,
    @JsonKey(name: 'date_fin') String? dateFin,
    @JsonKey(name: 'avec_chauffeur') @Default(false) bool avecChauffeur,
    @JsonKey(name: 'lieu_prise_en_charge')
    @Default('')
    String lieuPriseEnCharge,
    @JsonKey(name: 'montant_estime', fromJson: versIntNullable)
    int? montantEstime,
    @JsonKey(name: 'nb_adultes', fromJson: versIntNullable) int? nbAdultes,
    @JsonKey(name: 'nb_enfants', fromJson: versIntNullable) int? nbEnfants,
    @JsonKey(name: 'nb_unites', fromJson: versIntNullable) int? nbUnites,
    @Default('') String statut,
    @JsonKey(name: 'statut_libelle') @Default('') String statutLibelle,
    @JsonKey(name: 'raison_refus') @Default('') String raisonRefus,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _DemandeReservation;

  factory DemandeReservation.fromJson(Map<String, dynamic> json) =>
      _$DemandeReservationFromJson(json);

  /// Statuts après lesquels la demande ne peut plus être annulée.
  static const _termines = {
    'annulee',
    'refusee',
    'terminee',
    'effectuee',
    'expiree',
  };

  /// Annulable tant qu'elle n'est pas terminée (le serveur reste l'arbitre).
  bool get peutAnnuler => !_termines.contains(statut);

  /// Réservation (plage de dates), par opposition à une visite (un jour).
  bool get estReservation =>
      nature == 'reservation' || (dateDebut ?? '').isNotEmpty;

  /// Séjour dans un hébergement (hôtel, résidence).
  bool get estSejour => objetType == 'hebergement' || nbUnites != null;

  /// « Arrivée le 20/10/2026 · départ le 23/10/2026 ».
  String get sejourLisible =>
      'Arrivée le ${formatDateCourte(dateDebut)} · '
      'départ le ${formatDateCourte(dateFin)}';

  /// « 2 adultes · 1 enfant » (vide si inconnu).
  String get voyageursLisible =>
      nbAdultes == null ? '' : capaciteLisible(nbAdultes!, nbEnfants ?? 0);

  /// Date souhaitée au format « 07/10/2026 ».
  String get dateLisible => formatDateCourte(dateSouhaitee);

  /// « Du 20/10/2026 au 22/10/2026 », ou « Le 20/10/2026 » sur un jour.
  String get periodeLisible {
    final du = formatDateCourte(dateDebut);
    final au = formatDateCourte(dateFin);
    if (au.isEmpty || au == du) return 'Le $du';
    return 'Du $du au $au';
  }
}

/// « 2 adultes · 1 enfant » ; les enfants sont omis s'il n'y en a pas.
String capaciteLisible(int adultes, int enfants) => [
  pluriel(adultes, 'adulte'),
  if (enfants > 0) pluriel(enfants, 'enfant'),
].join(' · ');

/// « 2026-10-07 » ou « 2026-10-07T10:00:00Z » → « 07/10/2026 ».
String formatDateCourte(String? iso) {
  final date = DateTime.tryParse(iso ?? '');
  if (date == null) return iso ?? '';
  String deux(int n) => n.toString().padLeft(2, '0');
  return '${deux(date.day)}/${deux(date.month)}/${date.year}';
}

/// Date au format attendu par le serveur : « 2026-10-07 ».
String formatDateIso(DateTime date) {
  String deux(int n) => n.toString().padLeft(2, '0');
  return '${date.year}-${deux(date.month)}-${deux(date.day)}';
}
