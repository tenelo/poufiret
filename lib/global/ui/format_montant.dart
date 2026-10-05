/// Montant en francs CFA au format « 7 000 F » : séparateur de milliers et
/// espace avant l'unité insécables, pour ne jamais couper un prix en deux
/// lignes.
String formatMontant(int montant) {
  final chiffres = montant.abs().toString();
  final tampon = StringBuffer(montant < 0 ? '-' : '');
  for (var i = 0; i < chiffres.length; i++) {
    if (i > 0 && (chiffres.length - i) % 3 == 0) tampon.write(' ');
    tampon.write(chiffres[i]);
  }
  return '$tampon F';
}

/// Surcoût d'une option : « +1 000 F ».
String formatSupplement(int montant) => '+${formatMontant(montant)}';
