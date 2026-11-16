import '../../catalogue/metier_domaine/categorie.dart';
import 'publicite_liste.dart';

/// Élément du carrousel de l'accueil : pub d'un partenaire ou pub Poufiret.
sealed class ElementCarrousel {
  const ElementCarrousel();

  String get id;
  String get titre;
  String? get imageCouverture;

  /// Clé de journalisation : une impression par élément et par écran.
  String get cleSuivi;

  /// Durée d'un passage : fixe, la même pour tous les éléments.
  Duration get dureePassage => const Duration(milliseconds: 3500);

  /// Vrai si l'élément ne doit plus être affiché (diffusion terminée).
  bool diffusionTerminee([DateTime? maintenant]);

  /// Un objet de la clé `elements` du serveur, ou null s'il est inutilisable
  /// (type inconnu, pub Poufiret sans catégorie).
  static ElementCarrousel? depuisJson(Map<String, dynamic> json) =>
      switch (json['type']) {
        'partenaire' => ElementPartenaire(PubliciteListe.fromJson(json)),
        'poufiret' => ElementPoufiret.depuisJson(json),
        _ => null,
      };
}

/// Pub d'un partenaire : comportement historique (fiche de la pub).
class ElementPartenaire extends ElementCarrousel {
  const ElementPartenaire(this.pub);

  final PubliciteListe pub;

  @override
  String get id => pub.id;
  @override
  String get titre => pub.titre;
  @override
  String? get imageCouverture => pub.imageCouverture;
  @override
  String get cleSuivi => pub.id;
  @override
  bool diffusionTerminee([DateTime? maintenant]) =>
      pub.diffusionTerminee(maintenant);
}

/// Pub Poufiret : un appui ouvre sa [categorie], comme la tuile de l'accueil.
class ElementPoufiret extends ElementCarrousel {
  const ElementPoufiret({
    required this.id,
    required this.titre,
    required this.categorie,
    this.texte = '',
    this.imageCouverture,
  });

  @override
  final String id;
  @override
  final String titre;
  final String texte;
  @override
  final String? imageCouverture;

  /// Catégorie ouverte par un appui (même objet qu'une tuile de la grille).
  final Categorie categorie;

  @override
  String get cleSuivi => 'poufiret/$id';

  /// Le serveur n'envoie que des pubs Poufiret en diffusion.
  @override
  bool diffusionTerminee([DateTime? maintenant]) => false;

  /// Null si la catégorie est absente : la pub est alors retirée du
  /// carrousel (sécurité, le serveur ne devrait pas en envoyer).
  static ElementPoufiret? depuisJson(Map<String, dynamic> json) {
    final categorie = json['categorie'];
    if (categorie is! Map) return null;
    return ElementPoufiret(
      id: json['id'].toString(),
      titre: json['titre'] as String? ?? '',
      texte: json['texte'] as String? ?? '',
      imageCouverture: json['image_couverture'] as String?,
      categorie: Categorie.fromJson(Map<String, dynamic>.from(categorie)),
    );
  }
}

/// Éléments du carrousel avec leur origine (même rôle que PubsAffichees).
///
/// [confirmeReseau] : vrai pour une réponse réseau fraîche, faux pour le
/// cache disque. Rien n'est journalisé pour un élément non confirmé.
class ElementsCarrousel {
  const ElementsCarrousel(this.elements, {required this.confirmeReseau});

  static const vide = ElementsCarrousel([], confirmeReseau: false);

  final List<ElementCarrousel> elements;
  final bool confirmeReseau;

  /// Éléments encore diffusables MAINTENANT (jamais une pub terminée, même
  /// lue dans le cache).
  List<ElementCarrousel> affichables([DateTime? maintenant]) => [
    for (final e in elements)
      if (!e.diffusionTerminee(maintenant)) e,
  ];
}
