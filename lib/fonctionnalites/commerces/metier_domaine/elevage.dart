import '../../../global/ui/format_montant.dart';
import '../../restaurants/metier_domaine/restaurant_models.dart';
import 'fiche_produit.dart';

// Produits d'éleveur (porc, poulet...) : vendus à la pièce ou au kilo, vifs,
// abattus entiers ou découpés. Fonctions pures, vérifiées par les tests.

/// Unité de vente d'un produit d'élevage.
enum UnitePrix {
  piece,
  kg;

  /// Pas du sélecteur : 1 pièce, ou 0,5 kg.
  num get pas => this == kg ? 0.5 : 1;

  /// « / pièce », « / kg ».
  String get suffixe => this == kg ? 'kg' : 'pièce';
}

/// Libellés des états de vente.
const libellesEtatVente = {
  'vivant': 'Vivant',
  'abattu_entier': 'Abattu entier',
  'decoupe': 'Découpé',
};

/// « 3 500 F / pièce », « 2 500 F / kg ».
String formatPrixUnite(int prix, UnitePrix unite) =>
    '${formatMontant(prix)} / ${unite.suffixe}';

/// « 1 pièce », « 3 pièces », « 2,5 kg ».
String formatQuantiteUnite(num quantite, UnitePrix unite) =>
    unite == UnitePrix.kg
    ? formatQuantite(quantite, unite: 'kg')
    : '${formatQuantite(quantite)} ${quantite > 1 ? 'pièces' : 'pièce'}';

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
  UnitePrix get unitePrix =>
      valeur('unite_prix') == 'kg' ? UnitePrix.kg : UnitePrix.piece;

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
