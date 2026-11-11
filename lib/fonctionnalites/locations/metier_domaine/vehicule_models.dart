import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';
import '../../../global/ui/format_montant.dart';
import 'location_models.dart';
import 'vente_models.dart';

part 'vehicule_models.freezed.dart';
part 'vehicule_models.g.dart';

/// Un véhicule dans une liste (page loueur, « autres véhicules »).
/// Catégorie d'une carte : `categorie_vehicule` (API), sinon `categorie`.
Object? _lireCategorie(Map json, String cle) =>
    json['categorie_vehicule'] ?? json[cle];

@freezed
abstract class VehiculeResume with _$VehiculeResume {
  const VehiculeResume._();

  const factory VehiculeResume({
    required int id,
    @Default('') String titre,
    @Default('') String photo,

    /// Code de catégorie : l'API l'envoie sous `categorie_vehicule`.
    @JsonKey(readValue: _lireCategorie) @Default('') String categorie,
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

/// Prix d'une annonce pour le type affiché : prix de vente en « Acheter »,
/// sinon le prix par jour de la carte (avec chauffeur s'il est imposé).
/// Null si l'annonce n'en a pas.
int? prixVehicule(VehiculeResume v, {required bool achat}) {
  final prix = achat ? v.vente.prixVente : v.prixAffiche;
  return prix == null || prix <= 0 ? null : prix;
}

/// Filtres de la liste des véhicules d'un loueur. Seul [mode] (Louer |
/// Acheter) part au serveur ; les autres critères s'appliquent dans l'app
/// à la liste complète déjà chargée ([appliquer]).
class FiltreVehicules {
  const FiltreVehicules({
    this.categorie,
    this.marque,
    this.prixMax,
    this.placesMin,
    this.boite,
    this.avecChauffeur = false,
    this.mode,
  });

  /// Code de catégorie (`categorie_vehicule`).
  final String? categorie;
  final String? marque;

  /// Prix maximum du type affiché (par jour, ou de vente en « Acheter »).
  final int? prixMax;
  final int? placesMin;

  /// Boîte de vitesses, par son libellé (l'API n'envoie que lui).
  final String? boite;
  final bool avecChauffeur;

  /// Louer | Acheter : `location` ou `vente` (null : toutes les annonces).
  final String? mode;

  /// Même filtre, pour le type d'annonce choisi.
  FiltreVehicules avecMode(String? mode) => FiltreVehicules(
    categorie: categorie,
    marque: marque,
    prixMax: prixMax,
    placesMin: placesMin,
    boite: boite,
    avecChauffeur: avecChauffeur,
    mode: mode,
  );

  /// Même filtre, prix maximum remis à « Tous » (changement de type).
  FiltreVehicules sansPrix() => FiltreVehicules(
    categorie: categorie,
    marque: marque,
    placesMin: placesMin,
    boite: boite,
    avecChauffeur: avecChauffeur,
    mode: mode,
  );

  /// Même filtre, sans les critères dont la valeur n'existe dans aucune
  /// de [annonces] (changement de type Louer ↔ Acheter) : ils repassent à
  /// « Toutes » / « Peu importe » / interrupteur éteint. Le prix est gardé
  /// tel quel (voir [sansPrix]).
  FiltreVehicules limiteA(List<VehiculeResume> annonces) {
    bool existe(bool Function(VehiculeResume) test) => annonces.any(test);
    return FiltreVehicules(
      categorie: categorie != null && existe((v) => v.categorie == categorie)
          ? categorie
          : null,
      marque: marque != null && existe((v) => v.marque.trim() == marque)
          ? marque
          : null,
      prixMax: prixMax,
      placesMin: placesMin != null && existe((v) => v.nbPlaces == placesMin)
          ? placesMin
          : null,
      boite: boite != null && existe((v) => v.boiteLibelle.trim() == boite)
          ? boite
          : null,
      avecChauffeur: avecChauffeur && existe((v) => v.chauffeurDisponible),
      mode: mode,
    );
  }

  /// Même filtre, sans les critères que la feuille ne propose pas dans
  /// [options] (ligne masquée : une seule valeur possible) ; ils repassent
  /// à leur valeur neutre.
  FiltreVehicules limiteAuxOptions(OptionsFiltreVehicules options) {
    T? propose<T>(T? valeur, Iterable<T> valeurs) =>
        valeurs.contains(valeur) ? valeur : null;
    return FiltreVehicules(
      categorie: propose(categorie, options.categories.map((c) => c.$1)),
      marque: propose(marque, options.marques),
      prixMax: propose(prixMax, options.prix),
      placesMin: propose(placesMin, options.places),
      boite: propose(boite, options.boites),
      avecChauffeur: avecChauffeur && options.chauffeur,
      mode: mode,
    );
  }

  /// Nombre de critères actifs (pastille du bouton « Filtrer »).
  int get nombre => [
    categorie != null,
    marque != null,
    prixMax != null,
    placesMin != null,
    boite != null,
    avecChauffeur,
  ].where((actif) => actif).length;

  /// Paramètres de requête : seuls les véhicules disponibles, du type
  /// choisi. Les autres critères sont appliqués dans l'app.
  Map<String, dynamic> get parametres => {'disponible': 1, 'mode': ?mode};

  /// Signature stable de la requête, pour la clé de cache.
  String get cle =>
      (parametres.entries.map((e) => '${e.key}=${e.value}').toList()..sort())
          .join('&');

  /// Vrai si [v] passe tous les critères ([achat] : prix de vente).
  bool garde(VehiculeResume v, {required bool achat}) {
    if (categorie != null && v.categorie != categorie) return false;
    if (marque != null && v.marque.trim() != marque) return false;
    if (prixMax != null) {
      final prix = prixVehicule(v, achat: achat);
      if (prix == null || prix > prixMax!) return false;
    }
    if (placesMin != null && v.nbPlaces < placesMin!) return false;
    if (boite != null && v.boiteLibelle.trim() != boite) return false;
    if (avecChauffeur && !v.chauffeurDisponible) return false;
    return true;
  }

  List<VehiculeResume> appliquer(
    List<VehiculeResume> vehicules, {
    required bool achat,
  }) => [
    for (final v in vehicules)
      if (garde(v, achat: achat)) v,
  ];

  @override
  bool operator ==(Object other) =>
      other is FiltreVehicules &&
      other.categorie == categorie &&
      other.marque == marque &&
      other.prixMax == prixMax &&
      other.placesMin == placesMin &&
      other.boite == boite &&
      other.avecChauffeur == avecChauffeur &&
      other.mode == mode;

  @override
  int get hashCode => Object.hash(
    categorie,
    marque,
    prixMax,
    placesMin,
    boite,
    avecChauffeur,
    mode,
  );
}

/// Valeurs proposées par la feuille « Filtrer », calculées sur les
/// annonces du loueur pour le type affiché. Une liste vide = ligne masquée
/// (moins de deux valeurs possibles : le filtre ne changerait rien).
class OptionsFiltreVehicules {
  const OptionsFiltreVehicules({
    this.categories = const [],
    this.marques = const [],
    this.prix = const [],
    this.places = const [],
    this.boites = const [],
    this.chauffeur = false,
  });

  factory OptionsFiltreVehicules.depuis(
    List<VehiculeResume> vehicules, {
    required bool achat,
  }) {
    String? texte(String t) => t.trim().isEmpty ? null : t.trim();
    final libelles = <String, String>{
      for (final v in vehicules)
        if (texte(v.categorie) != null)
          v.categorie: texte(v.categorieLibelle) ?? lisible(v.categorie),
    };
    final categories = _siPlusieurs(
      vehicules.map((v) => texte(v.categorie)),
      ordre: (a, b) =>
          libelles[a]!.toLowerCase().compareTo(libelles[b]!.toLowerCase()),
    );
    final avecChauffeur = vehicules.where((v) => v.chauffeurDisponible).length;
    return OptionsFiltreVehicules(
      categories: [for (final c in categories) (c, libelles[c]!)],
      marques: _siPlusieurs(
        vehicules.map((v) => texte(v.marque)),
        ordre: (a, b) => a.toLowerCase().compareTo(b.toLowerCase()),
      ),
      prix: _siPlusieurs(
        vehicules.map((v) => prixVehicule(v, achat: achat)),
        ordre: (a, b) => a.compareTo(b),
      ),
      places: _siPlusieurs(
        vehicules.map((v) => v.nbPlaces > 0 ? v.nbPlaces : null),
        ordre: (a, b) => a.compareTo(b),
      ),
      boites: _siPlusieurs(
        vehicules.map((v) => texte(v.boiteLibelle)),
        ordre: (a, b) => a.toLowerCase().compareTo(b.toLowerCase()),
      ),
      chauffeur: avecChauffeur > 0 && avecChauffeur < vehicules.length,
    );
  }

  /// (code, libellé), triées par libellé.
  final List<(String, String)> categories;
  final List<String> marques;

  /// Prix distincts, du plus bas au plus haut.
  final List<int> prix;
  final List<int> places;
  final List<String> boites;

  /// Ligne « Avec chauffeur » : certains véhicules seulement en ont un.
  final bool chauffeur;

  /// Valeurs connues triées, si au moins deux valeurs distinctes existent
  /// (une valeur absente compte : choisir la seule connue filtre encore).
  static List<T> _siPlusieurs<T extends Object>(
    Iterable<T?> valeurs, {
    required int Function(T, T) ordre,
  }) {
    final distinctes = valeurs.toSet();
    final connues = distinctes.whereType<T>().toList()..sort(ordre);
    return distinctes.length >= 2 ? connues : const [];
  }
}
