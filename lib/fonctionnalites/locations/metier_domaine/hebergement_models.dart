import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../global/json/convertisseurs.dart';
import '../../../global/ui/format_montant.dart';
import 'location_models.dart';
import 'vehicule_models.dart' show jourSeul;

part 'hebergement_models.freezed.dart';
part 'hebergement_models.g.dart';

// ── Convertisseurs tolérants propres aux hôtels ───────────────────────────

/// Liste de textes : chaînes telles quelles, objets `{valeur, libelle}`
/// réduits à leur valeur (ou libellé, ou nom).
List<String> versListeTextes(dynamic valeur) {
  if (valeur is! List) return const [];
  return [
    for (final e in valeur)
      if (e is Map)
        (e['valeur'] ?? e['libelle'] ?? e['nom'] ?? '').toString()
      else if (e != null)
        e.toString(),
  ].where((t) => t.isNotEmpty).toList();
}

/// Lits : texte libre (« 1 lit double ») ou nombre (2 → « 2 lits »).
String versTexteLits(dynamic valeur) {
  if (valeur == null) return '';
  if (valeur is num) return valeur > 0 ? pluriel(valeur.round(), 'lit') : '';
  return valeur.toString();
}

/// Petit-déjeuner : booléen (true → « inclus ») ou code texte.
String versCodePetitDejeuner(dynamic valeur) => switch (valeur) {
  null => '',
  true => 'inclus',
  false => 'non',
  _ => valeur.toString(),
};

/// Durée minimale, sous l'un des noms possibles.
Object? lireDureeMin(Map json, String _) =>
    json['duree_min_nuits'] ??
    json['duree_min_jours'] ??
    json['duree_minimale'];

/// « 14:00:00 » ou « 14:00 » → « 14h00 » ; tout autre texte tel quel.
String formatHeure(String heure) {
  final m = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(heure.trim());
  if (m == null) return heure.trim();
  return '${m.group(1)!.padLeft(2, '0')}h${m.group(2)}';
}

/// Établissement (hôtel, résidence) : l'en-tête de sa page.
@freezed
abstract class Etablissement with _$Etablissement {
  const Etablissement._();

  const factory Etablissement({
    @JsonKey(fromJson: versInt) @Default(0) int id,
    @Default('') String nom,
    @Default('') String logo,
    @Default('') String couverture,
    @JsonKey(name: 'telephone_pro') @Default('') String telephonePro,
    @Default('') String whatsapp,
    @JsonKey(name: 'type_etablissement') @Default('') String typeEtablissement,
    @JsonKey(name: 'type_etablissement_libelle')
    @Default('')
    String typeEtablissementLibelle,
    @Default('') String description,
    @Default(<String>[]) List<String> galerie,
    @Default(<Panorama>[]) List<Panorama> panoramas,
    @JsonKey(fromJson: versIntNullable) int? etoiles,
    @JsonKey(name: 'localisation_texte') @Default('') String localisationTexte,
    @JsonKey(fromJson: versDoubleNullable) double? latitude,
    @JsonKey(fromJson: versDoubleNullable) double? longitude,
    @JsonKey(name: 'heure_arrivee') @Default('') String heureArrivee,
    @JsonKey(name: 'heure_depart') @Default('') String heureDepart,
    @JsonKey(name: 'equipements_etablissement', fromJson: versListeTextes)
    @Default(<String>[])
    List<String> equipements,

    /// inclus | en_option | non (ou booléen côté serveur).
    @JsonKey(name: 'petit_dejeuner', fromJson: versCodePetitDejeuner)
    @Default('')
    String petitDejeuner,
    @JsonKey(name: 'petit_dejeuner_libelle')
    @Default('')
    String petitDejeunerLibelle,
    @JsonKey(name: 'prix_petit_dejeuner', fromJson: versIntNullable)
    int? prixPetitDejeuner,
    @JsonKey(name: 'politique_annulation')
    @Default('')
    String politiqueAnnulation,
    @JsonKey(name: 'politique_annulation_libelle')
    @Default('')
    String politiqueAnnulationLibelle,
    @Default('') String conditions,
  }) = _Etablissement;

  factory Etablissement.fromJson(Map<String, dynamic> json) =>
      _$EtablissementFromJson(json);

  /// L'établissement vu comme un loueur (en-tête et contacts communs).
  Loueur get loueur => Loueur(
    id: id,
    nom: nom,
    logo: logo,
    couverture: couverture,
    telephonePro: telephonePro,
    whatsapp: whatsapp,
  );

  /// Vues 360° : actives, dans l'ordre voulu.
  List<Panorama> get panoramasActifs => panoramasVisibles(panoramas);

  bool get aPosition => latitude != null && longitude != null;

  /// Nombre d'étoiles affichables (1 à 5), 0 sinon.
  int get nbEtoiles => (etoiles ?? 0).clamp(0, 5);

  /// « Inclus », « En option (3 000 F) », « Non proposé » ; vide si inconnu.
  String get petitDejeunerLisible {
    if (petitDejeunerLibelle.isNotEmpty) {
      final prix = prixPetitDejeuner ?? 0;
      return petitDejeuner != 'inclus' && prix > 0
          ? '$petitDejeunerLibelle (${formatMontant(prix)})'
          : petitDejeunerLibelle;
    }
    final prix = prixPetitDejeuner ?? 0;
    return switch (petitDejeuner) {
      'inclus' => 'Inclus',
      'non' || 'aucun' =>
        prix > 0 ? 'En option (${formatMontant(prix)})' : 'Non proposé',
      '' => prix > 0 ? 'En option (${formatMontant(prix)})' : '',
      _ =>
        prix > 0
            ? '${lisible(petitDejeuner)} (${formatMontant(prix)})'
            : lisible(petitDejeuner),
    };
  }

  String get politiqueAnnulationLisible => politiqueAnnulationLibelle.isNotEmpty
      ? politiqueAnnulationLibelle
      : lisible(politiqueAnnulation);
}

/// Vues actives, dans l'ordre (établissement, hébergement).
List<Panorama> panoramasVisibles(List<Panorama> panoramas) =>
    panoramas.where((p) => p.estActive && p.image.isNotEmpty).toList()
      ..sort((a, b) => a.ordre.compareTo(b.ordre));

/// Un hébergement (chambre, suite, appartement) dans une liste.
@freezed
abstract class HebergementResume with _$HebergementResume {
  const HebergementResume._();

  const factory HebergementResume({
    required int id,
    @Default('') String titre,
    @Default('') String photo,
    @JsonKey(name: 'type_hebergement') @Default('') String typeHebergement,
    @JsonKey(name: 'type_hebergement_libelle')
    @Default('')
    String typeHebergementLibelle,
    @JsonKey(name: 'capacite_adultes', fromJson: versInt)
    @Default(0)
    int capaciteAdultes,
    @JsonKey(name: 'capacite_enfants', fromJson: versInt)
    @Default(0)
    int capaciteEnfants,
    @JsonKey(fromJson: versTexteLits) @Default('') String lits,
    @JsonKey(name: 'prix_nuit', fromJson: versInt) @Default(0) int prixNuit,
    @JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? prixSemaine,
    @JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? prixMois,
    @Default('') String disponibilite,
  }) = _HebergementResume;

  factory HebergementResume.fromJson(Map<String, dynamic> json) =>
      _$HebergementResumeFromJson(json);

  /// « 2 adultes · 1 enfant » (vide si la capacité est inconnue).
  String get capacite => capaciteAdultes > 0
      ? capaciteLisible(capaciteAdultes, capaciteEnfants)
      : '';

  int get capaciteTotale => capaciteAdultes + capaciteEnfants;

  /// Seuls les hébergements disponibles (ou sans statut) sont listés.
  bool get estDisponible =>
      disponibilite.isEmpty || disponibilite == 'disponible';

  /// Type affiché (libellé, sinon valeur rendue lisible).
  String get type => typeHebergementLibelle.isNotEmpty
      ? typeHebergementLibelle
      : lisible(typeHebergement);
}

/// Page d'un établissement : lui-même et ses hébergements.
@freezed
abstract class PageEtablissement with _$PageEtablissement {
  const PageEtablissement._();

  const factory PageEtablissement({
    required Etablissement etablissement,
    @Default(<HebergementResume>[]) List<HebergementResume> hebergements,
  }) = _PageEtablissement;

  factory PageEtablissement.fromJson(Map<String, dynamic> json) =>
      _$PageEtablissementFromJson(json);

  /// Hébergements disponibles.
  List<HebergementResume> get disponibles =>
      hebergements.where((h) => h.estDisponible).toList();
}

/// Fiche complète d'un hébergement.
@freezed
abstract class Hebergement with _$Hebergement {
  const Hebergement._();

  const factory Hebergement({
    required int id,
    @Default('') String titre,
    @Default('') String description,
    @Default(<String>[]) List<String> galerie,
    @Default(<Panorama>[]) List<Panorama> panoramas,
    @JsonKey(name: 'type_hebergement') @Default('') String typeHebergement,
    @JsonKey(name: 'type_hebergement_libelle')
    @Default('')
    String typeHebergementLibelle,
    @JsonKey(name: 'capacite_adultes', fromJson: versInt)
    @Default(0)
    int capaciteAdultes,
    @JsonKey(name: 'capacite_enfants', fromJson: versInt)
    @Default(0)
    int capaciteEnfants,
    @JsonKey(fromJson: versTexteLits) @Default('') String lits,
    @JsonKey(name: 'surface_m2', fromJson: versIntNullable) int? surfaceM2,
    @JsonKey(fromJson: versListeTextes)
    @Default(<String>[])
    List<String> equipements,
    @JsonKey(name: 'prix_nuit', fromJson: versInt) @Default(0) int prixNuit,
    @JsonKey(name: 'prix_semaine', fromJson: versIntNullable) int? prixSemaine,
    @JsonKey(name: 'prix_mois', fromJson: versIntNullable) int? prixMois,
    @JsonKey(readValue: lireDureeMin, fromJson: versInt)
    @Default(1)
    int dureeMinNuits,

    /// Nombre total d'unités (chambres) de ce type.
    @JsonKey(name: 'nb_unites', fromJson: versInt) @Default(0) int nbUnites,

    /// Unités libres sur les dates demandées (si elles l'ont été).
    @JsonKey(name: 'unites_disponibles', fromJson: versIntNullable)
    int? unitesDisponibles,
    @JsonKey(name: 'heure_arrivee') @Default('') String heureArrivee,
    @JsonKey(name: 'heure_depart') @Default('') String heureDepart,
    @Default('') String disponibilite,
    Etablissement? etablissement,
  }) = _Hebergement;

  factory Hebergement.fromJson(Map<String, dynamic> json) =>
      _$HebergementFromJson(json);

  List<Panorama> get panoramasActifs => panoramasVisibles(panoramas);

  String get type => typeHebergementLibelle.isNotEmpty
      ? typeHebergementLibelle
      : lisible(typeHebergement);

  String get capacite => capaciteAdultes > 0
      ? capaciteLisible(capaciteAdultes, capaciteEnfants)
      : '';

  /// Heures propres à l'hébergement, sinon celles de l'établissement.
  String get arrivee => heureArrivee.isNotEmpty
      ? heureArrivee
      : etablissement?.heureArrivee ?? '';
  String get depart =>
      heureDepart.isNotEmpty ? heureDepart : etablissement?.heureDepart ?? '';

  /// Durée minimale effective (au moins une nuit).
  int get dureeMin => dureeMinNuits < 1 ? 1 : dureeMinNuits;

  /// Plafond du nombre de chambres : les unités libres si on les connaît,
  /// sinon le total du type (10 si inconnu).
  int maxUnites(int? disponibles) {
    final plafond = disponibles ?? (nbUnites > 0 ? nbUnites : 10);
    return plafond < 1 ? 1 : plafond;
  }

  /// Plafond d'adultes pour [unites] chambres (20 si capacité inconnue).
  int maxAdultes(int unites) =>
      capaciteAdultes > 0 ? capaciteAdultes * unites : 20;

  /// Plafond d'enfants pour [unites] chambres : aucun si la capacité est
  /// connue sans place enfant, 10 si rien n'est connu.
  int maxEnfants(int unites) => capaciteEnfants > 0
      ? capaciteEnfants * unites
      : capaciteAdultes > 0
      ? 0
      : 10;

  /// Problème du séjour choisi, ou null s'il convient.
  String? erreurSejour(DateTime arrivee, DateTime depart) {
    if (!jourSeul(depart).isAfter(jourSeul(arrivee))) {
      return "La date de départ doit suivre celle d'arrivée.";
    }
    if (nombreNuits(arrivee, depart) < dureeMin) {
      return 'Durée minimale de séjour : ${pluriel(dureeMin, 'nuit')}.';
    }
    return null;
  }
}

/// Nuits entre l'arrivée et le départ : du 10 au 13 = 3 nuits.
int nombreNuits(DateTime arrivee, DateTime depart) {
  final a = jourSeul(arrivee), d = jourSeul(depart);
  // Arrondi : un changement d'heure ne fausse pas le compte.
  final nuits = (d.difference(a).inHours / 24).round();
  return nuits < 0 ? 0 : nuits;
}

/// « 3 chambres disponibles », « 1 chambre disponible », « Complet sur ces
/// dates ».
String libelleDisponibilite(int unites) => unites <= 0
    ? 'Complet sur ces dates'
    : pluriel(unites, 'chambre disponible', 'chambres disponibles');

/// Montant estimé d'un séjour, recalculé à chaque changement.
class EstimationSejour {
  const EstimationSejour({
    required this.nuits,
    required this.prixNuit,
    required this.unites,
  });

  final int nuits;
  final int prixNuit;
  final int unites;

  int get total => nuits * prixNuit * unites;

  /// « 3 nuits × 25 000 F × 1 chambre = 75 000 F ».
  String get libelle =>
      '${pluriel(nuits, 'nuit')} × ${formatMontant(prixNuit)} × '
      '${pluriel(unites, 'chambre')} = ${formatMontant(total)}';
}

/// Filtres des hébergements d'un établissement, appliqués à la liste reçue
/// (la page arrive en une fois).
class FiltreHebergements {
  const FiltreHebergements({this.type, this.prixMax, this.capacite});

  final String? type;
  final int? prixMax;

  /// Personnes à loger (adultes + enfants), au minimum.
  final int? capacite;

  int get nombre => [
    type != null,
    prixMax != null,
    capacite != null,
  ].where((actif) => actif).length;

  bool garde(HebergementResume h) =>
      (type == null || h.typeHebergement == type) &&
      (prixMax == null || h.prixNuit <= prixMax!) &&
      (capacite == null || h.capaciteTotale >= capacite!);

  List<HebergementResume> appliquer(List<HebergementResume> liste) =>
      liste.where(garde).toList();

  @override
  bool operator ==(Object other) =>
      other is FiltreHebergements &&
      other.type == type &&
      other.prixMax == prixMax &&
      other.capacite == capacite;

  @override
  int get hashCode => Object.hash(type, prixMax, capacite);
}
