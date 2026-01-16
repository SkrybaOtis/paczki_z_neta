
import '../../domain/entities/package_entity.dart';

class PackageModel extends PackageEntity {
  const PackageModel({
    required super.id,
    required super.name,
    required super.description,
    required super.version,
    required super.author,
    required super.sizeBytes,
    required super.downloadUrl,
    required super.createdAt,
    super.updatedAt,
    super.tags,
    super.status,
    super.downloadProgress,
    super.errorMessage,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      version: json['version'] as String? ?? '1.0.0',
      author: json['author'] as String? ?? 'Unknown',
      sizeBytes: json['size_bytes'] as int? ?? 0,
      downloadUrl: json['download_url'] as String,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ?? 
          DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at'] as String) 
          : null,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'version': version,
      'author': author,
      'size_bytes': sizeBytes,
      'download_url': downloadUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'tags': tags,
    };
  }

  factory PackageModel.fromEntity(PackageEntity entity) {
    return PackageModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      version: entity.version,
      author: entity.author,
      sizeBytes: entity.sizeBytes,
      downloadUrl: entity.downloadUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      tags: entity.tags,
      status: entity.status,
      downloadProgress: entity.downloadProgress,
      errorMessage: entity.errorMessage,
    );
  }
}