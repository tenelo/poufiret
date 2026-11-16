import '../../catalogue/metier_domaine/categorie.dart';

/// Parcours « Découvrir Poufiret » (GET /publicites/decouvrir/).
class ParcoursDecouverte {
  const ParcoursDecouverte({
    required this.actif,
    required this.version,
    required this.ecrans,
  });

  static const inactif = ParcoursDecouverte(
    actif: false,
    version: 0,
    ecrans: [],
  );

  /// Faux : parcours masqué (ni affichage automatique, ni entrée du menu).
  final bool actif;

  /// Change quand l'admin republie le parcours : il est alors reproposé.
  final int version;

  /// Écrans triés par ordre.
  final List<EcranDecouverte> ecrans;

  /// Vrai si le parcours peut être montré.
  bool get affichable => actif && ecrans.isNotEmpty;

  factory ParcoursDecouverte.fromJson(Map<String, dynamic> json) {
    final brut = json['ecrans'];
    final ecrans = [
      if (brut is List)
        for (final e in brut.whereType<Map>())
          EcranDecouverte.fromJson(Map<String, dynamic>.from(e)),
    ]..sort((a, b) => a.ordre.compareTo(b.ordre));
    return ParcoursDecouverte(
      actif: json['actif'] == true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      ecrans: ecrans,
    );
  }
}

/// Un écran du parcours : image, titre, texte, bouton facultatif.
class EcranDecouverte {
  const EcranDecouverte({
    required this.id,
    required this.ordre,
    required this.titre,
    required this.texte,
    this.image,
    this.bouton,
  });

  final String id;
  final int ordre;
  final String titre;
  final String texte;
  final String? image;

  /// Null : écran sans bouton.
  final BoutonDecouverte? bouton;

  factory EcranDecouverte.fromJson(Map<String, dynamic> json) =>
      EcranDecouverte(
        id: json['id'].toString(),
        ordre: (json['ordre'] as num?)?.toInt() ?? 0,
        titre: json['titre'] as String? ?? '',
        texte: json['texte'] as String? ?? '',
        image: json['image'] as String?,
        bouton: BoutonDecouverte.depuisJson(json['bouton']),
      );
}

/// Bouton d'un écran : ouvre [categorie] comme la tuile de l'accueil.
class BoutonDecouverte {
  const BoutonDecouverte({required this.libelle, required this.categorie});

  final String libelle;
  final Categorie categorie;

  /// Null si absent, sans libellé ou sans catégorie.
  static BoutonDecouverte? depuisJson(Object? json) {
    if (json is! Map) return null;
    final libelle = json['libelle'];
    final categorie = json['categorie'];
    if (libelle is! String || libelle.isEmpty || categorie is! Map) {
      return null;
    }
    return BoutonDecouverte(
      libelle: libelle,
      categorie: Categorie.fromJson(Map<String, dynamic>.from(categorie)),
    );
  }
}
