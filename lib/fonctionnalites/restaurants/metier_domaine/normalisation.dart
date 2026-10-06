// Mise en forme du JSON des endpoints restaurants avant décodage.
//
// Format relevé en production le 2026-10-05, fiche `GET /restaurants/<id>/` :
// statut et coordonnées à la racine, informations pratiques dans `fiche`,
// `menus_du_jour` rangés par service. Il est ramené à la forme des modèles
// de restaurant_models.dart.

const _servicesMenu = ['midi', 'soir', 'journee'];

Map<String, dynamic> _objet(Object? valeur) =>
    Map<String, dynamic>.from(valeur as Map);

/// Une fiche complète → forme du modèle `Restaurant`.
Map<String, dynamic> normaliserFiche(Object? brut) {
  final r = _objet(brut);
  final parService = r['menus_du_jour'] as Map? ?? const {};
  final menus = [
    for (final service in _servicesMenu)
      if (parService[service] is Map)
        {'service': service, ..._objet(parService[service])},
  ];
  return {
    ...r,
    'menus': menus,
    'services_en_vigueur': [
      ...(r['menus_en_vigueur_maintenant'] as Map? ?? const {}).keys,
    ],
  };
}
