// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demande_intervention.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhotoDemande _$PhotoDemandeFromJson(Map<String, dynamic> json) =>
    _PhotoDemande(
      id: (json['id'] as num).toInt(),
      image: json['image'] as String? ?? '',
      legende: json['legende'] as String? ?? '',
      ordre: (json['ordre'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PhotoDemandeToJson(_PhotoDemande instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'legende': instance.legende,
      'ordre': instance.ordre,
    };

_DemandeIntervention _$DemandeInterventionFromJson(Map<String, dynamic> json) =>
    _DemandeIntervention(
      id: (json['id'] as num).toInt(),
      numero: json['numero'] as String? ?? '',
      user: (json['user'] as num?)?.toInt(),
      clientNom: json['client_nom'] as String? ?? '',
      clientTelephone: json['client_telephone'] as String? ?? '',
      artisan: (json['artisan'] as num?)?.toInt(),
      artisanNom: json['artisan_nom'] as String? ?? '',
      artisanTelephone: json['artisan_telephone'] as String? ?? '',
      typeIntervention: json['type_intervention'] as String? ?? 'reparation',
      typeLibre: json['type_libre'] as String? ?? '',
      description: json['description'] as String? ?? '',
      urgence: json['urgence'] as String? ?? 'flexible',
      adresse: (json['adresse'] as num?)?.toInt(),
      adresseSnapshot: json['adresse_snapshot'] as String? ?? '',
      descriptionAcces: json['description_acces'] as String? ?? '',
      latitude: _versDoubleNullable(json['latitude']),
      longitude: _versDoubleNullable(json['longitude']),
      disponibilitePreferee:
          json['disponibilite_preferee'] as String? ?? 'indifferent',
      statut: json['statut'] as String? ?? 'en_attente',
      dateProposee: json['date_proposee'] as String?,
      prixPropose: _versIntNullable(json['prix_propose']),
      raisonRefus: json['raison_refus'] as String? ?? '',
      conversation: (json['conversation'] as num?)?.toInt(),
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => PhotoDemande.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PhotoDemande>[],
      createdAt: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$DemandeInterventionToJson(
  _DemandeIntervention instance,
) => <String, dynamic>{
  'id': instance.id,
  'numero': instance.numero,
  'user': instance.user,
  'client_nom': instance.clientNom,
  'client_telephone': instance.clientTelephone,
  'artisan': instance.artisan,
  'artisan_nom': instance.artisanNom,
  'artisan_telephone': instance.artisanTelephone,
  'type_intervention': instance.typeIntervention,
  'type_libre': instance.typeLibre,
  'description': instance.description,
  'urgence': instance.urgence,
  'adresse': instance.adresse,
  'adresse_snapshot': instance.adresseSnapshot,
  'description_acces': instance.descriptionAcces,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'disponibilite_preferee': instance.disponibilitePreferee,
  'statut': instance.statut,
  'date_proposee': instance.dateProposee,
  'prix_propose': instance.prixPropose,
  'raison_refus': instance.raisonRefus,
  'conversation': instance.conversation,
  'photos': instance.photos,
  'created_at': instance.createdAt,
};
