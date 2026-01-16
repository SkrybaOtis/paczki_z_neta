// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_package.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(downloadPackageUseCase)
final downloadPackageUseCaseProvider = DownloadPackageUseCaseProvider._();

final class DownloadPackageUseCaseProvider
    extends
        $FunctionalProvider<
          DownloadPackageUseCase,
          DownloadPackageUseCase,
          DownloadPackageUseCase
        >
    with $Provider<DownloadPackageUseCase> {
  DownloadPackageUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadPackageUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadPackageUseCaseHash();

  @$internal
  @override
  $ProviderElement<DownloadPackageUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DownloadPackageUseCase create(Ref ref) {
    return downloadPackageUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadPackageUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadPackageUseCase>(value),
    );
  }
}

String _$downloadPackageUseCaseHash() =>
    r'b6ab71bbcce43320a88ebda15b5c2fe91859f8ff';
