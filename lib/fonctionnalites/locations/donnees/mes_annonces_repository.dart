import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../global/config/env.dart';
import '../../../global/json/convertisseurs.dart';
import '../../../global/network/providers.dart';
import '../metier_domaine/location_models.dart';
import '../metier_domaine/vente_models.dart';

/// Type d'annonce gérée par un loueur : véhicule ou logement.
enum TypeAnnonce {
  vehicule('vehicules', 'loueur_voiture'),
  logement('logements', 'loueur_maison');

  const TypeAnnonce(this.chemin, this.typePartenaire);

  /// Segment d'URL : `mon-espace/<chemin>/`.
  final String chemin;

  /// Type de partenaire qui gère ce type d'annonce.
  final String typePartenaire;

  /// Type géré par ce type de partenaire, ou null.
  static TypeAnnonce? pour(Object? typePartenaire) {
    for (final t in values) {
      if (t.typePartenaire == typePartenaire) return t;
    }
    return null;
  }
}

/// Une annonce vue par son loueur (`mon-espace/…`) : y compris vendues et
/// indisponibles.
class AnnonceGestion {
  const AnnonceGestion({
    required this.id,
    required this.nom,
    required this.vente,
    this.prix,
    this.estActif = true,
    this.disponibiliteLibelle = '',
    this.brut = const {},
  });

  factory AnnonceGestion.fromJson(Map<String, dynamic> json) => AnnonceGestion(
    id: versInt(json['id']),
    nom: '${json['nom'] ?? ''}',
    prix: versIntNullable(json['prix']),
    estActif: json['est_actif'] != false,
    disponibiliteLibelle: '${json['disponibilite_libelle'] ?? ''}',
    vente: InfosVente.fromJson(json),
    brut: json,
  );

  final int id;
  final String nom;

  /// Prix de location (Article.prix).
  final int? prix;
  final bool estActif;
  final String disponibiliteLibelle;
  final InfosVente vente;

  /// Représentation reçue : valeurs initiales du formulaire.
  final Map<String, dynamic> brut;
}

class MesAnnoncesRepository {
  MesAnnoncesRepository(this._dio);

  final Dio _dio;

  String _url(TypeAnnonce type, [int? id, String suite = '']) =>
      '${Env.apiPrefix}/locations/mon-espace/${type.chemin}/'
      '${id == null ? '' : '$id/'}$suite';

  /// `GET mon-espace/<type>/` — toutes mes annonces, vendues comprises.
  Future<List<AnnonceGestion>> lister(TypeAnnonce type) async {
    final r = await _dio.get(_url(type));
    final data = r.data;
    final liste = data is Map ? data['resultats'] : data;
    return [
      for (final e in (liste as List? ?? const []))
        AnnonceGestion.fromJson(Map<String, dynamic>.from(e as Map)),
    ];
  }

  /// `PATCH mon-espace/<type>/<id>/` — type d'annonce et champs de vente.
  /// Un refus (400 : prix manquant…) remonte en [DioException].
  Future<AnnonceGestion> modifier(
    TypeAnnonce type,
    int id,
    Map<String, Object?> donnees,
  ) async {
    final r = await _dio.patch(_url(type, id), data: donnees);
    return AnnonceGestion.fromJson(Map<String, dynamic>.from(r.data as Map));
  }

  /// `POST mon-espace/<type>/<id>/vendu/` {vendu} — marque vendue ou remet
  /// en vente.
  Future<AnnonceGestion> marquerVendu(
    TypeAnnonce type,
    int id, {
    required bool vendu,
  }) async {
    final r = await _dio.post(_url(type, id, 'vendu/'), data: {'vendu': vendu});
    return AnnonceGestion.fromJson(Map<String, dynamic>.from(r.data as Map));
  }
}

final mesAnnoncesRepositoryProvider = Provider<MesAnnoncesRepository>(
  (ref) => MesAnnoncesRepository(ref.watch(dioProvider)),
);

/// Mes annonces d'un type (jamais en cache : écran de gestion).
final mesAnnoncesProvider = FutureProvider.autoDispose
    .family<List<AnnonceGestion>, TypeAnnonce>(
      (ref, type) => ref.watch(mesAnnoncesRepositoryProvider).lister(type),
    );

/// Valeurs initiales du formulaire de vente, depuis la représentation reçue.
Map<String, Object?> valeursVente(
  AnnonceGestion annonce,
  List<ChampVente> champs,
) => {
  for (final c in champs)
    c.cle: switch (c.cle) {
      'mode' => annonce.vente.mode.valeur,
      'prix' => annonce.prix,
      'prix_vente' => annonce.vente.prixVente,
      _ =>
        annonce.brut[c.cle] ??
            (annonce.brut.containsKey(c.cle) ? null : c.defaut),
    },
};

/// Données envoyées : seulement les champs visibles pour le type d'annonce
/// choisi (les champs masqués ne sont pas effacés côté serveur).
Map<String, Object?> donneesVente(
  Map<String, Object?> valeurs,
  List<ChampVente> champs,
) => {
  for (final c in champs)
    if (c.visible(valeurs)) c.cle: valeurs[c.cle],
};

/// Erreurs locales, identiques au serveur (règle des prix selon le mode).
Map<String, String> erreursFormulaireVente(Map<String, Object?> valeurs) =>
    erreursPrixAnnonce(
      mode: ModeAnnonce.depuis(valeurs['mode']),
      prixLocation: versIntNullable(valeurs['prix']),
      prixVente: versIntNullable(valeurs['prix_vente']),
    );

/// Options d'un champ « choix ». Type d'annonce : Location / Vente /
/// Location et vente.
List<OptionMeta> optionsChamp(ChampVente champ) => champ.cle == 'mode'
    ? [
        for (final m in ModeAnnonce.values)
          OptionMeta(valeur: m.valeur, libelle: m.libelle),
      ]
    : champ.choix;
