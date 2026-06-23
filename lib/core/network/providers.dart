import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../storage/token_storage.dart';
import 'dio_client.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => TokenStorage();

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final tokens = ref.watch(tokenStorageProvider);
  return DioClient.creer(
    tokens: tokens,
    onSessionExpiree: () {
      // Le refresh a échoué : on invalide l'état d'auth.
      // (branché à l'AuthNotifier ci-dessous via ref.invalidate)
      ref.invalidate(tokenStorageProvider);
    },
  );
}
