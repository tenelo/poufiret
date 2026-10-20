import '../../../global/json/convertisseurs.dart';
import '../../restaurants/metier_domaine/normalisation.dart'
    show normaliserProduit;
import '../../restaurants/metier_domaine/restaurant_models.dart';
import 'fiche_produit.dart';

/// Une page de `GET /restaurants/<id>/produits/`.
class PageProduits {
  const PageProduits({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory PageProduits.fromJson(Map<String, dynamic> json) => PageProduits(
    count: versInt(json['count']),
    next: json['next'] as String?,
    previous: json['previous'] as String?,
    results: [
      for (final p in json['results'] as List? ?? const [])
        Plat.fromJson(normaliserProduit(p)),
    ],
  );

  final int count;
  final String? next;
  final String? previous;
  final List<Plat> results;

  bool get aSuite => next != null && next!.isNotEmpty;
}

/// Fiche d'un produit (`GET /restaurants/produits/<id>/`) et les autres
/// produits du commerce.
class ProduitDetail {
  const ProduitDetail({
    required this.produit,
    this.commerceId,
    this.autres = const [],
  });

  factory ProduitDetail.fromJson(Map<String, dynamic> json) => ProduitDetail(
    produit: Plat.fromJson(normaliserProduit(json)),
    commerceId: versIntNullable(
      json['restaurant'] is Map
          ? (json['restaurant'] as Map)['id']
          : json['restaurant'] ?? json['partenaire'] ?? json['commerce'],
    ),
    autres: [
      for (final p in json['autres_produits'] as List? ?? const [])
        Plat.fromJson(normaliserProduit(p)),
    ],
  );

  final Plat produit;

  /// Commerce du produit, s'il est indiqué.
  final int? commerceId;
  final List<Plat> autres;
}

/// Filtres d'un catalogue : valeurs choisies par champ (genre, niveau,
/// état...) et prix maximum. Envoyés au serveur, et réappliqués sur place
/// au cas où il ignorerait un critère.
class FiltreCatalogue {
  const FiltreCatalogue({this.valeurs = const {}, this.prixMax});

  final Map<String, String> valeurs;
  final int? prixMax;

  int get nombre => valeurs.length + (prixMax == null ? 0 : 1);

  Map<String, dynamic> get parametres => {...valeurs, 'prix_max': ?prixMax};

  /// Le produit passe-t-il les critères ? Un champ absent du produit ne
  /// l'exclut pas (le serveur a pu le filtrer sur une donnée non reçue).
  bool garde(Plat p) {
    if (prixMax != null && prixAPartirDeProduit(p) > prixMax!) return false;
    for (final e in valeurs.entries) {
      final v = p.valeur(e.key);
      if (v.isNotEmpty && v != e.value && p.texte(e.key) != e.value) {
        return false;
      }
    }
    return true;
  }

  String get cle =>
      (parametres.entries.map((e) => '${e.key}=${e.value}').toList()..sort())
          .join('&');

  @override
  bool operator ==(Object other) =>
      other is FiltreCatalogue && other.cle == cle;

  @override
  int get hashCode => cle.hashCode;
}

/// Plus petit prix du produit, variantes en stock comprises.
int prixAPartirDeProduit(Plat p) {
  final variantes = p.variantesActives.where((v) => !v.epuisee).toList();
  if (variantes.isEmpty) return p.prixEffectif;
  return variantes
      .map((v) => p.prixEffectif + v.prixSupplement)
      .reduce((a, b) => a < b ? a : b);
}

/// Ce que l'on demande au serveur : un rayon, une recherche, des filtres.
class RequeteProduits {
  const RequeteProduits({
    required this.commerceId,
    this.sectionId,
    this.recherche = '',
    this.filtre = const FiltreCatalogue(),
  });

  final int commerceId;

  /// null = tout le commerce (recherche globale).
  final int? sectionId;
  final String recherche;
  final FiltreCatalogue filtre;

  static const taillePage = 20;

  Map<String, dynamic> parametres(int page) => {
    'section': ?sectionId,
    if (recherche.trim().isNotEmpty) 'q': recherche.trim(),
    ...filtre.parametres,
    'page': page,
    'page_size': taillePage,
  };

  String get cle =>
      '$commerceId|${sectionId ?? '*'}|${recherche.trim()}|${filtre.cle}';

  @override
  bool operator ==(Object other) =>
      other is RequeteProduits && other.cle == cle;

  @override
  int get hashCode => cle.hashCode;
}

/// Liste paginée en cours de chargement (défilement infini).
class EtatPagination {
  const EtatPagination({
    this.produits = const [],
    this.total,
    this.pagesChargees = 0,
    this.aSuite = true,
    this.chargement = false,
    this.erreur,
  });

  final List<Plat> produits;

  /// Nombre total annoncé par le serveur (null tant qu'inconnu).
  final int? total;
  final int pagesChargees;
  final bool aSuite;
  final bool chargement;
  final Object? erreur;

  /// Rien encore reçu : squelette plein écran.
  bool get initial => pagesChargees == 0 && erreur == null;

  EtatPagination copyWith({
    List<Plat>? produits,
    int? total,
    int? pagesChargees,
    bool? aSuite,
    bool? chargement,
    Object? erreur,
    bool effacerErreur = false,
  }) => EtatPagination(
    produits: produits ?? this.produits,
    total: total ?? this.total,
    pagesChargees: pagesChargees ?? this.pagesChargees,
    aSuite: aSuite ?? this.aSuite,
    chargement: chargement ?? this.chargement,
    erreur: effacerErreur ? null : erreur ?? this.erreur,
  );
}
