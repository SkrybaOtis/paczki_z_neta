import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/package_entity.dart';
import '../../domain/usecases/download_package.dart';
import '../../domain/usecases/get_available_packages.dart';
import 'package:hooks/hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


part 'packages_provider.g.dart';

// State classes
class PackagesState {
  final List<PackageEntity> packages;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final String? errorMessage;
  final int currentPage;

  const PackagesState({
    this.packages = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.errorMessage,
    this.currentPage = 0,
  });

  PackagesState copyWith({
    List<PackageEntity>? packages,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    String? errorMessage,
    int? currentPage,
  }) {
    return PackagesState(
      packages: packages ?? this.packages,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      errorMessage: errorMessage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

@riverpod
class PackagesNotifier extends _$PackagesNotifier {
  late GetAvailablePackages _getAvailablePackages;
  late DownloadPackageUseCase _downloadPackageUseCase;
  final Map<String, StreamSubscription> _downloadSubscriptions = {};

  @override
  PackagesState build() {
    _getAvailablePackages = ref.watch(getAvailablePackagesProvider);
    _downloadPackageUseCase = ref.watch(downloadPackageUseCaseProvider);
    
    ref.onDispose(() {
      for (final subscription in _downloadSubscriptions.values) {
        subscription.cancel();
      }
      _downloadSubscriptions.clear();
    });

    // Initial load
    Future.microtask(() => loadPackages());
    
    return const PackagesState(isLoading: true);
  }

  Future<void> loadPackages() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _getAvailablePackages(
      page: 0,
      pageSize: AppConstants.pageSize,
    );

    result.fold(
      (error) => state = state.copyWith(
        isLoading: false,
        errorMessage: error.message,
      ),
      (packages) => state = state.copyWith(
        packages: packages,
        isLoading: false,
        currentPage: 0,
        hasReachedEnd: packages.length < AppConstants.pageSize,
      ),
    );
  }

  Future<void> loadMorePackages() async {
    if (state.isLoadingMore || state.hasReachedEnd) return;

    state = state.copyWith(isLoadingMore: true);

    final nextPage = state.currentPage + 1;
    final result = await _getAvailablePackages(
      page: nextPage,
      pageSize: AppConstants.pageSize,
    );

    result.fold(
      (error) => state = state.copyWith(
        isLoadingMore: false,
        errorMessage: error.message,
      ),
      (newPackages) {
        final allPackages = [...state.packages, ...newPackages];
        state = state.copyWith(
          packages: allPackages,
          isLoadingMore: false,
          currentPage: nextPage,
          hasReachedEnd: newPackages.length < AppConstants.pageSize,
        );
      },
    );
  }

  Future<void> downloadPackage(PackageEntity package) async {
    // Cancel if already downloading
    if (_downloadSubscriptions.containsKey(package.id)) return;

    _updatePackageStatus(
      package.id,
      PackageStatus.downloading,
      progress: 0.0,
    );

    final subscription = _downloadPackageUseCase(package).listen(
      (result) {
        result.fold(
          (error) {
            _updatePackageStatus(
              package.id,
              PackageStatus.error,
              errorMessage: error.message,
            );
            _downloadSubscriptions.remove(package.id);
          },
          (updatedPackage) {
            _updatePackageStatus(
              package.id,
              updatedPackage.status,
              progress: updatedPackage.downloadProgress,
            );
            
            if (updatedPackage.isDownloaded) {
              _downloadSubscriptions.remove(package.id);
            }
          },
        );
      },
      onError: (error) {
        _updatePackageStatus(
          package.id,
          PackageStatus.error,
          errorMessage: error.toString(),
        );
        _downloadSubscriptions.remove(package.id);
      },
    );

    _downloadSubscriptions[package.id] = subscription;
  }

  Future<void> cancelDownload(String packageId) async {
    await _downloadPackageUseCase.cancel(packageId);
    _downloadSubscriptions[packageId]?.cancel();
    _downloadSubscriptions.remove(packageId);
    
    _updatePackageStatus(packageId, PackageStatus.available);
  }

  void _updatePackageStatus(
    String packageId,
    PackageStatus status, {
    double? progress,
    String? errorMessage,
  }) {
    final updatedPackages = state.packages.map((p) {
      if (p.id == packageId) {
        return p.copyWith(
          status: status,
          downloadProgress: progress ?? p.downloadProgress,
          errorMessage: errorMessage,
        );
      }
      return p;
    }).toList();

    state = state.copyWith(packages: updatedPackages);
  }

  Future<void> refresh() async {
    await loadPackages();
  }
}

// Filter providers
enum PackageFilter { all, downloaded, available }

@riverpod
class SelectedFilter extends _$SelectedFilter {
  @override
  PackageFilter build() => PackageFilter.all;

  void setFilter(PackageFilter filter) {
    state = filter;
  }
}

@riverpod
List<PackageEntity> filteredPackages(Ref ref) {
  final packagesState = ref.watch(packagesNotifierProvider);
  final filter = ref.watch(selectedFilterProvider);

  switch (filter) {
    case PackageFilter.all:
      return packagesState.packages;
    case PackageFilter.downloaded:
      return packagesState.packages
          .where((p) => p.status == PackageStatus.downloaded)
          .toList();
    case PackageFilter.available:
      return packagesState.packages
          .where((p) => p.status == PackageStatus.available)
          .toList();
  }
}

// Search provider
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
List<PackageEntity> searchedPackages(Ref ref) {
  final packages = ref.watch(filteredPackagesProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return packages;

  return packages.where((p) {
    return p.name.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query) ||
        p.tags.any((tag) => tag.toLowerCase().contains(query));
  }).toList();
}