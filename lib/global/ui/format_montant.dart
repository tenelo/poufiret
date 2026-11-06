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

/// Quantité au format français : « 3 », « 2,5 », « 2,5 kg ».
String formatQuantite(num quantite, {String unite = ''}) {
  final texte = quantite == quantite.roundToDouble()
      ? quantite.round().toString()
      : quantite
            .toStringAsFixed(2)
            .replaceFirst(RegExp(r'0+$'), '')
            .replaceAll('.', ',');
  return unite.isEmpty ? texte : '$texte\u00a0$unite';
}
