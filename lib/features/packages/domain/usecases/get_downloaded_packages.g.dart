// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_downloaded_packages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getDownloadedPackages)
final getDownloadedPackagesProvider = GetDownloadedPackagesProvider._();

final class GetDownloadedPackagesProvider
    extends
        $FunctionalProvider<
          GetDownloadedPackages,
          GetDownloadedPackages,
          GetDownloadedPackages
        >
    with $Provider<GetDownloadedPackages> {
  GetDownloadedPackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDownloadedPackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDownloadedPackagesHash();

  @$internal
  @override
  $ProviderElement<GetDownloadedPackages> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDownloadedPackages create(Ref ref) {
    return getDownloadedPackages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDownloadedPackages value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDownloadedPackages>(value),
    );
  }
}

String _$getDownloadedPackagesHash() =>
    r'856a4bead34f0a58013ab95da736fd32320de522';
