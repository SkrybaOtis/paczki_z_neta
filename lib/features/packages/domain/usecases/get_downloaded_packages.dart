import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../repositories/packages_repository.dart';
import '../../data/repositories/packages_repository_impl.dart';

part 'get_downloaded_packages.g.dart';

@riverpod
GetDownloadedPackages getDownloadedPackages(Ref ref) {
  return GetDownloadedPackages(ref.watch(packagesRepositoryProvider));
}

class GetDownloadedPackages {
  final PackagesRepository _repository;

  const GetDownloadedPackages(this._repository);

  Future<Either<AppException, Set<String>>> call() {
    return _repository.getDownloadedPackageIds();
  }
}