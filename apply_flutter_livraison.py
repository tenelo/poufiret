#!/usr/bin/env python3
"""Applique le tracking Flutter des consultations de l'onglet Livraison.

- lib/fonctionnalites/analytics/donnees/analytics_repository.dart :
  ajoute enregistrerVueServiceLivraison().
- lib/global/navigation/app_shell.dart : AppShell devient
  ConsumerStatefulWidget, _onTap declenche le tracking au changement
  d'onglet vers Livraison (fire-and-forget, silencieux).

Aucun nouveau provider @riverpod : pas de build_runner necessaire.

A lancer depuis la racine du projet Flutter (poufiret) :
    python3 apply_flutter_livraison.py

Idempotent : si les fichiers ont deja ete modifies, le script le detecte
et ne touche a rien (message "deja applique"). Si un fichier ne correspond
NI a l'original attendu NI a la version deja modifiee, il s'arrete sans
rien ecrire (le fichier a probablement change entre-temps).
Ne fait AUCUN commit, AUCUN push, AUCUNE commande flutter/dart.
"""
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent
REPO_FILE = ROOT / 'lib' / 'fonctionnalites' / 'analytics' / 'donnees' / 'analytics_repository.dart'
SHELL_FILE = ROOT / 'lib' / 'global' / 'navigation' / 'app_shell.dart'


REPO_ORIGINAL = '''import 'package:dio/dio.dart';

import '../../../global/config/env.dart';

/// Accès aux endpoints de tracking de session.
///
/// Le backend mesure la durée réelle par heartbeat : on démarre une session
/// à l'ouverture de l'app, puis on envoie un ping toutes les 60 secondes.
///
/// Toutes les erreurs sont avalées : le tracking ne doit jamais interrompre
/// le parcours utilisateur, et l'intercepteur global convertit déjà les
/// DioException en ApiException.
class AnalyticsRepository {
  AnalyticsRepository(this._dio);

  final Dio _dio;

  /// Démarre une session et renvoie son identifiant, ou null en cas d'échec.
  Future<String?> demarrerSession({String source = 'mobile'}) async {
    try {
      final reponse = await _dio.post<Map<String, dynamic>>(
        '${Env.apiPrefix}/analytics/session/demarrer/',
        data: {'source': source},
      );
      return reponse.data?['session_id'] as String?;
    } catch (_) {
      return null;
    }
  }

  /// Envoie un ping et renvoie la minute courante de session, ou null.
  Future<int?> pinguer(String sessionId) async {
    try {
      final reponse = await _dio.post<Map<String, dynamic>>(
        '${Env.apiPrefix}/analytics/session/ping/',
        data: {'session_id': sessionId},
      );
      return reponse.data?['minute_session'] as int?;
    } catch (_) {
      return null;
    }
  }

  /// Enregistre l'entree dans le catalogue d'une categorie.
  ///
  /// Une visite = +1, quel que soit le nombre d'articles ouverts ensuite.
  Future<void> enregistrerVisiteCategorie(int categorieId) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/categorie/visite/',
        data: {'categorie_id': categorieId},
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais l'affichage.
    }
  }

  /// Enregistre la consultation de la vitrine d'un partenaire.
  ///
  /// Seul signal disponible pour les metiers de service, ou le client
  /// ne consulte aucun article.
  Future<void> enregistrerVueVitrine(int partenaireId,
      {String source = 'annuaire', bool avecCatalogue = true}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/vitrine/vue/',
        data: {
          'partenaire': partenaireId,
          'source': source,
          'avec_catalogue': avecCatalogue,
        },
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais l'affichage.
    }
  }

  /// Enregistre la consultation d'un article (alimente le profil de navigation).
  Future<void> enregistrerVueArticle(String slug, {String source = 'liste'}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/catalogue/articles/$slug/vue/',
        data: {'source': source},
      );
    } catch (_) {
      // Silencieux : une vue perdue ne doit jamais bloquer l'affichage.
    }
  }
}
'''

REPO_NOUVEAU = '''import 'package:dio/dio.dart';

import '../../../global/config/env.dart';

/// Accès aux endpoints de tracking de session.
///
/// Le backend mesure la durée réelle par heartbeat : on démarre une session
/// à l'ouverture de l'app, puis on envoie un ping toutes les 60 secondes.
///
/// Toutes les erreurs sont avalées : le tracking ne doit jamais interrompre
/// le parcours utilisateur, et l'intercepteur global convertit déjà les
/// DioException en ApiException.
class AnalyticsRepository {
  AnalyticsRepository(this._dio);

  final Dio _dio;

  /// Démarre une session et renvoie son identifiant, ou null en cas d'échec.
  Future<String?> demarrerSession({String source = 'mobile'}) async {
    try {
      final reponse = await _dio.post<Map<String, dynamic>>(
        '${Env.apiPrefix}/analytics/session/demarrer/',
        data: {'source': source},
      );
      return reponse.data?['session_id'] as String?;
    } catch (_) {
      return null;
    }
  }

  /// Envoie un ping et renvoie la minute courante de session, ou null.
  Future<int?> pinguer(String sessionId) async {
    try {
      final reponse = await _dio.post<Map<String, dynamic>>(
        '${Env.apiPrefix}/analytics/session/ping/',
        data: {'session_id': sessionId},
      );
      return reponse.data?['minute_session'] as int?;
    } catch (_) {
      return null;
    }
  }

  /// Enregistre l'entree dans le catalogue d'une categorie.
  ///
  /// Une visite = +1, quel que soit le nombre d'articles ouverts ensuite.
  Future<void> enregistrerVisiteCategorie(int categorieId) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/categorie/visite/',
        data: {'categorie_id': categorieId},
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais l'affichage.
    }
  }

  /// Enregistre la consultation de la vitrine d'un partenaire.
  ///
  /// Seul signal disponible pour les metiers de service, ou le client
  /// ne consulte aucun article.
  Future<void> enregistrerVueVitrine(int partenaireId,
      {String source = 'annuaire', bool avecCatalogue = true}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/vitrine/vue/',
        data: {
          'partenaire': partenaireId,
          'source': source,
          'avec_catalogue': avecCatalogue,
        },
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais l'affichage.
    }
  }

  /// Enregistre la consultation d'un article (alimente le profil de navigation).
  Future<void> enregistrerVueArticle(String slug, {String source = 'liste'}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/catalogue/articles/$slug/vue/',
        data: {'source': source},
      );
    } catch (_) {
      // Silencieux : une vue perdue ne doit jamais bloquer l'affichage.
    }
  }

  /// Enregistre l'ouverture de l'onglet Livraison.
  ///
  /// Simple compteur de consultation (ne mesure pas l'usage reel du
  /// service) : tolerant a l'anonyme, cote serveur.
  Future<void> enregistrerVueServiceLivraison({String source = 'onglet'}) async {
    try {
      await _dio.post<void>(
        '${Env.apiPrefix}/analytics/livraison/vue/',
        data: {'source': source},
      );
    } catch (_) {
      // Silencieux : le tracking ne bloque jamais la navigation.
    }
  }
}
'''

SHELL_ORIGINAL = '''import 'package:flutter/material.dart';
import 'package:poufiret/fonctionnalites/chat/screens/ecran_conversations.dart';

import 'destinations.dart';
import '../../fonctionnalites/catalogue/screens/ecran_categories.dart';
import '../../fonctionnalites/publicites/screens/ecran_publicites.dart';
import '../../fonctionnalites/livraison/screens/ecran_livraison.dart';
import '../../fonctionnalites/map/screens/ecran_map.dart';


/// Coquille principale : héberge les onglets et bascule entre
/// barre basse (mobile) et rail latéral (tablette / web) selon la largeur.
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

static const _pages = [
    EcranCategories(),
    EcranPublicites(),
    EcranConversations(),
    EcranLivraison(),
    EcranMap(),
  ];

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 600;
        final extended = constraints.maxWidth >= 1024;
        // Le bandeau publicitaire est desormais gere globalement par
        // CouchePublicites, a la racine de l'application : il reste
        // visible sur les ecrans pousses par-dessus la coquille.
        final body = IndexedStack(index: _index, children: _pages);

        if (useRail) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: _onTap,
                  extended: extended,
                  labelType: extended ? null : NavigationRailLabelType.all,
                  destinations: [
                    for (final d in kDestinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: body),
              ],
            ),
          );
        }

        return Scaffold(
          body: body,
          bottomNavigationBar: NavigationBar(
            height: 64,
            selectedIndex: _index,
            onDestinationSelected: _onTap,
            destinations: [
              for (final d in kDestinations)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                ),
            ],
          ),
        );
      },
    );
  }
}
'''

SHELL_NOUVEAU = '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poufiret/fonctionnalites/chat/screens/ecran_conversations.dart';

import 'destinations.dart';
import '../../fonctionnalites/analytics/donnees/analytics_providers.dart';
import '../../fonctionnalites/catalogue/screens/ecran_categories.dart';
import '../../fonctionnalites/publicites/screens/ecran_publicites.dart';
import '../../fonctionnalites/livraison/screens/ecran_livraison.dart';
import '../../fonctionnalites/map/screens/ecran_map.dart';


/// Coquille principale : héberge les onglets et bascule entre
/// barre basse (mobile) et rail latéral (tablette / web) selon la largeur.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  int _index = 0;

static const _pages = [
    EcranCategories(),
    EcranPublicites(),
    EcranConversations(),
    EcranLivraison(),
    EcranMap(),
  ];

  // Index de l'onglet Livraison dans kDestinations / _pages (voir
  // destinations.dart : l'ordre des deux listes DOIT rester synchronise).
  static const _indexLivraison = 3;

  void _onTap(int i) {
    // Nouvel onglet uniquement : re-taper l'onglet deja actif ne doit pas
    // regonfler artificiellement le compteur de consultations.
    final estNouvelOnglet = i != _index;
    setState(() => _index = i);
    if (estNouvelOnglet && i == _indexLivraison) {
      // Fire-and-forget : la navigation ne doit jamais attendre le reseau.
      ref.read(analyticsRepositoryProvider).enregistrerVueServiceLivraison();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth >= 600;
        final extended = constraints.maxWidth >= 1024;
        // Le bandeau publicitaire est desormais gere globalement par
        // CouchePublicites, a la racine de l'application : il reste
        // visible sur les ecrans pousses par-dessus la coquille.
        final body = IndexedStack(index: _index, children: _pages);

        if (useRail) {
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _index,
                  onDestinationSelected: _onTap,
                  extended: extended,
                  labelType: extended ? null : NavigationRailLabelType.all,
                  destinations: [
                    for (final d in kDestinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        selectedIcon: Icon(d.selectedIcon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: body),
              ],
            ),
          );
        }

        return Scaffold(
          body: body,
          bottomNavigationBar: NavigationBar(
            height: 64,
            selectedIndex: _index,
            onDestinationSelected: _onTap,
            destinations: [
              for (final d in kDestinations)
                NavigationDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: d.label,
                ),
            ],
          ),
        );
      },
    );
  }
}
'''


def echec(message):
    print(f"ERREUR : {message}", file=sys.stderr)
    sys.exit(1)


def appliquer(chemin, original, nouveau, nom):
    if not chemin.exists():
        echec(f"{chemin} introuvable. Lance ce script depuis la racine du projet Flutter (poufiret).")
    contenu = chemin.read_text()
    if contenu == nouveau:
        print(f"[deja applique] {nom} : inchange.")
        return
    if contenu != original:
        echec(
            f"{nom} ne correspond ni au contenu original attendu ni a la "
            "version deja modifiee. Le fichier a probablement change "
            "entre-temps : verifie-le manuellement avant de relancer."
        )
    chemin.write_text(nouveau)
    print(f"[modifie] {nom}")


def main():
    appliquer(REPO_FILE, REPO_ORIGINAL, REPO_NOUVEAU,
              'analytics_repository.dart')
    appliquer(SHELL_FILE, SHELL_ORIGINAL, SHELL_NOUVEAU, 'app_shell.dart')
    print("\nTermine. Aucun commit, aucun push, aucune commande flutter/dart executee.")
    print("Prochaine etape (a lancer toi-meme) : flutter analyze")


if __name__ == '__main__':
    main()
