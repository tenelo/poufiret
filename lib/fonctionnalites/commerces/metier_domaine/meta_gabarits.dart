import 'fiche_produit.dart';
import 'gabarits.dart';

/// Un choix de filtre : valeur envoyée au serveur, libellé affiché.
class ChoixFiltre {
  const ChoixFiltre(this.valeur, this.libelle);

  final String valeur;
  final String libelle;

  @override
  bool operator ==(Object other) =>
      other is ChoixFiltre &&
      other.valeur == valeur &&
      other.libelle == libelle;

  @override
  int get hashCode => Object.hash(valeur, libelle);
}

/// Un critère de la feuille « Filtrer ».
class ChampFiltre {
  const ChampFiltre(this.cle, this.libelle, this.choix);

  /// Paramètre de requête et champ de la fiche spécifique (« genre »).
  final String cle;
  final String libelle;
  final List<ChoixFiltre> choix;
}

/// `GET /restaurants/meta/gabarits/`, lu sans présumer de sa forme : on y
/// cherche, sous le gabarit si on le trouve, la liste de choix d'un champ.
/// À défaut, les listes par défaut ci-dessous s'appliquent.
class MetaGabarits {
  const MetaGabarits(this.brut);

  final Object? brut;

  static const vide = MetaGabarits(null);

  /// Choix proposés pour [champ] du [gabarit].
  List<ChoixFiltre> choix(Gabarit gabarit, String champ) {
    final zone = _trouverGabarit(brut, gabarit.name) ?? brut;
    final trouves = _chercher(zone, champ);
    return trouves.isNotEmpty ? trouves : choixParDefaut[champ] ?? const [];
  }

  /// Critères de filtre d'un gabarit (vide : pas de bouton « Filtrer »).
  List<ChampFiltre> champsFiltre(Gabarit gabarit) => [
    for (final (cle, libelle)
        in criteresParGabarit[gabarit] ?? const <(String, String)>[])
      ChampFiltre(cle, libelle, choix(gabarit, cle)),
  ];

  static Object? _trouverGabarit(Object? noeud, String nom) {
    if (noeud is Map) {
      for (final cle in ['valeur', 'code', 'gabarit', 'cle', 'nom']) {
        if (noeud[cle] == nom) return noeud;
      }
      if (noeud[nom] is Map || noeud[nom] is List) return noeud[nom];
      for (final v in noeud.values) {
        final r = _trouverGabarit(v, nom);
        if (r != null) return r;
      }
    } else if (noeud is List) {
      for (final v in noeud) {
        final r = _trouverGabarit(v, nom);
        if (r != null) return r;
      }
    }
    return null;
  }

  static List<ChoixFiltre> _chercher(Object? noeud, String champ) {
    if (noeud is Map) {
      // { "genre": [..] } ou { "genres": [..] }
      for (final cle in [champ, '${champ}s', 'choix_$champ']) {
        final liste = _options(noeud[cle]);
        if (liste.isNotEmpty) return liste;
      }
      // { "nom": "genre", "choix": [..] }
      if ([
        noeud['nom'],
        noeud['cle'],
        noeud['champ'],
        noeud['code'],
      ].contains(champ)) {
        for (final cle in ['choix', 'options', 'valeurs']) {
          final liste = _options(noeud[cle]);
          if (liste.isNotEmpty) return liste;
        }
      }
      for (final v in noeud.values) {
        final r = _chercher(v, champ);
        if (r.isNotEmpty) return r;
      }
    } else if (noeud is List) {
      for (final v in noeud) {
        final r = _chercher(v, champ);
        if (r.isNotEmpty) return r;
      }
    }
    return const [];
  }

  /// Liste de choix : `[{valeur, libelle}]`, `[[valeur, libelle]]` ou
  /// `["valeur"]`.
  static List<ChoixFiltre> _options(Object? liste) {
    if (liste is! List || liste.isEmpty) return const [];
    final choix = <ChoixFiltre>[];
    for (final e in liste) {
      if (e is Map && (e['valeur'] ?? e['code'] ?? e['value']) != null) {
        final v = '${e['valeur'] ?? e['code'] ?? e['value']}';
        choix.add(
          ChoixFiltre(v, '${e['libelle'] ?? e['label'] ?? lisible(v)}'),
        );
      } else if (e is List && e.length >= 2) {
        choix.add(ChoixFiltre('${e[0]}', '${e[1]}'));
      } else if (e is String) {
        choix.add(ChoixFiltre(e, lisible(e)));
      } else {
        return const [];
      }
    }
    return choix;
  }
}

/// Critères de « Filtrer » par gabarit (le prix max s'y ajoute pour la mode).
const criteresParGabarit = {
  Gabarit.mode: [('genre', 'Genre')],
  Gabarit.librairie: [
    ('niveau', 'Niveau'),
    ('genre_livre', 'Genre'),
    ('etat', 'État'),
  ],
};

/// Choix utilisés tant que la meta n'en fournit pas.
const choixParDefaut = {
  'genre': [
    ChoixFiltre('homme', 'Homme'),
    ChoixFiltre('femme', 'Femme'),
    ChoixFiltre('enfant', 'Enfant'),
    ChoixFiltre('mixte', 'Mixte'),
  ],
  'niveau': [
    ChoixFiltre('maternelle', 'Maternelle'),
    ChoixFiltre('primaire', 'Primaire'),
    ChoixFiltre('college', 'Collège'),
    ChoixFiltre('lycee', 'Lycée'),
    ChoixFiltre('superieur', 'Supérieur'),
  ],
  'genre_livre': [
    ChoixFiltre('scolaire', 'Scolaire'),
    ChoixFiltre('roman', 'Roman'),
    ChoixFiltre('jeunesse', 'Jeunesse'),
    ChoixFiltre('religion', 'Religion'),
    ChoixFiltre('dictionnaire', 'Dictionnaire'),
    ChoixFiltre('autre', 'Autre'),
  ],
  'etat': [ChoixFiltre('neuf', 'Neuf'), ChoixFiltre('occasion', 'Occasion')],
};
