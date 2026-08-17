# Architecture du projet Poufiret

Ce document explique comment le code Flutter de Poufiret est organisé, pour que n'importe qui (y compris vous, dans six mois) puisse retrouver rapidement où vit une information et où ajouter une nouvelle fonctionnalité sans casser le reste.

## 1. Le principe : ranger par métier, pas par type technique

Beaucoup de projets Flutter rangent le code par **type technique** : un dossier `screens/` avec tous les écrans de l'app, un dossier `models/` avec tous les modèles, un dossier `services/` avec tous les services... Le problème : pour comprendre ou modifier une seule fonctionnalité (par exemple la livraison), il faut sauter entre cinq dossiers différents et deviner quels fichiers appartiennent à quoi.

Poufiret fait l'inverse : le code est rangé **par domaine métier** (« feature »), pas par type technique. Tout ce qui concerne l'authentification vit dans un seul dossier, tout ce qui concerne le catalogue dans un autre, etc. Cette approche s'appelle une **architecture par fonctionnalités (feature-first)**.

Concrètement, `lib/` contient deux grands dossiers :

```
lib/
├── global/            → le socle commun à toute l'application
├── fonctionnalites/    → une fonctionnalité = un dossier autonome
└── main.dart           → point d'entrée de l'app
```

## 2. `lib/global/` — le socle transverse

`lib/global/` regroupe tout ce qui est **partagé par l'ensemble de l'application** et qui n'appartient à aucune fonctionnalité en particulier : configuration, communication réseau, stockage sécurisé, gestion d'erreurs, navigation globale, etc.

### La règle mentale pour savoir si un fichier va dans `global/`

> **Si je supprimais une fonctionnalité (ex. `livraison`), ce fichier disparaîtrait-il avec elle ?**
> - Oui → il appartient à cette fonctionnalité, donc dans `fonctionnalites/livraison/`.
> - Non, il resterait utile pour le reste de l'app → il va dans `global/`.

Par exemple, `Dio` (le client HTTP) et le stockage des tokens sont utilisés par *toutes* les fonctionnalités qui parlent au backend : ils vont dans `global/`. À l'inverse, le modèle `Utilisateur` n'a de sens que pour l'authentification : il reste dans `fonctionnalites/auth/`.

### Les sous-dossiers de `global/`

| Sous-dossier | Rôle |
|---|---|
| `config/` | Configuration de l'app : `env.dart` (URL de base de l'API, préfixe `apiPrefix`...) et `config.dart`. |
| `network/` | Le client HTTP partagé : `dio_client.dart` configure l'instance `Dio`, `auth_interceptor.dart` ajoute automatiquement le token d'authentification à chaque requête (et gère son renouvellement), `providers.dart` expose ces objets à Riverpod. |
| `storage/` | Stockage sécurisé des données sensibles, notamment `token_storage.dart` qui sauvegarde/lit/efface les tokens d'accès et de rafraîchissement. |
| `errors/` | Gestion d'erreurs uniforme, avec `api_exception.dart` pour représenter proprement une erreur venue du backend. |
| `navigation/` | La coquille (« shell ») de l'application : `app_shell.dart` bascule entre barre de navigation basse (mobile) et rail latéral (tablette/web), `app_drawer.dart` est le menu tiroir, `destinations.dart` liste les onglets principaux. |
| `responsive/` | Outils d'adaptation à la taille d'écran : `breakpoints.dart` définit les seuils (mobile/tablette/web), `conteneur_adaptatif.dart` est un widget qui adapte sa largeur. |
| `widgets/` | Composants d'interface réutilisables par plusieurs fonctionnalités : `carrousel_images.dart`, `image_reseau.dart`, `visionneuse_images.dart`. |
| `notifications/` | Service de notifications push : `fcm_service.dart` (Firebase Cloud Messaging), `notifications_locales.dart`, `routeur_notifications.dart` (redirige vers le bon écran au clic sur une notification). |

## 3. `lib/fonctionnalites/` — une fonctionnalité, un dossier

Chaque grande fonctionnalité de l'app a son propre dossier autonome sous `lib/fonctionnalites/` : `auth`, `catalogue`, `livraison`, `social`, `publicites`, `chat`, `favoris`, `geo`, `map`, `orders`, `partenaire`, `prestations`, `account`, `analytics`, `version`...

**Avantage** : tout ce qui concerne une fonctionnalité donnée est au même endroit. Besoin de comprendre comment fonctionne la livraison ? Tout est dans `lib/fonctionnalites/livraison/` — pas besoin de chercher ailleurs. Cela rend aussi plus facile de faire évoluer ou de supprimer une fonctionnalité sans risquer de casser les autres.

## 4. Les trois couches d'une fonctionnalité

À l'intérieur de chaque dossier de fonctionnalité, on retrouve (selon les besoins de la fonctionnalité) jusqu'à trois sous-dossiers, qui forment autant de couches avec un rôle bien défini :

### `metier_domaine/` — les objets métier purs

Ce sont les définitions des données manipulées par la fonctionnalité, **sans aucune logique technique** (pas d'appel réseau, pas d'UI). Par exemple `lib/fonctionnalites/auth/metier_domaine/utilisateur.dart` définit la classe `Utilisateur` (id, téléphone, prénom, rôle...) grâce à l'annotation `@freezed`, qui rend l'objet immuable et génère automatiquement les méthodes de copie/comparaison.

Cette classe expose aussi quelques raccourcis pratiques pour l'UI, purement dérivés des données (ex. `estPartenaire`, `nomComplet`), mais aucune logique d'accès au réseau ou de stockage.

Vous verrez à côté des fichiers `.freezed.dart` et `.g.dart` (ex. `utilisateur.freezed.dart`, `utilisateur.g.dart`) : ce sont des fichiers **générés automatiquement** par les paquets `freezed` et `json_serializable`. On ne les modifie jamais à la main — ils sont recréés à chaque `dart run build_runner build`.

### `donnees/` — l'accès aux données

Ce dossier contient les **repositories**, qui font le lien entre l'app et le backend : ils effectuent les appels HTTP (via le `Dio` partagé dans `global/network/`) et transforment le JSON reçu en objets `metier_domaine`.

Exemple : `lib/fonctionnalites/auth/donnees/auth_repository.dart` contient `AuthRepository.connexion()`, qui envoie `POST /auth/connexion/`, sauvegarde les tokens reçus via `TokenStorage`, puis renvoie un `Utilisateur.fromJson(...)`.

Ce dossier contient aussi les fichiers `*_providers.dart` (et leur `.g.dart` généré), qui déclarent les providers Riverpod exposant le repository au reste de la fonctionnalité.

### `screens/` — l'interface

Ce dossier regroupe :
- les **écrans** vus par l'utilisateur (ex. `ecran_connexion.dart`, `ecran_articles.dart`, `ecran_livraison.dart`) ;
- les **notifiers** Riverpod (ex. `auth_notifier.dart`), qui gèrent l'état de la fonctionnalité et orchestrent les appels au repository de `donnees/` en réponse aux actions de l'utilisateur.

Certaines fonctionnalités ont aussi un dossier `widgets/` pour des composants d'interface qui ne sont utiles qu'à cette fonctionnalité précise (à ne pas confondre avec `global/widgets/`, réservé aux composants partagés par toute l'app).

## 5. Le flux de données, en schéma

```
                     ┌────────────────────────────────────┐
                     │              screens/               │
                     │  (écran + notifier Riverpod)         │
                     └───────────────┬──────────────────────┘
                                     │ appelle une méthode
                                     ▼
                     ┌────────────────────────────────────┐
                     │              donnees/                │
                     │  (repository : appel HTTP via Dio)   │
                     └───────────────┬──────────────────────┘
                                     │ requête HTTP (JSON)
                                     ▼
                     ┌────────────────────────────────────┐
                     │               Backend                │
                     └───────────────┬──────────────────────┘
                                     │ réponse JSON
                                     ▼
                     ┌────────────────────────────────────┐
                     │            metier_domaine/           │
                     │  (JSON → objet .fromJson(...))       │
                     └───────────────┬──────────────────────┘
                                     │ objet typé
                                     ▼
                     ┌────────────────────────────────────┐
                     │              screens/                │
                     │  (état mis à jour → UI redessinée)   │
                     └────────────────────────────────────┘
```

Autrement dit : l'écran demande une donnée → le repository va la chercher sur le backend → le JSON reçu est transformé en objet métier typé → cet objet remonte jusqu'à l'écran, qui se redessine avec les nouvelles données.

## 6. Riverpod : la gestion d'état

**Riverpod** est la bibliothèque utilisée dans tout le projet pour gérer l'état de l'application (les données qui changent au fil du temps et doivent se refléter dans l'UI).

### À quoi ça sert ?

Riverpod permet de **partager un état entre des écrans qui ne se connaissent pas**. Par exemple, l'état « utilisateur connecté » (`AuthNotifier` dans `lib/fonctionnalites/auth/screens/auth_notifier.dart`) doit être lisible depuis n'importe quel écran de l'app (pour savoir si on affiche l'écran de connexion ou le contenu protégé), sans que ces écrans aient besoin de se passer l'information de main en main via leurs constructeurs.

### Pourquoi ce choix ?

- **Injection de dépendances** : un provider (ex. `authRepositoryProvider`) fournit une instance prête à l'emploi (déjà connectée à `Dio` et à `TokenStorage`) à qui en a besoin, sans passer par des constructeurs à rallonge.
- **État réactif** : quand un notifier change son état (ex. après une connexion réussie), tous les widgets qui l'observent (`ref.watch(...)`) se reconstruisent automatiquement.
- **Gestion asynchrone avec `AsyncValue`** : un appel réseau a trois états possibles (en cours, réussi, en erreur). `AsyncValue` (et `AsyncValue.guard`, visible dans `auth_notifier.dart`) encode ces trois états directement dans le type, ce qui évite d'oublier de gérer le cas « erreur » ou « chargement » dans l'UI.
- **Sûreté à la compilation** : les fichiers annotés `@riverpod` (ex. `@riverpod class AuthNotifier`) génèrent leur code de câblage via `build_runner` (fichiers `.g.dart`). Une erreur de typage ou un provider mal référencé est détectée à la compilation, pas seulement au runtime.
- **Testabilité** : chaque provider peut être remplacé (« override ») dans les tests, ce qui permet de tester un écran avec un faux repository sans toucher au vrai réseau.

## 7. Tableau récapitulatif

| Dossier | Rôle en une phrase |
|---|---|
| `lib/main.dart` | Point d'entrée de l'application. |
| `lib/global/` | Socle transverse partagé par toute l'app (rien de spécifique à une fonctionnalité). |
| `lib/global/config/` | Configuration de l'app (URL de l'API, constantes d'environnement). |
| `lib/global/network/` | Client HTTP `Dio` partagé et intercepteur d'authentification. |
| `lib/global/storage/` | Stockage sécurisé des tokens d'authentification. |
| `lib/global/errors/` | Représentation uniforme des erreurs venant du backend. |
| `lib/global/navigation/` | Coquille de l'app : bottom bar / rail, menu tiroir, liste des onglets. |
| `lib/global/responsive/` | Seuils et widgets pour adapter l'UI à la taille d'écran. |
| `lib/global/widgets/` | Composants d'interface réutilisables par plusieurs fonctionnalités. |
| `lib/global/notifications/` | Service de notifications push (Firebase Cloud Messaging). |
| `lib/fonctionnalites/<nom>/` | Une fonctionnalité métier autonome (ex. `auth`, `catalogue`, `livraison`). |
| `lib/fonctionnalites/<nom>/metier_domaine/` | Objets métier purs de la fonctionnalité (définition des données). |
| `lib/fonctionnalites/<nom>/donnees/` | Repository(s) : appels HTTP au backend et conversion JSON → objets métier. |
| `lib/fonctionnalites/<nom>/screens/` | Écrans vus par l'utilisateur et notifiers Riverpod gérant leur état. |
| `lib/fonctionnalites/<nom>/widgets/` | Composants d'interface propres à cette fonctionnalité (quand présent). |
| `*.freezed.dart`, `*.g.dart` | Fichiers générés automatiquement (freezed, json_serializable, riverpod_generator) — ne jamais les modifier à la main. |
