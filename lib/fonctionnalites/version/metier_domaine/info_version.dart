/// Résultat du contrôle de version renvoyé par le backend.
///
/// Statuts possibles : 'a_jour', 'conseillee', 'obligatoire'.
class InfoVersion {
  const InfoVersion({
    required this.statut,
    required this.obligatoire,
    required this.lienStore,
    required this.message,
  });

  final String statut;
  final bool obligatoire;
  final String lienStore;
  final String message;

  bool get estAJour => statut == 'a_jour';
  bool get estConseillee => statut == 'conseillee';

  factory InfoVersion.fromJson(Map<String, dynamic> json) => InfoVersion(
        statut: (json['statut'] ?? 'a_jour').toString(),
        obligatoire: json['obligatoire'] == true,
        lienStore: (json['lien_store'] ?? '').toString(),
        message: (json['message'] ?? '').toString(),
      );

  /// Valeur de repli sûre : en cas d'échec réseau, on ne bloque JAMAIS.
  /// Le contrôle de version ne doit pas empêcher d'utiliser l'app si le
  /// serveur est injoignable au démarrage.
  static const InfoVersion aJourParDefaut = InfoVersion(
    statut: 'a_jour',
    obligatoire: false,
    lienStore: '',
    message: '',
  );
}
