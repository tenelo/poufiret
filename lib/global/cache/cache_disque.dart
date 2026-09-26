import 'dart:convert';
import 'dart:io';

/// Une réponse JSON relue depuis le disque.
class EntreeCache {
  const EntreeCache({required this.donnees, required this.ecritLe});

  /// JSON décodé tel qu'il a été écrit (Map / List / valeur simple).
  final Object? donnees;
  final DateTime ecritLe;
}

/// Cache disque générique de réponses JSON, clé -> valeur horodatée.
///
/// - Cloisonné par PORTÉE (`u12`, `anon`, `session`...) : chaque portée a son
///   propre dossier, ce qui rend la purge d'un utilisateur atomique et évite
///   qu'un compte voie les données d'un autre.
/// - Versionné : une entrée écrite avec un autre [versionFormat] est ignorée
///   (et supprimée), jamais décodée. Il suffit d'incrémenter la constante
///   quand la structure stockée change.
/// - Tolérant : fichier absent, tronqué ou illisible => simple « miss ».
///   Aucune méthode ne lève d'exception.
///
/// Ne doit JAMAIS servir pour les paniers, commandes en cours, courses ou
/// suivi de livraison, ni pour une écriture (POST/PATCH/DELETE).
class CacheDisque {
  CacheDisque(this._racine, {DateTime Function()? horloge})
    : _horloge = horloge ?? DateTime.now;

  /// Version du format des enveloppes stockées.
  static const versionFormat = 1;

  final Future<String> Function() _racine;
  final DateTime Function() _horloge;

  static const _dossier = 'cache_api';

  Future<Directory> _dossierPortee(String portee) async {
    final racine = await _racine();
    return Directory('$racine${Platform.pathSeparator}$_dossier'
        '${Platform.pathSeparator}${_assainir(portee)}');
  }

  /// Nom de portée sûr pour un système de fichiers.
  static String _assainir(String s) => s.replaceAll(RegExp(r'[^A-Za-z0-9_-]'), '_');

  /// Nom de fichier stable : deux FNV-1a 32 bits (graines différentes) de la
  /// clé. La clé complète est stockée dans l'enveloppe et revérifiée à la
  /// lecture (anti-collision).
  static String _nomFichier(String cle) {
    final octets = utf8.encode(cle);
    String fnv(int graine) {
      var h = graine;
      for (final octet in octets) {
        h ^= octet;
        h = (h * 0x01000193) & 0xFFFFFFFF;
      }
      return h.toRadixString(16).padLeft(8, '0');
    }

    return '${fnv(0x811c9dc5)}${fnv(0x3c6ef372)}.json';
  }

  Future<File> _fichier(String portee, String cle) async {
    final dossier = await _dossierPortee(portee);
    return File('${dossier.path}${Platform.pathSeparator}${_nomFichier(cle)}');
  }

  /// Lit une entrée, ou null (absente, format incompatible, illisible).
  Future<EntreeCache?> lire(String portee, String cle) async {
    try {
      final fichier = await _fichier(portee, cle);
      if (!await fichier.exists()) return null;
      final enveloppe = jsonDecode(
        await _avecReprises(fichier.readAsString),
      );
      if (enveloppe is! Map) return null;
      if (enveloppe['v'] != versionFormat) {
        await _supprimer(fichier); // ancien format : on l'oublie
        return null;
      }
      if (enveloppe['k'] != cle) return null; // collision de nom : miss
      final t = enveloppe['t'];
      if (t is! int) return null;
      return EntreeCache(
        donnees: enveloppe['d'],
        ecritLe: DateTime.fromMillisecondsSinceEpoch(t),
      );
    } catch (_) {
      return null;
    }
  }

  /// Écrit (ou remplace) une entrée. Écriture atomique : fichier temporaire
  /// puis renommage, un crash en cours d'écriture ne laisse pas de JSON
  /// tronqué. Les erreurs d'écriture sont ignorées (le cache est optionnel).
  ///
  /// Sous Windows, renommer par-dessus un fichier qu'une lecture a ouvert
  /// échoue (« Accès refusé ») : sans traitement, la nouvelle valeur était
  /// perdue et l'ancienne restait. On réessaie donc brièvement, puis on
  /// écrit directement dans le fichier cible (non atomique, mais une lecture
  /// qui tomberait sur un JSON tronqué est simplement un « miss »).
  Future<void> ecrire(String portee, String cle, Object? donnees) async {
    try {
      final fichier = await _fichier(portee, cle);
      await fichier.parent.create(recursive: true);
      final contenu = jsonEncode({
        'v': versionFormat,
        'k': cle,
        't': _horloge().millisecondsSinceEpoch,
        'd': donnees,
      });
      final temporaire = File('${fichier.path}.tmp');
      try {
        await _avecReprises(() async {
          await temporaire.writeAsString(contenu, flush: true);
          await temporaire.rename(fichier.path);
        });
      } on FileSystemException {
        await fichier.writeAsString(contenu, flush: true);
        try {
          await temporaire.delete();
        } catch (_) {}
      }
    } catch (_) {}
  }

  /// Rejoue [operation] quelques fois si le système de fichiers refuse
  /// (fichier momentanément verrouillé), puis relance l'erreur.
  Future<T> _avecReprises<T>(Future<T> Function() operation) async {
    for (var essai = 0; ; essai++) {
      try {
        return await operation();
      } on FileSystemException {
        if (essai == 2) rethrow;
        await Future<void>.delayed(Duration(milliseconds: 20 * (essai + 1)));
      }
    }
  }

  /// Supprime une entrée.
  Future<void> invalider(String portee, String cle) async {
    try {
      await _supprimer(await _fichier(portee, cle));
    } catch (_) {}
  }

  /// Supprime toutes les entrées d'une portée (déconnexion, changement de
  /// compte).
  Future<void> purgerPortee(String portee) async {
    try {
      await _supprimerDossier(await _dossierPortee(portee));
    } catch (_) {}
  }

  /// Supprime tout le cache.
  Future<void> purgerTout() async {
    try {
      await _supprimerDossier(
        Directory('${await _racine()}${Platform.pathSeparator}$_dossier'),
      );
    } catch (_) {}
  }

  /// Suppression récursive avec quelques nouvelles tentatives : sous Windows
  /// (antivirus, indexeur), un fichier tout juste écrit peut rester verrouillé
  /// un court instant. Une purge de déconnexion ne doit pas échouer pour ça.
  Future<void> _supprimerDossier(Directory dossier) async {
    for (var essai = 0; essai < 4; essai++) {
      try {
        if (await dossier.exists()) await dossier.delete(recursive: true);
        return;
      } on FileSystemException {
        if (essai == 3) rethrow;
        await Future<void>.delayed(Duration(milliseconds: 60 * (essai + 1)));
      }
    }
  }

  Future<void> _supprimer(File f) async {
    if (await f.exists()) await f.delete();
  }
}
