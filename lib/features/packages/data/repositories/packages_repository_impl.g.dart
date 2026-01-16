// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(packagesRepository)
final packagesRepositoryProvider = PackagesRepositoryProvider._();

final class PackagesRepositoryProvider
    extends
        $FunctionalProvider<
          PackagesRepository,
          PackagesRepository,
          PackagesRepository
        >
    with $Provider<PackagesRepository> {
  PackagesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packagesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packagesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PackagesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PackagesRepository create(Ref ref) {
    return packagesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackagesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackagesRepository>(value),
    );
  }
}

String _$packagesRepositoryHash() =>
    r'9d1163d88918034015794c83369b4aa7e6ad5853';
