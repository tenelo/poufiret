// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publicite_liste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PubliciteListe _$PubliciteListeFromJson(Map<String, dynamic> json) =>
    _PubliciteListe(
      id: json['id'] as String,
      titre: json['titre'] as String? ?? '',
      imageCouverture: json['image_couverture'] as String?,
      partenaireId: (json['partenaire_id'] as num?)?.toInt(),
      dureeAffichageSecondes:
          (json['duree_affichage_secondes'] as num?)?.toInt() ?? 5,
      priorite: (json['priorite'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PubliciteListeToJson(_PubliciteListe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'image_couverture': instance.imageCouverture,
      'partenaire_id': instance.partenaireId,
      'duree_affichage_secondes': instance.dureeAffichageSecondes,
      'priorite': instance.priorite,
    };
