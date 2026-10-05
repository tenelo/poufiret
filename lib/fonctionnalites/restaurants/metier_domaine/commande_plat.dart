import 'restaurant_models.dart';

// Règles de prix, de choix et de disponibilité d'un plat. Fonctions pures :
// l'interface les appelle, les tests les vérifient sans widget.

/// Prix de départ d'un plat : celui du menu du jour si le plat en vient,
/// sinon son prix effectif (promotion comprise).
int prixDeBase(Plat plat, {LigneMenu? ligne}) =>
    ligne?.prixEffectif ?? plat.prixEffectif;

/// Prix final d'une variante = prix du plat + supplément (qui peut être
/// négatif : « Demi » = 6 000 − 2 500).
int prixVariante(Plat plat, VariantePlat variante) =>
    prixDeBase(plat) + variante.prixSupplement;

/// Plus petit prix auquel le plat peut être commandé (« à partir de »).
int prixAPartirDe(Plat plat) {
  final variantes = plat.variantesActives;
  if (variantes.isEmpty) return prixDeBase(plat);
  return variantes
      .map((v) => prixVariante(plat, v))
      .reduce((a, b) => a < b ? a : b);
}

/// Vrai si le prix dépend de la variante choisie.
bool aPrixVariable(Plat plat) =>
    plat.variantesActives.map((v) => v.prixSupplement).toSet().length > 1;

/// Variante présélectionnée : celle par défaut, sinon la première.
VariantePlat? varianteParDefaut(Plat plat) {
  final variantes = plat.variantesActives;
  if (variantes.isEmpty) return null;
  return variantes.firstWhere(
    (v) => v.estParDefaut,
    orElse: () => variantes.first,
  );
}

/// Prix d'une unité : base + variante + options choisies.
int prixUnitaire(
  Plat plat, {
  LigneMenu? ligne,
  VariantePlat? variante,
  Set<int> optionIds = const {},
}) {
  var prix = prixDeBase(plat, ligne: ligne);
  // Un plat du menu du jour est vendu à son prix de menu, sans variante.
  if (ligne == null && variante != null) prix += variante.prixSupplement;
  for (final groupe in plat.groupesActifs) {
    for (final option in groupe.options) {
      if (optionIds.contains(option.id)) prix += option.prixSupplement;
    }
  }
  return prix;
}

int prixTotal(
  Plat plat, {
  LigneMenu? ligne,
  VariantePlat? variante,
  Set<int> optionIds = const {},
  int quantite = 1,
}) =>
    prixUnitaire(plat, ligne: ligne, variante: variante, optionIds: optionIds) *
    quantite;

/// Plafond effectif d'un groupe (jamais plus que son nombre d'options).
int maxChoix(GroupeOptions groupe) {
  final max = groupe.maxChoix;
  final nb = groupe.options.length;
  return max == null || max <= 0 || max > nb ? nb : max;
}

/// Un seul choix possible : boutons radio plutôt que cases à cocher.
bool estChoixUnique(GroupeOptions groupe) => maxChoix(groupe) == 1;

/// Consigne affichée sous le titre du groupe.
String libelleContrainte(GroupeOptions groupe) {
  final min = groupe.minChoix;
  final max = maxChoix(groupe);
  if (min <= 0) return max == 1 ? 'Facultatif · 1 au choix' : "Jusqu'à $max";
  if (min >= max) return 'Choisissez $min';
  return 'Choisissez de $min à $max';
}

int _nombreChoisis(GroupeOptions groupe, Set<int> optionIds) =>
    groupe.options.where((o) => optionIds.contains(o.id)).length;

/// null si le groupe respecte ses bornes, sinon ce qu'il manque.
String? erreurGroupe(GroupeOptions groupe, Set<int> optionIds) {
  final nb = _nombreChoisis(groupe, optionIds);
  final max = maxChoix(groupe);
  if (nb < groupe.minChoix) {
    final manque = groupe.minChoix - nb;
    return manque == 1
        ? '${groupe.libelle} : faites encore 1 choix'
        : '${groupe.libelle} : faites encore $manque choix';
  }
  if (nb > max) return '${groupe.libelle} : $max choix au maximum';
  return null;
}

/// Première contrainte de groupe non respectée (null = sélection valide).
String? erreurSelection(Plat plat, Set<int> optionIds) {
  for (final groupe in plat.groupesActifs) {
    final erreur = erreurGroupe(groupe, optionIds);
    if (erreur != null) return erreur;
  }
  return null;
}

/// Coche ou décoche une option en respectant le plafond du groupe : en choix
/// unique la nouvelle remplace l'ancienne ; sinon, le plafond atteint, le
/// choix supplémentaire est ignoré.
Set<int> basculerOption(
  GroupeOptions groupe,
  Set<int> optionIds,
  int optionId,
) {
  final choix = {...optionIds};
  if (choix.contains(optionId)) {
    // Un choix unique obligatoire ne se décoche pas, il se remplace.
    if (!(estChoixUnique(groupe) && groupe.minChoix >= 1)) {
      choix.remove(optionId);
    }
    return choix;
  }
  if (estChoixUnique(groupe)) {
    choix.removeAll(groupe.options.map((o) => o.id));
  } else if (_nombreChoisis(groupe, choix) >= maxChoix(groupe)) {
    return choix;
  }
  return choix..add(optionId);
}

/// Quantité maximale commandable (stock du menu du jour) ; null = libre.
int? quantiteMax(LigneMenu? ligne) => ligne?.stockRestant;

/// « 14:00:00 » → « 14h », « 11:30 » → « 11h30 ».
String formatHeure(String? heure) {
  final morceaux = (heure ?? '').split(':');
  if (morceaux.length < 2) return heure ?? '';
  final h = int.tryParse(morceaux[0]);
  if (h == null) return heure!;
  return morceaux[1] == '00' ? '${h}h' : '${h}h${morceaux[1]}';
}

/// Vrai si l'heure limite de commande du menu est passée à [maintenant].
bool heureLimiteDepassee(MenuDuJour menu, DateTime maintenant) {
  final morceaux = (menu.heureLimiteCommande ?? '').split(':');
  if (morceaux.length < 2) return false;
  final h = int.tryParse(morceaux[0]);
  final m = int.tryParse(morceaux[1]);
  if (h == null || m == null) return false;
  return maintenant.hour * 60 + maintenant.minute > h * 60 + m;
}

/// Pourquoi le plat ne peut pas être ajouté au panier ; null s'il peut
/// l'être. Les plats restent consultables dans tous les cas.
String? motifIndisponible({
  required Restaurant restaurant,
  required Plat plat,
  LigneMenu? ligne,
  MenuDuJour? menu,
  required DateTime maintenant,
}) {
  if (restaurant.estFerme) return restaurant.messageFermeture;
  if (ligne != null) {
    if (ligne.epuisee) return 'Ce plat du menu est épuisé';
    if (menu != null &&
        (!menu.commandable || heureLimiteDepassee(menu, maintenant))) {
      final limite = menu.heureLimiteCommande;
      return limite == null
          ? "Ce menu n'est plus commandable"
          : 'Commandes closes depuis ${formatHeure(limite)}';
    }
  }
  if (plat.estEpuise) return 'Ce plat est épuisé';
  if (!plat.estDisponible) return "Ce plat n'est pas disponible";
  return null;
}
