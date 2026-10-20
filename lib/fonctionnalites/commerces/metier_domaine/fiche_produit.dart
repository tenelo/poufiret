import '../../restaurants/metier_domaine/restaurant_models.dart';

// Lecture des champs propres au gabarit d'un produit (`fiche_specifique`).
// Le serveur peut envoyer une valeur brute, un objet {valeur, libelle} ou un
// libellé à côté (`genre_libelle`) ; la fiche spécifique prime, la racine du
// produit sert de repli.

/// « homme » → « Homme », « sur_commande » → « Sur commande ».
String lisible(String valeur) {
  final texte = valeur.replaceAll('_', ' ').trim();
  if (texte.isEmpty) return texte;
  return texte[0].toUpperCase() + texte.substring(1);
}

extension FicheProduit on Plat {
  Object? _brut(String cle) => ficheSpecifique[cle];

  /// Valeur brute d'un champ (code), en texte ; vide s'il manque.
  String valeur(String cle) {
    final v = _brut(cle);
    if (v is Map) return (v['valeur'] ?? v['code'] ?? '').toString();
    return v == null ? '' : v.toString().trim();
  }

  /// Libellé d'un champ : `<cle>_libelle`, sinon le libellé de l'objet,
  /// sinon la valeur telle quelle.
  String texte(String cle) {
    final libelle = ficheSpecifique['${cle}_libelle'];
    if (libelle is String && libelle.trim().isNotEmpty) return libelle.trim();
    final v = _brut(cle);
    if (v is Map) return (v['libelle'] ?? v['valeur'] ?? '').toString();
    return v == null ? '' : v.toString().trim();
  }

  bool drapeau(String cle) {
    final v = _brut(cle);
    return v == true || v == 1 || v == 'true' || v == '1';
  }

  int? entier(String cle) {
    final v = _brut(cle);
    if (v is num) return v.round();
    return double.tryParse('${v ?? ''}')?.round();
  }

  // ── Pharmacie ──
  bool get surOrdonnance => drapeau('sur_ordonnance');

  /// « Comprimé · 500 mg ».
  String get formeDosage =>
      [texte('forme'), texte('dosage')].where((t) => t.isNotEmpty).join(' · ');
  String get laboratoire => texte('laboratoire');

  // ── Mode ──
  String get marque => texte('marque');
  String get couleur => texte('couleur');
  String get matiere => texte('matiere');
  String get genre => texte('genre');

  // ── Librairie ──
  String get auteur => texte('auteur');
  String get editeur => texte('editeur');
  String get annee => texte('annee');
  String get isbn => texte('isbn');
  String get langue => texte('langue');

  /// « Primaire · CM2 ».
  String get niveauClasse =>
      [texte('niveau'), texte('classe')].where((t) => t.isNotEmpty).join(' · ');

  /// « Neuf », « Occasion » (vide si inconnu).
  String get etatLivre {
    final libelle = texte('etat');
    return libelle == valeur('etat') ? lisible(libelle) : libelle;
  }

  // ── Boulangerie ──
  bool get surCommande => drapeau('sur_commande');
  int? get delaiHeures => entier('delai_heures');

  /// « Sur commande · 24 h à l'avance » (vide si vendu en rayon).
  String get mentionSurCommande {
    if (!surCommande) return '';
    final delai = delaiHeures;
    return delai == null || delai <= 0
        ? 'Sur commande'
        : "Sur commande · $delai h à l'avance";
  }

  /// Plus aucune variante en stock (toutes les pointures épuisées).
  bool get toutEpuise =>
      indisponible ||
      (variantesActives.isNotEmpty && variantesActives.every((v) => v.epuisee));
}
