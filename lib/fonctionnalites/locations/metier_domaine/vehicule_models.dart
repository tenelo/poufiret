import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';
import '../../../global/ui/format_montant.dart';
import 'location_models.dart';
import 'vente_models.dart';

part 'vehicule_models.freezed.dart';
part 'vehicule_models.g.dart';

/// Un véhicule dans une liste (page loueur, « autres véhicules »).
@freezed
abstract class VehiculeResume with _$VehiculeResume {
  const VehiculeResume._();

  const factory VehiculeResume({
    required int id,
    @Default('') String titre,
    @Default('') String photo,
    @Default('') String categorie,
    @JsonKey(name: 'categorie_libelle') @Default('') String categorieLibelle,
    @Default('') String marque,
    @Default('') String modele,
    @JsonKey(fromJson: versIntNullable) int? annee,
    @JsonKey(name: 'nb_places', fromJson: versInt) @Default(0) int nbPlaces,
    @JsonKey(name: 'boite_libelle') @Default('') String boiteLibelle,
    @JsonKey(name: 'carburant_libelle') @Default('') String carburantLibelle,
    @Default(false) bool climatisation,
    @JsonKey(name: 'prix_jour', fromJson: versInt) @Default(0) int prixJour,
    @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)
    int? prixJourAvecChauffeur,
    @JsonKey(name: 'chauffeur_disponible')
    @Default(false)
    bool chauffeurDisponible,
    @JsonKey(name: 'chauffeur_obligatoire')
    @Default(false)
    bool chauffeurObligatoire,
    @JsonKey(name: 'localisation_texte') @Default('') String localisationTexte,
    @Default('') String disponibilite,

    /// Vente : mode, prix de vente, vendu, champs propres (à la racine).
    @JsonKey(readValue: lireRacine) @Default(InfosVente()) InfosVente vente,
  }) = _VehiculeResume;

  factory VehiculeResume.fromJson(Map<String, dynamic> json) =>
      _$VehiculeResumeFromJson(json);

  /// « Toyota Corolla 2019 » ; à défaut, le titre.
  String get nomComplet =>
      nomVehicule(marque: marque, modele: modele, annee: annee, titre: titre);

  /// « 5 places · Automatique · Diesel ».
  String get caracteristiques => ligneVehicule(
    nbPlaces: nbPlaces,
    boite: boiteLibelle,
    carburant: carburantLibelle,
  );

  /// Un chauffeur peut (ou doit) accompagner le véhicule.
  bool get avecChauffeur => chauffeurDisponible || chauffeurObligatoire;

  /// Tarif affiché sur la carte : celui avec chauffeur s'il est imposé.
  int get prixAffiche =>
      chauffeurObligatoire ? prixJourAvecChauffeur ?? prixJour : prixJour;
}

/// « Marque Modèle Année », ou [titre] si la marque et le modèle manquent.
String nomVehicule({
  required String marque,
  required String modele,
  required int? annee,
  required String titre,
}) {
  final nom = [marque, modele].where((m) => m.trim().isNotEmpty).join(' ');
  if (nom.isEmpty) return titre;
  return annee == null || annee == 0 ? nom : '$nom $annee';
}

/// « 5 places · Automatique · Diesel » (éléments absents omis).
String ligneVehicule({
  required int nbPlaces,
  required String boite,
  required String carburant,
}) => [
  if (nbPlaces > 0) pluriel(nbPlaces, 'place'),
  if (boite.isNotEmpty) boite,
  if (carburant.isNotEmpty) carburant,
].join(' · ');

/// Page d'un loueur de véhicules : lui-même et ses véhicules.
@freezed
abstract class PageLoueurVehicules with _$PageLoueurVehicules {
  const factory PageLoueurVehicules({
    required Loueur loueur,
    @Default(<VehiculeResume>[]) List<VehiculeResume> resultats,
  }) = _PageLoueurVehicules;

  factory PageLoueurVehicules.fromJson(Map<String, dynamic> json) =>
      _$PageLoueurVehiculesFromJson(json);
}

/// Période où le véhicule est déjà réservé : elle occupe [début, fin[, le
/// jour de restitution reste libre.
@freezed
abstract class PeriodeIndisponible with _$PeriodeIndisponible {
  const PeriodeIndisponible._();

  const factory PeriodeIndisponible({
    @JsonKey(name: 'date_debut') @Default('') String dateDebut,
    @JsonKey(name: 'date_fin') @Default('') String dateFin,
  }) = _PeriodeIndisponible;

  factory PeriodeIndisponible.fromJson(Map<String, dynamic> json) =>
      _$PeriodeIndisponibleFromJson(json);

  DateTime? get debut => _jour(dateDebut);

  /// Jour de restitution (libre). Une période sans fin connue ne bloque
  /// que son premier jour.
  DateTime? get fin {
    final d = debut;
    return _jour(dateFin) ??
        (d == null ? null : DateTime(d.year, d.month, d.day + 1));
  }

  /// Vrai si [jour] est occupé : début <= jour < fin.
  bool occupe(DateTime jour) {
    final d = debut, f = fin;
    if (d == null || f == null) return false;
    final j = jourSeul(jour);
    return !j.isBefore(d) && j.isBefore(f);
  }

  /// Vrai si la plage [du, au[ recoupe cette période (le jour [au] de la
  /// plage, rendu, ne compte pas).
  bool chevauche(DateTime du, DateTime au) {
    final d = debut, f = fin;
    if (d == null || f == null) return false;
    return jourSeul(du).isBefore(f) && d.isBefore(jourSeul(au));
  }

  static DateTime? _jour(String iso) {
    final date = DateTime.tryParse(iso);
    return date == null ? null : jourSeul(date);
  }
}

/// Fiche complète d'un véhicule.
@freezed
abstract class Vehicule with _$Vehicule {
  const Vehicule._();

  const factory Vehicule({
    required int id,
    @Default('') String titre,
    @Default('') String description,
    @Default(<String>[]) List<String> galerie,
    @Default(<Panorama>[]) List<Panorama> panoramas,
    @Default('') String categorie,
    @JsonKey(name: 'categorie_libelle') @Default('') String categorieLibelle,
    @Default('') String marque,
    @Default('') String modele,
    @JsonKey(fromJson: versIntNullable) int? annee,
    @Default('') String couleur,
    @JsonKey(name: 'nb_places', fromJson: versInt) @Default(0) int nbPlaces,
    @Default('') String boite,
    @JsonKey(name: 'boite_libelle') @Default('') String boiteLibelle,
    @Default('') String carburant,
    @JsonKey(name: 'carburant_libelle') @Default('') String carburantLibelle,
    @Default(false) bool climatisation,
    @JsonKey(name: 'prix_jour', fromJson: versInt) @Default(0) int prixJour,
    @JsonKey(name: 'prix_jour_avec_chauffeur', fromJson: versIntNullable)
    int? prixJourAvecChauffeur,
    @JsonKey(name: 'chauffeur_disponible')
    @Default(false)
    bool chauffeurDisponible,
    @JsonKey(name: 'chauffeur_obligatoire')
    @Default(false)
    bool chauffeurObligatoire,
    @JsonKey(fromJson: versIntNullable) int? caution,

    /// 0 = kilométrage illimité.
    @JsonKey(name: 'km_inclus_par_jour', fromJson: versInt)
    @Default(0)
    int kmInclusParJour,
    @JsonKey(name: 'prix_km_supplementaire', fromJson: versIntNullable)
    int? prixKmSupplementaire,
    @JsonKey(name: 'carburant_inclus') @Default(false) bool carburantInclus,
    @JsonKey(name: 'duree_min_jours', fromJson: versInt)
    @Default(1)
    int dureeMinJours,
    @JsonKey(name: 'zone_circulation') @Default('') String zoneCirculation,
    @JsonKey(name: 'zone_circulation_libelle')
    @Default('')
    String zoneCirculationLibelle,
    @Default(<String>[]) List<String> equipements,
    @Default('') String disponibilite,
    @JsonKey(name: 'localisation_texte') @Default('') String localisationTexte,
    @JsonKey(fromJson: versDoubleNullable) double? latitude,
    @JsonKey(fromJson: versDoubleNullable) double? longitude,
    Loueur? loueur,
    @JsonKey(name: 'autres_vehicules')
    @Default(<VehiculeResume>[])
    List<VehiculeResume> autresVehicules,
    @JsonKey(name: 'periodes_indisponibles')
    @Default(<PeriodeIndisponible>[])
    List<PeriodeIndisponible> periodesIndisponibles,

    /// Vente : mode, prix de vente, vendu, champs propres (à la racine).
    @JsonKey(readValue: lireRacine) @Default(InfosVente()) InfosVente vente,
  }) = _Vehicule;

  factory Vehicule.fromJson(Map<String, dynamic> json) =>
      _$VehiculeFromJson(json);

  String get nomComplet =>
      nomVehicule(marque: marque, modele: modele, annee: annee, titre: titre);

  /// Vues intérieures 360° : actives, dans l'ordre voulu.
  List<Panorama> get panoramasActifs =>
      panoramas.where((p) => p.estActive && p.image.isNotEmpty).toList()
        ..sort((a, b) => a.ordre.compareTo(b.ordre));

  bool get aPosition => latitude != null && longitude != null;

  bool get kmIllimite => kmInclusParJour <= 0;

  /// Zone de circulation lisible (libellé, sinon valeur brute).
  String get zone => zoneCirculationLibelle.isNotEmpty
      ? zoneCirculationLibelle
      : zoneCirculation;

  /// Durée minimale effective (au moins un jour).
  int get dureeMin => dureeMinJours < 1 ? 1 : dureeMinJours;

  /// Le client peut choisir de prendre un chauffeur ou non.
  bool get chauffeurAuChoix => chauffeurDisponible && !chauffeurObligatoire;

  /// Tarif journalier selon le choix du chauffeur. Sans tarif « avec
  /// chauffeur » publié, le tarif de base s'applique.
  int prixJourPour({required bool avecChauffeur}) =>
      avecChauffeur ? prixJourAvecChauffeur ?? prixJour : prixJour;

  /// Jour déjà réservé (grisé dans le calendrier).
  bool jourIndisponible(DateTime jour) =>
      periodesIndisponibles.any((p) => p.occupe(jour));

  /// Vrai si aucun jour de [du] à la veille de [au] n'est déjà réservé.
  bool plageLibre(DateTime du, DateTime au) =>
      !periodesIndisponibles.any((p) => p.chevauche(du, au));

  /// Jour sélectionnable dans le calendrier. Comme fin (après un début
  /// choisi) : même réservé, s'il n'y a pas de période réservée entre le
  /// début et lui (il est rendu ce jour-là). Sinon : libre.
  bool jourSelectionnable(DateTime jour, DateTime? debut, DateTime? fin) {
    final commeFin =
        debut != null &&
        jourSeul(jour).isAfter(jourSeul(debut)) &&
        (fin == null || jourSeul(fin) == jourSeul(jour));
    if (commeFin) return plageLibre(debut, jour);
    return !jourIndisponible(jour);
  }

  /// Problème de la plage choisie, ou null si elle convient.
  String? erreurPlage(DateTime du, DateTime au) {
    // Comme le serveur : restitution strictement après la prise en charge.
    if (!jourSeul(au).isAfter(jourSeul(du))) {
      return 'La date de restitution doit suivre celle de prise en charge.';
    }
    if (!plageLibre(du, au)) {
      return 'Le véhicule est déjà réservé sur une partie de ces dates.';
    }
    if (nombreJours(du, au) < dureeMin) {
      return 'Durée minimale de location : ${pluriel(dureeMin, 'jour')}.';
    }
    return null;
  }
}

/// Jours facturés, comme le serveur : date de restitution − date de prise
/// en charge (du 10 au 12 = 2 jours, le jour de restitution est libre).
int nombreJours(DateTime du, DateTime au) {
  final d = jourSeul(du), a = jourSeul(au);
  // Arrondi : un changement d'heure ne fausse pas le compte.
  final jours = (a.difference(d).inHours / 24).round();
  return jours < 0 ? 0 : jours;
}

/// La date seule, sans l'heure.
DateTime jourSeul(DateTime date) => DateTime(date.year, date.month, date.day);

/// Montant estimé d'une location, recalculé à chaque changement.
class EstimationLocation {
  const EstimationLocation({required this.jours, required this.prixJour});

  factory EstimationLocation.pour(
    Vehicule vehicule, {
    required DateTime du,
    required DateTime au,
    required bool avecChauffeur,
  }) => EstimationLocation(
    jours: nombreJours(du, au),
    prixJour: vehicule.prixJourPour(avecChauffeur: avecChauffeur),
  );

  final int jours;
  final int prixJour;

  int get total => jours * prixJour;

  /// « 3 jours × 25 000 F = 75 000 F ».
  String get libelle =>
      '${pluriel(jours, 'jour')} × ${formatMontant(prixJour)} = '
      '${formatMontant(total)}';
}

/// Filtres de la liste des véhicules d'un loueur.
class FiltreVehicules {
  const FiltreVehicules({
    this.categorie,
    this.prixMax,
    this.placesMin,
    this.boite,
    this.avecChauffeur = false,
    this.mode,
  });

  final String? categorie;

  /// Louer | Acheter : `location` ou `vente` (null : toutes les annonces).
  final String? mode;

  /// Même filtre, pour le type d'annonce choisi.
  FiltreVehicules avecMode(String? mode) => FiltreVehicules(
    categorie: categorie,
    prixMax: prixMax,
    placesMin: placesMin,
    boite: boite,
    avecChauffeur: avecChauffeur,
    mode: mode,
  );
  final int? prixMax;
  final int? placesMin;
  final String? boite;
  final bool avecChauffeur;

  /// Nombre de critères actifs (pastille du bouton « Filtrer »).
  int get nombre => [
    categorie != null,
    prixMax != null,
    placesMin != null,
    boite != null,
    avecChauffeur,
  ].where((actif) => actif).length;

  /// Paramètres de requête. Seuls les véhicules disponibles sont demandés.
  Map<String, dynamic> get parametres => {
    'disponible': 1,
    'categorie': ?categorie,
    'prix_max': ?prixMax,
    'places_min': ?placesMin,
    'boite': ?boite,
    if (avecChauffeur) 'avec_chauffeur': 1,
    'mode': ?mode,
  };

  /// Signature stable, pour la clé de cache.
  String get cle =>
      (parametres.entries.map((e) => '${e.key}=${e.value}').toList()..sort())
          .join('&');

  @override
  bool operator ==(Object other) =>
      other is FiltreVehicules && other.cle == cle;

  @override
  int get hashCode => cle.hashCode;
}
