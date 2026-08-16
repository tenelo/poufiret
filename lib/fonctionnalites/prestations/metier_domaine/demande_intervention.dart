import 'package:freezed_annotation/freezed_annotation.dart';

part 'demande_intervention.freezed.dart';
part 'demande_intervention.g.dart';

/// Le backend renvoie les montants en String ("15000"), int ou double.
int _versInt(dynamic valeur) {
  if (valeur == null) return 0;
  if (valeur is int) return valeur;
  if (valeur is double) return valeur.round();
  return int.tryParse(valeur.toString().split('.').first) ?? 0;
}

int? _versIntNullable(dynamic valeur) {
  if (valeur == null) return null;
  return _versInt(valeur);
}

double? _versDoubleNullable(dynamic valeur) {
  if (valeur == null) return null;
  if (valeur is num) return valeur.toDouble();
  return double.tryParse(valeur.toString());
}

@freezed
abstract class PhotoDemande with _$PhotoDemande {
  const factory PhotoDemande({
    required int id,
    @Default('') String image,
    @Default('') String legende,
    @Default(0) int ordre,
  }) = _PhotoDemande;

  factory PhotoDemande.fromJson(Map<String, dynamic> json) =>
      _$PhotoDemandeFromJson(json);
}

@freezed
abstract class DemandeIntervention with _$DemandeIntervention {
  const DemandeIntervention._();

  const factory DemandeIntervention({
    required int id,
    @Default('') String numero,
    int? user,
    @JsonKey(name: 'client_nom') @Default('') String clientNom,
    @JsonKey(name: 'client_telephone') @Default('') String clientTelephone,
    int? artisan,
    @JsonKey(name: 'artisan_nom') @Default('') String artisanNom,
    @JsonKey(name: 'artisan_telephone') @Default('') String artisanTelephone,
    @JsonKey(name: 'type_intervention') @Default('reparation') String typeIntervention,
    @JsonKey(name: 'type_libre') @Default('') String typeLibre,
    @Default('') String description,
    @Default('flexible') String urgence,
    int? adresse,
    @JsonKey(name: 'adresse_snapshot') @Default('') String adresseSnapshot,
    @JsonKey(name: 'description_acces') @Default('') String descriptionAcces,
    @JsonKey(fromJson: _versDoubleNullable) double? latitude,
    @JsonKey(fromJson: _versDoubleNullable) double? longitude,
    @JsonKey(name: 'disponibilite_preferee') @Default('indifferent') String disponibilitePreferee,
    @Default('en_attente') String statut,
    @JsonKey(name: 'date_proposee') String? dateProposee,
    @JsonKey(name: 'prix_propose', fromJson: _versIntNullable) int? prixPropose,
    @JsonKey(name: 'raison_refus') @Default('') String raisonRefus,
    int? conversation,
    @Default(<PhotoDemande>[]) List<PhotoDemande> photos,
    @JsonKey(name: 'created_at') @Default('') String createdAt,
  }) = _DemandeIntervention;

  factory DemandeIntervention.fromJson(Map<String, dynamic> json) =>
      _$DemandeInterventionFromJson(json);

  // ── Libellés d'affichage ───────────────────────────────────────────
  String get typeLibelle => switch (typeIntervention) {
        'reparation' => 'Réparation',
        'installation' => 'Installation',
        'depannage_urgent' => 'Dépannage urgent',
        'devis' => 'Demande de devis',
        'autre' => typeLibre.isNotEmpty ? typeLibre : 'Autre',
        _ => typeIntervention,
      };

  String get urgenceLibelle => switch (urgence) {
        'urgent' => 'Urgent (dans la journée)',
        'cette_semaine' => 'Cette semaine',
        'flexible' => 'Flexible',
        _ => urgence,
      };

  String get disponibiliteLibelle => switch (disponibilitePreferee) {
        'matin' => 'Matin',
        'aprem' => 'Après-midi',
        'soir' => 'Soir',
        'indifferent' => 'Indifférent',
        _ => disponibilitePreferee,
      };

  String get statutLibelle => switch (statut) {
        'en_attente' => 'En attente',
        'acceptee' => 'Acceptée',
        'refusee' => 'Refusée',
        'en_cours' => 'En cours',
        'terminee' => 'Terminée',
        'annulee' => 'Annulée',
        _ => statut,
      };

  /// Transitions autorisées (miroir du dict TRANSITIONS backend).
  List<String> get transitionsPossibles => switch (statut) {
        'en_attente' => ['acceptee', 'refusee', 'annulee'],
        'acceptee' => ['en_cours', 'annulee'],
        'en_cours' => ['terminee', 'annulee'],
        _ => <String>[],
      };

  bool get estFinale =>
      statut == 'terminee' || statut == 'refusee' || statut == 'annulee';

  bool get aPosition => latitude != null && longitude != null;
}
