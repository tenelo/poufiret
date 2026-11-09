import '../../../global/json/convertisseurs.dart';

/// Objet notable par le client.
enum ObjetAvis {
  commande('commande'),
  course('course'),
  intervention('intervention'),
  reservation('reservation');

  const ObjetAvis(this.code);
  final String code;
}

/// Avis d'un client (liste publique d'un partenaire, ses propres avis,
/// avis reçus par le partenaire).
class Avis {
  const Avis({
    required this.id,
    required this.note,
    this.objetType = '',
    this.objetId = '',
    this.partenaireNom = '',
    this.auteurNom = '',
    this.commentaire = '',
    this.reponsePartenaire,
    this.creeLe,
    this.modifiableJusquAu,
  });

  factory Avis.fromJson(Map<String, dynamic> json) => Avis(
    id: versInt(json['id']),
    note: versInt(json['note']).clamp(1, 5),
    objetType: json['objet_type'] as String? ?? '',
    objetId: '${json['objet_id'] ?? ''}',
    partenaireNom: json['partenaire_nom'] as String? ?? '',
    auteurNom: json['auteur_nom'] as String? ?? '',
    commentaire: json['commentaire'] as String? ?? '',
    reponsePartenaire: _texte(json['reponse_partenaire']),
    creeLe: _date(json['cree_le']),
    modifiableJusquAu: _date(json['modifiable_jusqu_au']),
  );

  final int id;
  final int note;
  final String objetType;
  final String objetId;
  final String partenaireNom;
  final String auteurNom;
  final String commentaire;

  /// Réponse du partenaire noté (null tant qu'il n'a pas répondu).
  final String? reponsePartenaire;
  final DateTime? creeLe;

  /// Fin du délai de modification par son auteur (7 jours).
  final DateTime? modifiableJusquAu;

  /// Son auteur peut encore le modifier.
  bool modifiable(DateTime maintenant) =>
      modifiableJusquAu != null && maintenant.isBefore(modifiableJusquAu!);
}

/// Une page d'avis d'un partenaire, avec son résumé.
class PageAvis {
  const PageAvis({
    this.avis = const [],
    this.suivante,
    this.noteMoyenne,
    this.nbAvis = 0,
  });

  factory PageAvis.fromJson(Object? json) {
    final data = json is Map ? Map<String, dynamic>.from(json) : const {};
    final liste = json is List ? json : data['results'] as List? ?? const [];
    return PageAvis(
      avis: [
        for (final a in liste)
          if (a is Map) Avis.fromJson(Map<String, dynamic>.from(a)),
      ],
      suivante: data['next'] as String?,
      noteMoyenne: lireNoteMoyenne(data['note_moyenne']),
      nbAvis: versInt(data['nb_avis']),
    );
  }

  final List<Avis> avis;
  final String? suivante;
  final double? noteMoyenne;
  final int nbAvis;

  bool get aSuite => suivante != null && suivante!.isNotEmpty;
}

/// Note moyenne reçue en nombre ou en texte (« 4.50 ») ; null sans avis.
double? lireNoteMoyenne(Object? valeur) => switch (valeur) {
  num n => n.toDouble(),
  String s => double.tryParse(s),
  _ => null,
};

/// « 4,5 » : une décimale, virgule française.
String formatNote(double note) => note.toStringAsFixed(1).replaceAll('.', ',');

/// État de notation d'un objet, exposé par son détail client.
class EtatNotation {
  const EtatNotation({this.peutNoter = false, this.monAvis});

  factory EtatNotation.fromJson(Map<String, dynamic> json) => EtatNotation(
    peutNoter: json['peut_noter'] == true,
    monAvis: versIntNullable(json['mon_avis']),
  );

  final bool peutNoter;

  /// Id de l'avis déjà donné, ou null.
  final int? monAvis;

  /// Bouton « Noter » visible.
  bool get proposerNote => peutNoter && monAvis == null;
}

String? _texte(Object? v) => v is String && v.trim().isNotEmpty ? v : null;

DateTime? _date(Object? v) =>
    v is String ? DateTime.tryParse(v)?.toLocal() : null;
