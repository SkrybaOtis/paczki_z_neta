
import 'package:equatable/equatable.dart';

enum PackageStatus {
  available,
  downloading,
  downloaded,
  error,
}

class PackageEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String version;
  final String author;
  final int sizeBytes;
  final String downloadUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<String> tags;
  final PackageStatus status;
  final double downloadProgress;
  final String? errorMessage;

  const PackageEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.version,
    required this.author,
    required this.sizeBytes,
    required this.downloadUrl,
    required this.createdAt,
    this.updatedAt,
    this.tags = const [],
    this.status = PackageStatus.available,
    this.downloadProgress = 0.0,
    this.errorMessage,
  });

  bool get isDownloaded => status == PackageStatus.downloaded;
  bool get isDownloading => status == PackageStatus.downloading;
  bool get hasError => status == PackageStatus.error;

  PackageEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? version,
    String? author,
    int? sizeBytes,
    String? downloadUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    PackageStatus? status,
    double? downloadProgress,
    String? errorMessage,
  }) {
    return PackageEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      version: version ?? this.version,
      author: author ?? this.author,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        version,
        author,
        sizeBytes,
        downloadUrl,
        createdAt,
        updatedAt,
        tags,
        status,
        downloadProgress,
        errorMessage,
      ];
}