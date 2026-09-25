import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'cache_api.dart';
import 'cache_disque.dart';

/// Cache disque de l'app (dossier de support applicatif : non visible de
/// l'utilisateur, non purgé par le système comme un dossier temporaire).
final cacheDisqueProvider = Provider<CacheDisque>(
  (ref) => CacheDisque(() async => (await getApplicationSupportDirectory()).path),
);

/// Lecture stale-while-revalidate au-dessus du cache disque.
final cacheApiProvider = Provider<CacheApi>(
  (ref) => CacheApi(ref.watch(cacheDisqueProvider)),
);
