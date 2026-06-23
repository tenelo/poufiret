import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/providers.dart';
import 'auth_repository.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(
    dio: ref.watch(dioProvider),
    tokens: ref.watch(tokenStorageProvider),
  );
}
