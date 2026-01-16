import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../entities/package_entity.dart';
import '../repositories/packages_repository.dart';
import '../../data/repositories/packages_repository_impl.dart';

part 'download_package.g.dart';

@riverpod
DownloadPackageUseCase downloadPackageUseCase(Ref ref) {
  return DownloadPackageUseCase(ref.watch(packagesRepositoryProvider));
}

class DownloadPackageUseCase {
  final PackagesRepository _repository;

  const DownloadPackageUseCase(this._repository);

  Stream<Either<AppException, PackageEntity>> call(PackageEntity package) {
    return _repository.downloadPackage(package);
  }

  Future<void> cancel(String packageId) {
    return _repository.cancelDownload(packageId);
  }
}