// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_available_packages.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getAvailablePackages)
final getAvailablePackagesProvider = GetAvailablePackagesProvider._();

final class GetAvailablePackagesProvider
    extends
        $FunctionalProvider<
          GetAvailablePackages,
          GetAvailablePackages,
          GetAvailablePackages
        >
    with $Provider<GetAvailablePackages> {
  GetAvailablePackagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAvailablePackagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAvailablePackagesHash();

  @$internal
  @override
  $ProviderElement<GetAvailablePackages> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAvailablePackages create(Ref ref) {
    return getAvailablePackages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAvailablePackages value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAvailablePackages>(value),
    );
  }
}

String _$getAvailablePackagesHash() =>
    r'230b1429e47b47ae02505b3674bdabb117d14db2';
