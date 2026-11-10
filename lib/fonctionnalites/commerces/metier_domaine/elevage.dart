import '../../../global/ui/format_montant.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import 'fiche_produit.dart';

// Produits d'éleveur (porc, poulet, œufs...) : vendus à la pièce, au kilo,
// par tête ou par plaquette ; vifs, abattus entiers, découpés ou produits.
// Fonctions pures, vérifiées par les tests.

/// Unité de prix d'un produit d'élevage. Seul le kilo se commande en
/// quantité décimale.
enum UnitePrix {
  piece('piece', 'pièce'),
  kg('kg', 'kg'),
  tete('tete', 'tête'),
  plaquette('plaquette', 'plaquette');

  const UnitePrix(this.code, this.libelle);

  /// Valeur du serveur (`unite_prix`).
  final String code;

  /// « pièce », « kg », « tête », « plaquette ».
  final String libelle;

  /// Unité d'un code serveur ; pièce si inconnu.
  static UnitePrix depuis(String? code) =>
      values.firstWhere((u) => u.code == code, orElse: () => piece);

  /// Pas du sélecteur : 0,5 kg, sinon 1 (pièce, tête, plaquette).
  num get pas => this == kg ? 0.5 : 1;

  /// « f/kg », « f/tête »… (affichage par défaut, en minuscules).
  String get suffixe => 'f/$libelle';
}

/// Libellés des états de vente.
const libellesEtatVente = {
  'vivant': 'Vivant',
  'abattu_entier': 'Abattu entier',
  'decoupe': 'Découpé',
  'produit': 'Produit',
};

/// « 2 500 f/kg », « 5 000 f/tête », « 3 500 f/pièce » : [suffixe] du
/// serveur s'il est fourni, sinon celui de l'unité.
String formatPrixUnite(int prix, UnitePrix unite, {String? suffixe}) {
  final chiffres = formatMontant(prix).replaceFirst(RegExp(r'\s?F$'), '');
  final s = suffixe == null || suffixe.trim().isEmpty
      ? unite.suffixe
      : suffixe.trim();
  return '$chiffres\u00a0$s';
}

/// « 1 pièce », « 3 pièces », « 2,5 kg », « 2 têtes », « 1 plaquette ».
String formatQuantiteUnite(num quantite, UnitePrix unite) =>
    unite == UnitePrix.kg
    ? formatQuantite(quantite, unite: 'kg')
    : '${formatQuantite(quantite)} ${unite.libelle}${quantite > 1 ? 's' : ''}';

/// Ramène [quantite] sur la grille de l'unité (entier, ou multiple de 0,5),
/// entre un pas et [max] (stock connu ; null = libre).
num ajusterQuantite(num quantite, UnitePrix unite, {num? max}) {
  final pas = unite.pas;
  var q = (quantite / pas).floor() * pas;
  if (max != null) {
    final plafond = (max / pas).floor() * pas;
    if (q > plafond) q = plafond;
  }
  if (q < pas) q = pas;
  // 2.0 → 2 : une quantité entière part au serveur en entier.
  return q == q.roundToDouble() ? q.round() : q.toDouble();
}

/// Total d'une ligne : prix unitaire (pièce ou kg) × quantité, arrondi au
/// franc.
int totalElevage(int prixUnitaire, num quantite) =>
    (prixUnitaire * quantite).round();

/// « 2,5 kg × 2 500 F = 6 250 F », « 3 pièces × 3 500 F = 10 500 F ».
String libelleTotalElevage(int prixUnitaire, num quantite, UnitePrix unite) =>
    '${formatQuantiteUnite(quantite, unite)} × ${formatMontant(prixUnitaire)}'
    ' = ${formatMontant(totalElevage(prixUnitaire, quantite))}';

extension ProduitElevage on Plat {
  /// Unité envoyée par le serveur, sinon celle de la fiche.
  UnitePrix get unitePrix =>
      UnitePrix.depuis(unitePrixCode ?? valeur('unite_prix'));

  String get espece => texte('espece');

  /// « Vivant », « Abattu entier », « Découpé » (vide si inconnu).
  String get etatVente {
    final code = valeur('etat_vente');
    final libelle = texte('etat_vente');
    if (libelle.isNotEmpty && libelle != code) return libelle;
    return libellesEtatVente[code] ?? lisible(code);
  }

  /// Poids moyen en kg (null si inconnu).
  double? get poidsMoyenKg {
    final v = ficheSpecifique['poids_moyen_kg'];
    final kg = v is num ? v.toDouble() : double.tryParse('${v ?? ''}');
    return kg == null || kg <= 0 ? null : kg;
  }

  /// « Poids moyen : 2,5 kg » (vide si inconnu).
  String get poidsMoyenLisible => poidsMoyenKg == null
      ? ''
      : 'Poids moyen : ${formatQuantite(poidsMoyenKg!, unite: 'kg')}';

  /// Âge tel que saisi (« 6 mois »), ou un nombre de mois.
  String get age {
    final brut = texte('age');
    return int.tryParse(brut) != null ? '$brut mois' : brut;
  }

  /// Quantité disponible (pièces ou kg) ; null = stock non suivi.
  num? get quantiteDisponible {
    final v = ficheSpecifique['quantite_disponible'];
    if (v == null || v == '') return null;
    return v is num ? v : num.tryParse('$v');
  }

  int? get commandeAvanceJours {
    final j = entier('commande_avance_jours');
    return j == null || j <= 0 ? null : j;
  }

  bool get livraisonPossible => drapeau('livraison_possible');

  /// Stock déclaré à zéro : rien à ajouter au panier.
  bool get stockAZero => quantiteDisponible != null && quantiteDisponible! <= 0;

  /// « En stock : 12 », « En stock : 40 kg », « Sur commande · 3 jours à
  /// l'avance » ; vide si ni stock ni délai.
  String get disponibiliteElevage {
    final q = quantiteDisponible;
    if (q != null && q > 0) {
      return 'En stock : ${unitePrix == UnitePrix.kg ? formatQuantite(q, unite: 'kg') : formatQuantite(q)}';
    }
    final j = commandeAvanceJours;
    if (j != null) {
      return "Sur commande · $j ${j > 1 ? 'jours' : 'jour'} à l'avance";
    }
    return '';
  }

  /// Plafond du sélecteur : le stock s'il est suivi.
  num? get quantiteMax => quantiteDisponible;
}
