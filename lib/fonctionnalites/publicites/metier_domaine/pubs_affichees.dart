import 'publicite_liste.dart';

/// Publicites a afficher, avec leur origine.
///
/// [confirmeReseau] est vrai quand la liste vient d'une reponse reseau
/// fraiche du serveur, faux quand elle vient du cache disque. Les impressions
/// ne sont envoyees que pour une pub confirmee : une pub arretee entre-temps
/// par l'admin ne doit pas etre comptee.
class PubsAffichees {
  const PubsAffichees(this.pubs, {required this.confirmeReseau});

  static const vide = PubsAffichees([], confirmeReseau: false);

  final List<PubliciteListe> pubs;
  final bool confirmeReseau;

  /// Pubs encore diffusables MAINTENANT : jamais une pub dont fin_diffusion
  /// est depassee, meme si elle est dans le cache ou en memoire depuis un moment.
  List<PubliciteListe> affichables([DateTime? maintenant]) => [
    for (final p in pubs)
      if (!p.diffusionTerminee(maintenant)) p,
  ];
}
