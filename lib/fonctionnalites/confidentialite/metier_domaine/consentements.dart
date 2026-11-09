/// Version du texte de consentement en vigueur. Un utilisateur dont la
/// version enregistrée diffère (ou est absente) voit la feuille de choix.
const versionConsentement = '2026-11';

/// Choix de l'utilisateur sur l'usage de ses données.
class Consentements {
  const Consentements({
    this.statistiques = false,
    this.ia = false,
    this.version,
  });

  factory Consentements.fromJson(Map<String, dynamic> json) => Consentements(
    statistiques: json['consentement_statistiques'] == true,
    ia: json['consentement_ia'] == true,
    version: json['consentement_version'] as String?,
  );

  /// Statistiques anonymes d'usage.
  final bool statistiques;

  /// Contribution à l'IA de Poufiret.
  final bool ia;

  /// Version du texte accepté (null : jamais répondu).
  final String? version;
}

/// La feuille de choix est à montrer : jamais répondu, ou texte changé
/// depuis la dernière réponse.
bool doitDemanderConsentement(String? version) =>
    version != versionConsentement;
