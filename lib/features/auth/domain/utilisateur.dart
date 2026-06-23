import 'package:freezed_annotation/freezed_annotation.dart';

part 'utilisateur.freezed.dart';
part 'utilisateur.g.dart';

@freezed
abstract class Utilisateur with _$Utilisateur {
  const Utilisateur._(); // requis pour exposer des getters perso

  const factory Utilisateur({
    required int id,
    required String telephone,
    String? username,
    @JsonKey(name: 'first_name') @Default('') String prenom,
    @JsonKey(name: 'last_name') @Default('') String nom,
    @Default('client') String role, // client | partenaire | admin
    @JsonKey(name: 'est_verifie') @Default(false) bool estVerifie,
    @JsonKey(name: 'langue_preferee') @Default('fr') String languePreferee,
    @JsonKey(name: 'token_fcm') String? tokenFcm,
  }) = _Utilisateur;

  factory Utilisateur.fromJson(Map<String, dynamic> json) =>
      _$UtilisateurFromJson(json);

  // Dérivés pratiques pour l'UI, basés sur le rôle réel.
  bool get estPartenaire => role == 'partenaire';
  bool get estAdmin => role == 'admin';

  String get nomComplet {
    final complet = '$prenom $nom'.trim();
    return complet.isEmpty ? (username ?? telephone) : complet;
  }
}
