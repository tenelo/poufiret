// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utilisateur.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Utilisateur _$UtilisateurFromJson(Map<String, dynamic> json) => _Utilisateur(
  id: (json['id'] as num).toInt(),
  telephone: json['telephone'] as String,
  username: json['username'] as String?,
  prenom: json['first_name'] as String? ?? '',
  nom: json['last_name'] as String? ?? '',
  role: json['role'] as String? ?? 'client',
  estVerifie: json['est_verifie'] as bool? ?? false,
  languePreferee: json['langue_preferee'] as String? ?? 'fr',
  tokenFcm: json['token_fcm'] as String?,
);

Map<String, dynamic> _$UtilisateurToJson(_Utilisateur instance) =>
    <String, dynamic>{
      'id': instance.id,
      'telephone': instance.telephone,
      'username': instance.username,
      'first_name': instance.prenom,
      'last_name': instance.nom,
      'role': instance.role,
      'est_verifie': instance.estVerifie,
      'langue_preferee': instance.languePreferee,
      'token_fcm': instance.tokenFcm,
    };
