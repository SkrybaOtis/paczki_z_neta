// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PackagesNotifier)
final packagesProvider = PackagesNotifierProvider._();

final class PackagesNotifierProvider
    extends $NotifierProvider<PackagesNotifier, PackagesState> {
  PackagesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packagesNotifierHash();

  @$internal
  @override
  PackagesNotifier create() => PackagesNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackagesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackagesState>(value),
    );
  }
}

String _$packagesNotifierHash() => r'08560f09a9423225558d1151bd4ee4dc42e04aef';

abstract class _$PackagesNotifier extends $Notifier<PackagesState> {
  PackagesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PackagesState, PackagesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PackagesState, PackagesState>,
              PackagesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedFilter)
final selectedFilterProvider = SelectedFilterProvider._();

final class SelectedFilterProvider
    extends $NotifierProvider<SelectedFilter, PackageFilter> {
  SelectedFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedFilterHash();

  @$internal
  @override
  SelectedFilter create() => SelectedFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackageFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackageFilter>(value),
    );
  }
}

String _$selectedFilterHash() => r'af6d32080e7ef1d4c4c0683db0fccc6e623a5322';

abstract class _$SelectedFilter extends $Notifier<PackageFilter> {
  PackageFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PackageFilter, PackageFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PackageFilter, PackageFilter>,
              PackageFilter,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredPackages)
final filteredPackagesProvider = FilteredPackagesProvider._();

final class FilteredPackagesProvider
    extends
        $FunctionalProvider<
          List<PackageEntity>,
          List<PackageEntity>,
          List<PackageEntity>
        >
    with $Provider<List<PackageEntity>> {
  FilteredPackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredPackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredPackagesHash();

  @$internal
  @override
  $ProviderElement<List<PackageEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PackageEntity> create(Ref ref) {
    return filteredPackages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PackageEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PackageEntity>>(value),
    );
  }
}

String _$filteredPackagesHash() => r'10715d6ddcabab1202e6d3810f34b8c0ba56033a';

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'2c146927785523a0ddf51b23b777a9be4afdc092';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(searchedPackages)
final searchedPackagesProvider = SearchedPackagesProvider._();

final class SearchedPackagesProvider
    extends
        $FunctionalProvider<
          List<PackageEntity>,
          List<PackageEntity>,
          List<PackageEntity>
        >
    with $Provider<List<PackageEntity>> {
  SearchedPackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchedPackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchedPackagesHash();

  @$internal
  @override
  $ProviderElement<List<PackageEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<PackageEntity> create(Ref ref) {
    return searchedPackages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PackageEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PackageEntity>>(value),
    );
  }
}

String _$searchedPackagesHash() => r'870ba96685fcc563e5a85db28b66a353a922430c';
