
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants/app_constants.dart';
import '../exceptions/app_exceptions.dart';

part 'network_client.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: AppConstants.connectionTimeout,
      receiveTimeout: AppConstants.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return dio;
}

@riverpod
NetworkClient networkClient(Ref ref) {
  return NetworkClient(ref.watch(dioProvider));
}

class NetworkClient {
  final Dio _dio;

  const NetworkClient(this._dio);

  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? parser,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );

      if (parser != null) {
        return parser(response.data);
      }

      return response.data as T;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw UnknownException(originalError: e);
    }
  }

  Future<String> downloadFile(
    String url,
    String savePath, {
    void Function(int, int)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
      );
      return savePath;
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw DownloadException(
        message: 'Failed to download file',
        originalError: e,
      );
    }
  }

  AppException _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout',
          code: 'TIMEOUT',
          originalError: e,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection',
          code: 'NO_CONNECTION',
          originalError: e,
        );
      case DioExceptionType.badResponse:
        return NetworkException(
          message: 'Server error: ${e.response?.statusCode}',
          code: e.response?.statusCode?.toString(),
          originalError: e,
        );
      default:
        return NetworkException(
          message: e.message ?? 'Network error occurred',
          originalError: e,
        );
    }
  }
}