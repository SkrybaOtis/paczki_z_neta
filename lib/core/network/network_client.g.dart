// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'885bbf55052d70b88b61344f4eef53e05daf79bf';

@ProviderFor(networkClient)
final networkClientProvider = NetworkClientProvider._();

final class NetworkClientProvider
    extends $FunctionalProvider<NetworkClient, NetworkClient, NetworkClient>
    with $Provider<NetworkClient> {
  NetworkClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkClientHash();

  @$internal
  @override
  $ProviderElement<NetworkClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkClient create(Ref ref) {
    return networkClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkClient>(value),
    );
  }
}

String _$networkClientHash() => r'dc1819503eee52903f9f1428728f656c6f3a5383';
