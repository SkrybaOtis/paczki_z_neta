
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../entities/package_entity.dart';
import '../repositories/packages_repository.dart';
import '../../data/repositories/packages_repository_impl.dart';

part 'get_available_packages.g.dart';

@riverpod
GetAvailablePackages getAvailablePackages(Ref ref) {
  return GetAvailablePackages(ref.watch(packagesRepositoryProvider));
}

class GetAvailablePackages {
  final PackagesRepository _repository;

  const GetAvailablePackages(this._repository);

  Future<Either<AppException, List<PackageEntity>>> call({
    int page = 0,
    int pageSize = 20,
  }) async {
    final packagesResult = await _repository.getAvailablePackages(
      page: page,
      pageSize: pageSize,
    );

    return packagesResult.fold(
      (error) => Left(error),
      (packages) async {
        final downloadedIdsResult = await _repository.getDownloadedPackageIds();
        
        return downloadedIdsResult.fold(
          (error) => Right(packages), // Return packages without status if error
          (downloadedIds) {
            final packagesWithStatus = packages.map((package) {
              if (downloadedIds.contains(package.id)) {
                return package.copyWith(status: PackageStatus.downloaded);
              }
              return package;
            }).toList();
            
            return Right(packagesWithStatus);
          },
        );
      },
    );
  }
}