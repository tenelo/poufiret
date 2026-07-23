// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formule_publicite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormulePublicite _$FormulePubliciteFromJson(Map<String, dynamic> json) =>
    _FormulePublicite(
      id: json['id'] as String,
      nom: json['nom'] as String? ?? '',
      prix: (json['prix'] as num?)?.toInt() ?? 0,
      priorite: (json['priorite'] as num?)?.toInt() ?? 0,
      dureeJours: (json['duree_jours'] as num?)?.toInt() ?? 1,
      passagesParJour: (json['passages_par_jour'] as num?)?.toInt() ?? 1,
      dureeAffichageSecondes:
          (json['duree_affichage_secondes'] as num?)?.toInt() ?? 5,
      quotaPartenaires: (json['quota_partenaires'] as num?)?.toInt() ?? 50,
      accesHeuresAffluence: json['acces_heures_affluence'] as bool? ?? false,
      typesAffichage:
          (json['types_affichage'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      nbImagesMax: (json['nb_images_max'] as num?)?.toInt() ?? 1,
      videoAutorisee: json['video_autorisee'] as bool? ?? false,
      dureeVideoMaxSecondes:
          (json['duree_video_max_secondes'] as num?)?.toInt() ?? 30,
      ciblePourcentageActifs: (json['cible_pourcentage_actifs'] as num?)
          ?.toInt(),
    );

Map<String, dynamic> _$FormulePubliciteToJson(_FormulePublicite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prix': instance.prix,
      'priorite': instance.priorite,
      'duree_jours': instance.dureeJours,
      'passages_par_jour': instance.passagesParJour,
      'duree_affichage_secondes': instance.dureeAffichageSecondes,
      'quota_partenaires': instance.quotaPartenaires,
      'acces_heures_affluence': instance.accesHeuresAffluence,
      'types_affichage': instance.typesAffichage,
      'nb_images_max': instance.nbImagesMax,
      'video_autorisee': instance.videoAutorisee,
      'duree_video_max_secondes': instance.dureeVideoMaxSecondes,
      'cible_pourcentage_actifs': instance.ciblePourcentageActifs,
    };
