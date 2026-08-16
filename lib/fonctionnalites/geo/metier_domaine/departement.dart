import 'package:freezed_annotation/freezed_annotation.dart';
part 'departement.freezed.dart';
part 'departement.g.dart';

/// Departement administratif, seul niveau choisi par l'utilisateur.
/// La region et le district sont deduits cote backend.
@freezed
abstract class Departement with _$Departement {
  const factory Departement({
    required int id,
    @Default('') String nom,
    @Default('') String region,
    @Default('') String district,
  }) = _Departement;

  factory Departement.fromJson(Map<String, dynamic> json) =>
      _$DepartementFromJson(json);
}
