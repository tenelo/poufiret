import 'package:freezed_annotation/freezed_annotation.dart';

part 'localite.freezed.dart';
part 'localite.g.dart';

/// Une localité (ville, village) d'un département, gérée par l'admin.
@freezed
abstract class Localite with _$Localite {
  const factory Localite({required int id, @Default('') String nom}) =
      _Localite;

  factory Localite.fromJson(Map<String, dynamic> json) =>
      _$LocaliteFromJson(json);
}
