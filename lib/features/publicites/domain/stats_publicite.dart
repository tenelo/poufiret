import 'package:freezed_annotation/freezed_annotation.dart';
part 'stats_publicite.freezed.dart';
part 'stats_publicite.g.dart';

/// Resultats d'une campagne, vus par le partenaire.
///
/// Quand l'administration n'a pas encore ouvert les statistiques
/// (`stats_visibles_partenaire`), seuls le titre, la formule et le
/// statut sont renseignes.
@freezed
abstract class StatsPublicite with _$StatsPublicite {
  const StatsPublicite._();

  const factory StatsPublicite({
    required String id,
    @Default('') String titre,
    @Default('') String formule,
    @Default('') String statut,
    @JsonKey(name: 'stats_disponibles') @Default(true) bool statsDisponibles,
    @JsonKey(name: 'nb_personnes_touchees') @Default(0) int personnesTouchees,
    @JsonKey(name: 'nb_impressions') @Default(0) int impressions,
    @JsonKey(name: 'nb_clics') @Default(0) int clics,
    @JsonKey(name: 'taux_clic') @Default(0) num tauxClic,
    @JsonKey(name: 'impressions_par_type')
    @Default(<String, dynamic>{})
    Map<String, dynamic> impressionsParType,
    @JsonKey(name: 'cible_pourcentage') int? ciblePourcentage,
    @JsonKey(name: 'cible_atteinte') @Default(false) bool cibleAtteinte,
    @JsonKey(name: 'debut_diffusion') String? debutDiffusion,
    @JsonKey(name: 'fin_diffusion') String? finDiffusion,
    String? message,
  }) = _StatsPublicite;

  factory StatsPublicite.fromJson(Map<String, dynamic> json) =>
      _$StatsPubliciteFromJson(json);

  bool get estActive => statut == 'active';

  /// Libelle lisible du statut, pour l'affichage.
  String get statutLisible => const {
        'brouillon': 'Brouillon',
        'en_attente_paiement': 'En attente de paiement',
        'en_attente_validation': 'En attente de validation',
        'active': 'En diffusion',
        'terminee': 'Terminée',
        'rejetee': 'Rejetée',
      }[statut] ??
      statut;
}
