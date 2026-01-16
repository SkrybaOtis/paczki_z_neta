// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_local_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(packagesLocalDataSource)
final packagesLocalDataSourceProvider = PackagesLocalDataSourceProvider._();

final class PackagesLocalDataSourceProvider
    extends
        $FunctionalProvider<
          PackagesLocalDataSource,
          PackagesLocalDataSource,
          PackagesLocalDataSource
        >
    with $Provider<PackagesLocalDataSource> {
  PackagesLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packagesLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packagesLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<PackagesLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PackagesLocalDataSource create(Ref ref) {
    return packagesLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackagesLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackagesLocalDataSource>(value),
    );
  }
}

String _$packagesLocalDataSourceHash() =>
    r'6ba73a292419fe4820fe4dc9ff1d376745140a5c';
