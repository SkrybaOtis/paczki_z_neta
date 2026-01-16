
import 'package:fpdart/fpdart.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../entities/package_entity.dart';

abstract interface class PackagesRepository {
  /// Fetches the list of available packages from remote server
  Future<Either<AppException, List<PackageEntity>>> getAvailablePackages({
    int page = 0,
    int pageSize = 20,
  });

  /// Gets the list of downloaded package IDs
  Future<Either<AppException, Set<String>>> getDownloadedPackageIds();

  /// Downloads a package by its ID
  Stream<Either<AppException, PackageEntity>> downloadPackage(
    PackageEntity package,
  );

  /// Deletes a downloaded package
  Future<Either<AppException, void>> deletePackage(String packageId);

  /// Checks if a package is downloaded
  Future<bool> isPackageDownloaded(String packageId);

  /// Gets package content (for downloaded packages)
  Future<Either<AppException, String>> getPackageContent(String packageId);

  /// Cancels ongoing download
  Future<void> cancelDownload(String packageId);
}