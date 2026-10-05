// Mise en forme du JSON des endpoints restaurants avant décodage.
//
// Formats relevés en production le 2026-10-05 :
// - liste   `GET /restaurants/` : `{"resultats": [résumé]}` — statut, délai,
//   services, spécialités et `menu_du_jour` à la racine du résumé ;
// - fiche   `GET /restaurants/<id>/` : statut et coordonnées à la racine,
//   informations pratiques dans `fiche`, `menus_du_jour` rangés par service ;
// - flux    `GET /restaurants/menus-du-jour/` : `{"resultats": [entrée]}`,
//   entrée = `{partenaire_id, nom, ville, menu, est_ouvert, …}`.
// Les trois sont ramenés à la forme des modèles de restaurant_models.dart.

const _servicesMenu = ['midi', 'soir', 'journee'];

Map<String, dynamic> _objet(Object? valeur) =>
    Map<String, dynamic>.from(valeur as Map);

/// Éléments d'une réponse `{"resultats": [...]}`.
List<Map<String, dynamic>> elementsDeListe(Object? json) => [
  for (final e in (json as Map)['resultats'] as List) _objet(e),
];

/// Plats `{nom, prix, image}` d'un menu résumé (liste et flux) ; vide si le
/// restaurant n'a pas de menu du jour.
List<Object?> _platsDuMenu(Object? menu) =>
    menu is Map ? (menu['plats'] as List? ?? const []) : const [];

/// Un résumé de la liste → forme du modèle `Restaurant`.
Map<String, dynamic> normaliserResume(Object? brut) {
  final r = _objet(brut);
  return {
    ...r,
    'fiche': {
      'delai_preparation_min': r['delai_preparation_min'],
      'services': r['services'],
      'specialites': r['specialites'],
    },
    'apercu_plats': _platsDuMenu(r['menu_du_jour']),
  };
}

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
    // Aperçu (cartes de l'accueil) déduit des lignes des menus.
    'apercu_plats': [
      for (final menu in menus)
        for (final ligne in menu['lignes'] as List? ?? const [])
          {
            'nom': (ligne as Map)['plat_nom'],
            'prix': ligne['prix_effectif'],
            'image': ligne['plat_image'],
          },
    ],
  };
}

/// Une entrée du flux « menus du jour » → forme du modèle
/// `MenuDuJourAccueil`.
Map<String, dynamic> normaliserMenuAccueil(Object? brut) {
  final e = _objet(brut);
  final menu = e['menu'] as Map? ?? const {};
  return {
    'restaurant': {
      'id': e['partenaire_id'],
      'nom': e['nom'],
      'ville': e['ville'],
      'est_ouvert': e['est_ouvert'],
      'prochaine_ouverture': e['prochaine_ouverture'],
      'message_statut': e['message_statut'],
    },
    'service': menu['service'],
    'titre': menu['titre'],
    'plats': _platsDuMenu(menu),
  };
}
