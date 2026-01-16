
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../domain/entities/package_entity.dart';
import '../../domain/repositories/packages_repository.dart';
import '../datasources/packages_local_datasource.dart';
import '../datasources/packages_remote_datasource.dart';
import '../models/package_model.dart';

part 'packages_repository_impl.g.dart';

@riverpod
PackagesRepository packagesRepository(Ref ref) {
  return PackagesRepositoryImpl(
    ref.watch(packagesRemoteDataSourceProvider),
    ref.watch(packagesLocalDataSourceProvider),
  );
}

class PackagesRepositoryImpl implements PackagesRepository {
  final PackagesRemoteDataSource _remoteDataSource;
  final PackagesLocalDataSource _localDataSource;

  const PackagesRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<AppException, List<PackageEntity>>> getAvailablePackages({
    int page = 0,
    int pageSize = 20,
  }) async {
    try {
      final packages = await _remoteDataSource.getAvailablePackages(
        page: page,
        pageSize: pageSize,
      );
      return Right(packages);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownException(
        message: 'Failed to fetch packages',
        originalError: e,
      ));
    }
  }

  @override
  Future<Either<AppException, Set<String>>> getDownloadedPackageIds() async {
    try {
      final ids = await _localDataSource.getDownloadedPackageIds();
      return Right(ids);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(StorageException(
        message: 'Failed to get downloaded packages',
        originalError: e,
      ));
    }
  }

  @override
  Stream<Either<AppException, PackageEntity>> downloadPackage(
    PackageEntity package,
  ) async* {
    try {
      final savePath = _localDataSource.getPackageFilePath(package.id);
      
      yield Right(package.copyWith(
        status: PackageStatus.downloading,
        downloadProgress: 0.0,
      ));

      await for (final progress in _remoteDataSource.downloadPackage(
        package.downloadUrl,
        savePath,
        package.id,
      )) {
        if (progress.isComplete) {
          await _localDataSource.addDownloadedPackageId(package.id);
          await _localDataSource.savePackageMetadata(
            PackageModel.fromEntity(package),
          );
          
          yield Right(package.copyWith(
            status: PackageStatus.downloaded,
            downloadProgress: 1.0,
          ));
        } else {
          yield Right(package.copyWith(
            status: PackageStatus.downloading,
            downloadProgress: progress.progress,
          ));
        }
      }
    } on AppException catch (e) {
      yield Left(e);
    } catch (e) {
      yield Left(DownloadException(
        message: 'Failed to download package',
        originalError: e,
      ));
    }
  }

  @override
  Future<Either<AppException, void>> deletePackage(String packageId) async {
    try {
      await _localDataSource.deletePackageFile(packageId);
      return const Right(null);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(StorageException(
        message: 'Failed to delete package',
        originalError: e,
      ));
    }
  }

  @override
  Future<bool> isPackageDownloaded(String packageId) {
    return _localDataSource.isPackageDownloaded(packageId);
  }

  @override
  Future<Either<AppException, String>> getPackageContent(
    String packageId,
  ) async {
    try {
      final content = await _localDataSource.readPackageContent(packageId);
      return Right(content);
    } on AppException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(StorageException(
        message: 'Failed to read package content',
        originalError: e,
      ));
    }
  }

  @override
  Future<void> cancelDownload(String packageId) async {
    _remoteDataSource.cancelDownload(packageId);
  }
}