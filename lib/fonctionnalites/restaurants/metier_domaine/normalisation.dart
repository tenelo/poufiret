// Mise en forme du JSON des endpoints restaurants avant décodage.
//
// Format relevé en production le 2026-10-05, fiche `GET /restaurants/<id>/` :
// statut et coordonnées à la racine, informations pratiques dans `fiche`,
// `menus_du_jour` rangés par service. Il est ramené à la forme des modèles
// de restaurant_models.dart.

const _servicesMenu = ['midi', 'soir', 'journee'];

Map<String, dynamic> _objet(Object? valeur) =>
    Map<String, dynamic>.from(valeur as Map);

/// Produit d'un commerce → forme du modèle `Plat` (nom repris de `titre`
/// ou `libelle` s'il manque).
Map<String, dynamic> normaliserProduit(Object? brut) {
  final p = _objet(brut);
  return {...p, 'nom': p['nom'] ?? p['titre'] ?? p['libelle'] ?? ''};
}

/// Section au format « commerce » (`produits`) → section de carte (`plats`).
Map<String, dynamic> _section(Object? brut) {
  final s = _objet(brut);
  return {
    ...s,
    'plats': [
      for (final p in s['plats'] as List? ?? s['produits'] as List? ?? const [])
        normaliserProduit(p),
    ],
  };
}

/// Une fiche complète → forme du modèle `Restaurant`.
///
/// Depuis les gabarits (2026-10), la fiche porte `sections` (avec
/// `produits`, ou seulement `nb_produits` en pagination publique) ; la garde
/// d'une pharmacie peut arriver à la racine ou dans `fiche`.
Map<String, dynamic> normaliserFiche(Object? brut) {
  final r = _objet(brut);
  final fiche = r['fiche'] is Map ? _objet(r['fiche']) : <String, dynamic>{};
  for (final cle in ['de_garde', 'de_garde_jusqu_au']) {
    if (fiche[cle] == null && r[cle] != null) fiche[cle] = r[cle];
  }
  final ancienne = r['carte'];
  final carte = ancienne is List && ancienne.isNotEmpty
      ? ancienne
      : r['sections'] ?? ancienne;
  final parService = r['menus_du_jour'] as Map? ?? const {};
  final menus = [
    for (final service in _servicesMenu)
      if (parService[service] is Map)
        {'service': service, ..._objet(parService[service])},
  ];
  return {
    ...r,
    'fiche': fiche,
    'carte': [
      for (final section in carte as List? ?? const []) _section(section),
    ],
    'menus': menus,
    'services_en_vigueur': [
      ...(r['menus_en_vigueur_maintenant'] as Map? ?? const {}).keys,
    ],
  };
}
