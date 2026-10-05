import '../../../global/errors/api_exception.dart';

/// Choix Département → Localité → Quartier. Changer un niveau vide les
/// niveaux suivants : un quartier n'a de sens que dans sa localité.
class SelectionLocalisation {
  const SelectionLocalisation({this.departement, this.localite, this.quartier});

  final int? departement;
  final int? localite;
  final int? quartier;

  SelectionLocalisation avecDepartement(int? id) =>
      id == departement ? this : SelectionLocalisation(departement: id);

  SelectionLocalisation avecLocalite(int? id) => id == localite
      ? this
      : SelectionLocalisation(departement: departement, localite: id);

  SelectionLocalisation avecQuartier(int? id) => SelectionLocalisation(
    departement: departement,
    localite: localite,
    quartier: id,
  );

  /// Champs d'écriture du backend. Le département n'est envoyé que là où le
  /// partenaire peut le choisir (inscription).
  Map<String, dynamic> versJson({bool avecDepartement = false}) => {
    if (avecDepartement && departement != null) 'departement': departement,
    'localite_id': localite,
    'quartier_id': quartier,
  };

  @override
  bool operator ==(Object other) =>
      other is SelectionLocalisation &&
      other.departement == departement &&
      other.localite == localite &&
      other.quartier == quartier;

  @override
  int get hashCode => Object.hash(departement, localite, quartier);
}

/// Niveaux de la cascade, clés des erreurs affichées sous les champs.
enum NiveauLocalisation { departement, localite, quartier }

const _champsBackend = {
  NiveauLocalisation.departement: ['departement', 'departement_id'],
  NiveauLocalisation.localite: ['localite_id', 'localite'],
  NiveauLocalisation.quartier: ['quartier_id', 'quartier'],
};

/// Erreurs 400 du backend portant sur la localisation (localité hors du
/// département, quartier hors de la localité…), rangées par niveau pour
/// s'afficher sous le champ concerné. Vide si l'erreur porte sur autre chose.
Map<NiveauLocalisation, String> erreursLocalisation(Object erreur) {
  final details = exceptionApi(erreur)?.details ?? const {};
  final erreurs = <NiveauLocalisation, String>{};
  for (final MapEntry(key: niveau, value: champs) in _champsBackend.entries) {
    for (final champ in champs) {
      final valeur = details[champ];
      final message = valeur is List && valeur.isNotEmpty
          ? '${valeur.first}'
          : valeur is String
          ? valeur
          : '';
      if (message.isNotEmpty) erreurs.putIfAbsent(niveau, () => message);
    }
  }
  return erreurs;
}

/// « Quartier, Localité (Département) » à partir des noms rattachés ; à
/// défaut, repli sur les anciens textes libres [ancienQuartier] et
/// [ancienneVille]. Le département n'est pas répété quand la localité porte
/// le même nom (« Ferké (Ferké) »).
String formatLocalisation({
  String? quartierNom,
  String? localiteNom,
  String departement = '',
  String ancienQuartier = '',
  String ancienneVille = '',
}) {
  String retenir(String? rattache, String ancien) =>
      (rattache ?? '').trim().isNotEmpty ? rattache!.trim() : ancien.trim();
  final quartier = retenir(quartierNom, ancienQuartier);
  final localite = retenir(localiteNom, ancienneVille);
  final dep = departement.trim();
  final lieu = [quartier, localite].where((e) => e.isNotEmpty).join(', ');
  if (dep.isEmpty || dep.toLowerCase() == localite.toLowerCase()) {
    return lieu.isEmpty ? dep : lieu;
  }
  return lieu.isEmpty ? dep : '$lieu ($dep)';
}
