import 'package:freezed_annotation/freezed_annotation.dart';
part 'credit_formule.freezed.dart';
part 'credit_formule.g.dart';

/// Credit de formule publicitaire attribue a un partenaire.
///
/// Permet d'activer une publicite gratuitement (sans passer par le
/// cycle de paiement) en le referencant via `credit_id` a la creation.
@freezed
abstract class CreditFormule with _$CreditFormule {
  const CreditFormule._();

  const factory CreditFormule({
    required String id,
    @JsonKey(name: 'formule_id') required String formuleId,
    @JsonKey(name: 'formule_nom') @Default('') String formuleNom,
    @JsonKey(name: 'formule_prix') @Default(0) int formulePrix,
    @JsonKey(name: 'formule_types_affichage')
    @Default(<String>[])
    List<String> formuleTypesAffichage,
    @Default('disponible') String statut,
    @JsonKey(name: 'cree_le') String? creeLe,
    @JsonKey(name: 'consomme_le') String? consommeLe,
    @JsonKey(name: 'publicite_consommatrice_id') String? publiciteConsommatriceId,
  }) = _CreditFormule;

  factory CreditFormule.fromJson(Map<String, dynamic> json) =>
      _$CreditFormuleFromJson(json);

  bool get estDisponible => statut == 'disponible';
}
