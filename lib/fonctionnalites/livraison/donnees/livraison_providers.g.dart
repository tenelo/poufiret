// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livraison_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(livraisonRepository)
final livraisonRepositoryProvider = LivraisonRepositoryProvider._();

final class LivraisonRepositoryProvider
    extends
        $FunctionalProvider<
          LivraisonRepository,
          LivraisonRepository,
          LivraisonRepository
        >
    with $Provider<LivraisonRepository> {
  LivraisonRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'livraisonRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$livraisonRepositoryHash();

  @$internal
  @override
  $ProviderElement<LivraisonRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LivraisonRepository create(Ref ref) {
    return livraisonRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LivraisonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LivraisonRepository>(value),
    );
  }
}

String _$livraisonRepositoryHash() =>
    r'19d529042c468122ad93e13cca63ec1ff51589cf';

/// Historique de mes courses (option filtre statut).

@ProviderFor(mesCourses)
final mesCoursesProvider = MesCoursesFamily._();

/// Historique de mes courses (option filtre statut).

final class MesCoursesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Course>>,
          List<Course>,
          FutureOr<List<Course>>
        >
    with $FutureModifier<List<Course>>, $FutureProvider<List<Course>> {
  /// Historique de mes courses (option filtre statut).
  MesCoursesProvider._({
    required MesCoursesFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'mesCoursesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mesCoursesHash();

  @override
  String toString() {
    return r'mesCoursesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Course>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Course>> create(Ref ref) {
    final argument = this.argument as String?;
    return mesCourses(ref, statut: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MesCoursesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mesCoursesHash() => r'e8f156df994c0bd05a1de672fc7672b66a05f2cb';

/// Historique de mes courses (option filtre statut).

final class MesCoursesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Course>>, String?> {
  MesCoursesFamily._()
    : super(
        retry: null,
        name: r'mesCoursesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Historique de mes courses (option filtre statut).

  MesCoursesProvider call({String? statut}) =>
      MesCoursesProvider._(argument: statut, from: this);

  @override
  String toString() => r'mesCoursesProvider';
}

/// Detail d'une course par id (UUID string).

@ProviderFor(courseDetail)
final courseDetailProvider = CourseDetailFamily._();

/// Detail d'une course par id (UUID string).

final class CourseDetailProvider
    extends $FunctionalProvider<AsyncValue<Course>, Course, FutureOr<Course>>
    with $FutureModifier<Course>, $FutureProvider<Course> {
  /// Detail d'une course par id (UUID string).
  CourseDetailProvider._({
    required CourseDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'courseDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$courseDetailHash();

  @override
  String toString() {
    return r'courseDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Course> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Course> create(Ref ref) {
    final argument = this.argument as String;
    return courseDetail(ref, id: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CourseDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$courseDetailHash() => r'065380e58f33a1f4509448f76a61b16ff0ad7bb7';

/// Detail d'une course par id (UUID string).

final class CourseDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Course>, String> {
  CourseDetailFamily._()
    : super(
        retry: null,
        name: r'courseDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Detail d'une course par id (UUID string).

  CourseDetailProvider call({required String id}) =>
      CourseDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'courseDetailProvider';
}

/// Courses ou je suis le destinataire (colis qui m'arrivent).

@ProviderFor(coursesRecues)
final coursesRecuesProvider = CoursesRecuesFamily._();

/// Courses ou je suis le destinataire (colis qui m'arrivent).

final class CoursesRecuesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Course>>,
          List<Course>,
          FutureOr<List<Course>>
        >
    with $FutureModifier<List<Course>>, $FutureProvider<List<Course>> {
  /// Courses ou je suis le destinataire (colis qui m'arrivent).
  CoursesRecuesProvider._({
    required CoursesRecuesFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'coursesRecuesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$coursesRecuesHash();

  @override
  String toString() {
    return r'coursesRecuesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Course>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Course>> create(Ref ref) {
    final argument = this.argument as String?;
    return coursesRecues(ref, statut: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CoursesRecuesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$coursesRecuesHash() => r'004085e0810709e82a6c91b8097049008c8df7b0';

/// Courses ou je suis le destinataire (colis qui m'arrivent).

final class CoursesRecuesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Course>>, String?> {
  CoursesRecuesFamily._()
    : super(
        retry: null,
        name: r'coursesRecuesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Courses ou je suis le destinataire (colis qui m'arrivent).

  CoursesRecuesProvider call({String? statut}) =>
      CoursesRecuesProvider._(argument: statut, from: this);

  @override
  String toString() => r'coursesRecuesProvider';
}

/// Prix de course courant (lu depuis l'admin via l'endpoint public).

@ProviderFor(tarifCourse)
final tarifCourseProvider = TarifCourseProvider._();

/// Prix de course courant (lu depuis l'admin via l'endpoint public).

final class TarifCourseProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Prix de course courant (lu depuis l'admin via l'endpoint public).
  TarifCourseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tarifCourseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tarifCourseHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return tarifCourse(ref);
  }
}

String _$tarifCourseHash() => r'cda2d1fa757ba7aae0c4c85982cc885f9c9d048c';

/// Livreurs en ligne proches, pour la carte. Rafraichi par polling cote UI.

@ProviderFor(livreursProches)
final livreursProchesProvider = LivreursProchesFamily._();

/// Livreurs en ligne proches, pour la carte. Rafraichi par polling cote UI.

final class LivreursProchesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LivreurProche>>,
          List<LivreurProche>,
          FutureOr<List<LivreurProche>>
        >
    with
        $FutureModifier<List<LivreurProche>>,
        $FutureProvider<List<LivreurProche>> {
  /// Livreurs en ligne proches, pour la carte. Rafraichi par polling cote UI.
  LivreursProchesProvider._({
    required LivreursProchesFamily super.from,
    required ({double? lat, double? lng}) super.argument,
  }) : super(
         retry: null,
         name: r'livreursProchesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$livreursProchesHash();

  @override
  String toString() {
    return r'livreursProchesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<LivreurProche>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LivreurProche>> create(Ref ref) {
    final argument = this.argument as ({double? lat, double? lng});
    return livreursProches(ref, lat: argument.lat, lng: argument.lng);
  }

  @override
  bool operator ==(Object other) {
    return other is LivreursProchesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$livreursProchesHash() => r'26251c49a1972dbd6c3509a0a3d2f61dcb3f0277';

/// Livreurs en ligne proches, pour la carte. Rafraichi par polling cote UI.

final class LivreursProchesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<LivreurProche>>,
          ({double? lat, double? lng})
        > {
  LivreursProchesFamily._()
    : super(
        retry: null,
        name: r'livreursProchesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Livreurs en ligne proches, pour la carte. Rafraichi par polling cote UI.

  LivreursProchesProvider call({double? lat, double? lng}) =>
      LivreursProchesProvider._(argument: (lat: lat, lng: lng), from: this);

  @override
  String toString() => r'livreursProchesProvider';
}
