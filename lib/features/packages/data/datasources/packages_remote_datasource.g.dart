// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_remote_datasource.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(packagesRemoteDataSource)
final packagesRemoteDataSourceProvider = PackagesRemoteDataSourceProvider._();

final class PackagesRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PackagesRemoteDataSource,
          PackagesRemoteDataSource,
          PackagesRemoteDataSource
        >
    with $Provider<PackagesRemoteDataSource> {
  PackagesRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packagesRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packagesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PackagesRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PackagesRemoteDataSource create(Ref ref) {
    return packagesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackagesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackagesRemoteDataSource>(value),
    );
  }
}

String _$packagesRemoteDataSourceHash() =>
    r'e3b2c5530106e4510c39e227af9a938e3b85006d';
