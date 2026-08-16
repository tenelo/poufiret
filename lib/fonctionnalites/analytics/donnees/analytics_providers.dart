import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../global/network/providers.dart';
import 'analytics_repository.dart';

part 'analytics_providers.g.dart';

@Riverpod(keepAlive: true)
AnalyticsRepository analyticsRepository(Ref ref) =>
    AnalyticsRepository(ref.watch(dioProvider));

/// État de la session courante : identifiant + minute écoulée.
///
/// La minute est réévaluée à chaque ping et sert notamment à décider
/// du moment d'affichage de la publicité interstitielle.
class EtatSession {
  const EtatSession({this.sessionId, this.minute = 0});

  final String? sessionId;
  final int minute;

  bool get estActive => sessionId != null;

  EtatSession copyWith({String? sessionId, int? minute}) => EtatSession(
        sessionId: sessionId ?? this.sessionId,
        minute: minute ?? this.minute,
      );
}

/// Pilote le heartbeat de session.
///
/// Cycle : [demarrer] à l'ouverture de l'app (ou après connexion), ping
/// automatique toutes les 60 secondes, [arreter] à la déconnexion ou quand
/// l'app passe en arrière-plan.
@Riverpod(keepAlive: true)
class SessionAnalytics extends _$SessionAnalytics {
  Timer? _minuteur;
  static const _intervalle = Duration(seconds: 60);

  @override
  EtatSession build() {
    ref.onDispose(_annulerMinuteur);
    return const EtatSession();
  }

  void _annulerMinuteur() {
    _minuteur?.cancel();
    _minuteur = null;
  }

  /// Ouvre une session et lance le heartbeat. Sans effet si déjà active.
  Future<void> demarrer() async {
    if (state.estActive) return;
    final id = await ref.read(analyticsRepositoryProvider).demarrerSession();
    if (id == null) return; // analytics désactivé côté serveur
    state = EtatSession(sessionId: id);
    _annulerMinuteur();
    _minuteur = Timer.periodic(_intervalle, (_) => _pinguer());
  }

  Future<void> _pinguer() async {
    final id = state.sessionId;
    if (id == null) return;
    final minute = await ref.read(analyticsRepositoryProvider).pinguer(id);
    if (minute != null) {
      state = state.copyWith(minute: minute);
    }
  }

  /// Stoppe le heartbeat (arrière-plan, déconnexion).
  void arreter() {
    _annulerMinuteur();
    state = const EtatSession();
  }

  /// Reprend le heartbeat au retour au premier plan.
  Future<void> reprendre() async {
    if (state.estActive) return;
    await demarrer();
  }
}

/// Enregistre la consultation d'un article.
///
/// Auto-disposable : le provider est recréé à chaque ouverture de la fiche,
/// donc chaque consultation compte comme une vue distincte.
@riverpod
Future<void> vueArticle(
  Ref ref, {
  required String slug,
  String source = 'detail',
}) async {
  await ref
      .read(analyticsRepositoryProvider)
      .enregistrerVueArticle(slug, source: source);
}

/// Enregistre l'entrée dans le catalogue d'une catégorie.
///
/// Auto-disposable : recréé à chaque entrée dans le catalogue, donc revenir
/// à l'accueil puis recliquer la catégorie compte une nouvelle visite.
@riverpod
Future<void> visiteCategorie(Ref ref, {required int categorieId}) async {
  await ref
      .read(analyticsRepositoryProvider)
      .enregistrerVisiteCategorie(categorieId);
}

/// Enregistre la consultation de la vitrine d'un partenaire.
///
/// Auto-disposable : une vue par ouverture de la fiche.
@riverpod
Future<void> vueVitrine(
  Ref ref, {
  required int partenaireId,
  String source = 'annuaire',
  bool avecCatalogue = true,
}) async {
  await ref
      .read(analyticsRepositoryProvider)
      .enregistrerVueVitrine(partenaireId,
          source: source, avecCatalogue: avecCatalogue);
}