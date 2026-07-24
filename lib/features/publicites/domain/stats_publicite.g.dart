// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_publicite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatsPublicite _$StatsPubliciteFromJson(Map<String, dynamic> json) =>
    _StatsPublicite(
      id: json['id'] as String,
      titre: json['titre'] as String? ?? '',
      formule: json['formule'] as String? ?? '',
      statut: json['statut'] as String? ?? '',
      statsDisponibles: json['stats_disponibles'] as bool? ?? true,
      personnesTouchees: (json['nb_personnes_touchees'] as num?)?.toInt() ?? 0,
      impressions: (json['nb_impressions'] as num?)?.toInt() ?? 0,
      clics: (json['nb_clics'] as num?)?.toInt() ?? 0,
      tauxClic: json['taux_clic'] as num? ?? 0,
      impressionsParType:
          json['impressions_par_type'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
      ciblePourcentage: (json['cible_pourcentage'] as num?)?.toInt(),
      cibleAtteinte: json['cible_atteinte'] as bool? ?? false,
      debutDiffusion: json['debut_diffusion'] as String?,
      finDiffusion: json['fin_diffusion'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$StatsPubliciteToJson(_StatsPublicite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'formule': instance.formule,
      'statut': instance.statut,
      'stats_disponibles': instance.statsDisponibles,
      'nb_personnes_touchees': instance.personnesTouchees,
      'nb_impressions': instance.impressions,
      'nb_clics': instance.clics,
      'taux_clic': instance.tauxClic,
      'impressions_par_type': instance.impressionsParType,
      'cible_pourcentage': instance.ciblePourcentage,
      'cible_atteinte': instance.cibleAtteinte,
      'debut_diffusion': instance.debutDiffusion,
      'fin_diffusion': instance.finDiffusion,
      'message': instance.message,
    };
