
import 'package:equatable/equatable.dart';

sealed class AppException extends Equatable implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  List<Object?> get props => [message, code];
}

final class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}

final class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.originalError,
  });
}

final class DownloadException extends AppException {
  const DownloadException({
    required super.message,
    super.code,
    super.originalError,
  });
}

final class ParseException extends AppException {
  const ParseException({
    required super.message,
    super.code,
    super.originalError,
  });
}

final class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unknown error occurred',
    super.code,
    super.originalError,
  });
}