
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/network_client.dart';
import '../models/package_model.dart';

// We need to add this import for StreamController
import 'dart:async';

part 'packages_remote_datasource.g.dart';

@riverpod
PackagesRemoteDataSource packagesRemoteDataSource(Ref ref) {
  return PackagesRemoteDataSource(ref.watch(networkClientProvider));
}

class PackagesRemoteDataSource {
  final NetworkClient _networkClient;
  final Map<String, CancelToken> _cancelTokens = {};

  PackagesRemoteDataSource(this._networkClient);

  Future<List<PackageModel>> getAvailablePackages({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _networkClient.get<List<dynamic>>(
      AppConstants.packagesIndexUrl,
      queryParameters: {
        'page': page,
        'page_size': pageSize,
      },
    );

    return response
        .map((json) => PackageModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Stream<DownloadProgress> downloadPackage(
    String downloadUrl,
    String savePath,
    String packageId,
  ) async* {
    final cancelToken = CancelToken();
    _cancelTokens[packageId] = cancelToken;

    try {
      final controller = StreamController<DownloadProgress>();
      
      _networkClient.downloadFile(
        downloadUrl,
        savePath,
        onProgress: (received, total) {
          if (!controller.isClosed) {
            controller.add(DownloadProgress(
              received: received,
              total: total,
              progress: total > 0 ? received / total : 0,
            ));
          }
        },
        cancelToken: cancelToken,
      ).then((_) {
        if (!controller.isClosed) {
          controller.add(DownloadProgress(
            received: 1,
            total: 1,
            progress: 1.0,
            isComplete: true,
          ));
          controller.close();
        }
      }).catchError((error) {
        if (!controller.isClosed) {
          controller.addError(error);
          controller.close();
        }
      });

      yield* controller.stream;
    } finally {
      _cancelTokens.remove(packageId);
    }
  }

  void cancelDownload(String packageId) {
    _cancelTokens[packageId]?.cancel('Download cancelled by user');
    _cancelTokens.remove(packageId);
  }
}

class DownloadProgress {
  final int received;
  final int total;
  final double progress;
  final bool isComplete;

  const DownloadProgress({
    required this.received,
    required this.total,
    required this.progress,
    this.isComplete = false,
  });
}