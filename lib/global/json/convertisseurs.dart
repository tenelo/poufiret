// Convertisseurs JSON tolérants, partagés par les modèles.

/// Convertit un montant reçu en int, quel que soit son format JSON
/// (int, double comme 7000.0, ou String comme "3500.00").
int versInt(dynamic valeur) {
  if (valeur == null) return 0;
  if (valeur is int) return valeur;
  if (valeur is num) return valeur.round();
  return double.tryParse(valeur.toString())?.round() ?? 0;
}

/// Comme [versInt], mais conserve l'absence de valeur.
int? versIntNullable(dynamic valeur) {
  if (valeur == null || valeur == '') return null;
  return versInt(valeur);
}

/// Coordonnée ou décimal, reçu en nombre ou en chaîne.
double? versDoubleNullable(dynamic valeur) {
  if (valeur == null) return null;
  if (valeur is num) return valeur.toDouble();
  return double.tryParse(valeur.toString());
}
