import 'package:freezed_annotation/freezed_annotation.dart';

part 'quartier.freezed.dart';
part 'quartier.g.dart';

/// Un quartier d'un departement (autocompletion des points de livraison).
@freezed
abstract class Quartier with _$Quartier {
  const factory Quartier({
    required int id,
    @Default('') String nom,
  }) = _Quartier;

  factory Quartier.fromJson(Map<String, dynamic> json) =>
      _$QuartierFromJson(json);
}
