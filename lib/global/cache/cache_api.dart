import 'dart:async';

import 'cache_disque.dart';

/// Politique de fraîcheur d'une donnée.
///
/// - [frais]   : jusqu'à cet âge, la valeur en cache suffit, aucun appel réseau.
/// - [perime]  : au-delà de [frais] et jusqu'à cet âge, la valeur en cache est
///               encore AFFICHABLE (le temps du réseau) mais revalidée.
///               Au-delà, elle est ignorée : on attend le réseau.
class PolitiqueCache {
  const PolitiqueCache({required this.frais, required this.perime});

  final Duration frais;
  final Duration perime;

  static const categories = PolitiqueCache(
    frais: Duration(minutes: 10),
    perime: Duration(days: 7),
  );
  static const departements = PolitiqueCache(
    frais: Duration(days: 7),
    perime: Duration(days: 30),
  );
  static const formulesPub = PolitiqueCache(
    frais: Duration(hours: 1),
    perime: Duration(hours: 24),
  );
  static const partenaires = PolitiqueCache(
    frais: Duration(minutes: 5),
    perime: Duration(hours: 24),
  );
  static const vitrine = PolitiqueCache(
    frais: Duration(minutes: 5),
    perime: Duration(hours: 24),
  );
  static const articles = PolitiqueCache(
    frais: Duration(minutes: 3),
    perime: Duration(hours: 24),
  );
  static const articleDetail = PolitiqueCache(
    frais: Duration(minutes: 2),
    perime: Duration(hours: 24),
  );

  /// Conversations : toujours affichées depuis le cache, rafraîchies à
  /// chaque ouverture (le temps réel reste sur WebSocket).
  static const conversations = PolitiqueCache(
    frais: Duration.zero,
    perime: Duration(days: 7),
  );

  /// Publicités : 5 min de « frais » (durée de vie mémoire du provider),
  /// 1 h maximum d'affichage depuis le cache.
  static const publicites = PolitiqueCache(
    frais: Duration(minutes: 5),
    perime: Duration(hours: 1),
  );
}

/// Contexte qui isole les entrées : à qui appartiennent les données et pour
/// quelle portée géographique (les listes dépendent du département).
class ContexteCache {
  const ContexteCache({required this.portee, this.departement = 0});

  /// Visiteur non connecté.
  static const anonyme = ContexteCache(portee: 'anon');

  /// Portée (dossier disque) : `u<id>` ou `anon`.
  final String portee;

  /// Département de l'utilisateur (0 = inconnu / visiteur).
  final int departement;

  factory ContexteCache.utilisateur(int id, int? departement) =>
      ContexteCache(portee: 'u$id', departement: departement ?? 0);

  /// Portée d'un utilisateur donné (pour la purge).
  static String porteeUtilisateur(int id) => 'u$id';

  String cleComplete(String cle) => 'd$departement|$cle';

  @override
  bool operator ==(Object other) =>
      other is ContexteCache &&
      other.portee == portee &&
      other.departement == departement;

  @override
  int get hashCode => Object.hash(portee, departement);
}

/// Valeur émise par [CacheApi.fluxSource].
class Source<T> {
  const Source(this.valeur, {required this.depuisReseau});

  final T valeur;

  /// Vrai si la valeur vient d'une réponse réseau (donc confirmée par le
  /// serveur) ; faux si elle vient du disque.
  final bool depuisReseau;
}

/// Lecture « stale-while-revalidate » adossée à un [CacheDisque].
///
/// 1. Émet tout de suite la valeur en cache si elle existe et n'est pas trop
///    périmée.
/// 2. Si elle n'est plus fraîche (ou si un rechargement est demandé), lance le
///    réseau et émet la valeur fraîche.
/// 3. Une erreur réseau pendant la revalidation N'EST PAS émise quand une
///    valeur a déjà été affichée : la donnée à l'écran n'est jamais remplacée
///    par une erreur.
class CacheApi {
  CacheApi(this._disque, {DateTime Function()? horloge})
    : _horloge = horloge ?? DateTime.now;

  final CacheDisque _disque;
  final DateTime Function() _horloge;

  /// Clés déjà chargées dans ce processus. Une clé revue = un rechargement
  /// explicite (ref.invalidate : pull-to-refresh, après écriture, réessayer)
  /// ou une expiration mémoire : dans les deux cas on va au réseau.
  final Set<String> _dejaCharges = {};

  /// Préfixes de clés déclarés périmés par une écriture (ajout, modification,
  /// suppression) : toute entrée écrite AVANT ce moment doit être revalidée
  /// par le réseau, même si elle est encore « fraîche ».
  final Map<String, DateTime> _perimesDepuis = {};

  /// Nombre de lectures en cours (cache + réseau) : sert au pull-to-refresh.
  int _enCours = 0;

  /// Moment de la dernière purge de chaque portée : une réponse réseau qui
  /// arrive APRÈS une déconnexion, pour une lecture commencée AVANT, ne doit
  /// pas ré-écrire des données de l'ancien utilisateur sur le disque.
  final Map<String, DateTime> _purgesA = {};

  /// À appeler après une écriture : les entrées dont la clé (sans le
  /// contexte) commence par [prefixe] seront revalidées au prochain accès.
  void perimer(String prefixe) => _perimesDepuis[prefixe] = _horloge();

  bool _perimee(String cle, DateTime ecritLe) => _perimesDepuis.entries.any(
    (e) => cle.startsWith(e.key) && ecritLe.isBefore(e.value),
  );

  /// Attend la fin des lectures en cours (rechargement demandé par
  /// ref.invalidate), au plus [delai] : durée du geste « tirer pour
  /// rafraîchir ».
  Future<void> attendreFinChargements({
    Duration delai = const Duration(seconds: 20),
  }) async {
    // Laisse Riverpod relancer les providers invalidés.
    await Future<void>.delayed(const Duration(milliseconds: 100));
    final limite = _horloge().add(delai);
    while (_enCours > 0 && _horloge().isBefore(limite)) {
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
  }

  /// Lecture brute du cache (hors mécanique SWR), pour les usages ponctuels.
  Future<EntreeCache?> lireBrut(ContexteCache ctx, String cle) =>
      _disque.lire(ctx.portee, ctx.cleComplete(cle));

  Future<void> ecrireBrut(ContexteCache ctx, String cle, Object? donnees) =>
      _disque.ecrire(ctx.portee, ctx.cleComplete(cle), donnees);

  Future<void> invalider(ContexteCache ctx, String cle) =>
      _disque.invalider(ctx.portee, ctx.cleComplete(cle));

  /// Purge toutes les entrées d'un utilisateur (déconnexion / changement de
  /// compte).
  Future<void> purgerUtilisateur(int id) {
    final portee = ContexteCache.porteeUtilisateur(id);
    _purgesA[portee] = _horloge();
    return _disque.purgerPortee(portee);
  }

  /// Émet la valeur (et son origine) : cache d'abord, réseau ensuite.
  ///
  /// [revalider] : vrai pour toujours consulter le réseau au premier
  /// chargement du processus, même si le cache est frais (publicités : leurs
  /// impressions ne doivent compter que pour une pub confirmée par le
  /// serveur).
  Stream<Source<T>> fluxSource<T>({
    required ContexteCache contexte,
    required String cle,
    required PolitiqueCache politique,
    required Future<Object?> Function() reseau,
    required T Function(Object? json) decoder,
    bool revalider = false,
  }) async* {
    _enCours++;
    try {
      yield* _lire<T>(
        contexte: contexte,
        cle: cle,
        politique: politique,
        reseau: reseau,
        decoder: decoder,
        revalider: revalider,
      );
    } finally {
      _enCours--;
    }
  }

  Stream<Source<T>> _lire<T>({
    required ContexteCache contexte,
    required String cle,
    required PolitiqueCache politique,
    required Future<Object?> Function() reseau,
    required T Function(Object? json) decoder,
    required bool revalider,
  }) async* {
    final debut = _horloge();
    final cleComplete = contexte.cleComplete(cle);
    final identifiant = '${contexte.portee}|$cleComplete';
    final rechargement = !_dejaCharges.add(identifiant);

    Source<T>? affiche;
    var frais = false;

    final entree = await _disque.lire(contexte.portee, cleComplete);
    if (entree != null) {
      final age = _horloge().difference(entree.ecritLe);
      // Âge négatif (horloge modifiée) ou trop vieux : ignoré.
      if (!age.isNegative && age <= politique.perime) {
        try {
          affiche = Source(decoder(entree.donnees), depuisReseau: false);
          frais = age <= politique.frais && !_perimee(cle, entree.ecritLe);
        } catch (_) {
          // Structure inattendue : on l'oublie, le réseau prendra le relais.
          await _disque.invalider(contexte.portee, cleComplete);
        }
      }
    }

    if (affiche != null) yield affiche;
    if (affiche != null && frais && !rechargement && !revalider) return;

    try {
      final brut = await reseau();
      final valeur = decoder(brut);
      final purge = _purgesA[contexte.portee];
      if (purge == null || purge.isBefore(debut)) {
        await _disque.ecrire(contexte.portee, cleComplete, brut);
      }
      yield Source(valeur, depuisReseau: true);
    } catch (e) {
      // Une donnée est déjà à l'écran : on la garde, sans erreur.
      if (affiche == null) rethrow;
    }
  }

  /// Comme [fluxSource], sans l'information d'origine.
  Stream<T> flux<T>({
    required ContexteCache contexte,
    required String cle,
    required PolitiqueCache politique,
    required Future<Object?> Function() reseau,
    required T Function(Object? json) decoder,
  }) => fluxSource<T>(
    contexte: contexte,
    cle: cle,
    politique: politique,
    reseau: reseau,
    decoder: decoder,
  ).map((s) => s.valeur);
}
