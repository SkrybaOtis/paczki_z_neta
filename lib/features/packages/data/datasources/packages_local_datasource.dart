import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/package_model.dart';

part 'packages_local_datasource.g.dart';

@riverpod
PackagesLocalDataSource packagesLocalDataSource(Ref ref) {
  return PackagesLocalDataSource(ref.watch(localStorageProvider));
}

class PackagesLocalDataSource {
  final LocalStorage _localStorage;

  const PackagesLocalDataSource(this._localStorage);

  Future<Set<String>> getDownloadedPackageIds() async {
    final list = _localStorage.getStringList(
      AppConstants.downloadedPackagesKey,
    );
    return list?.toSet() ?? {};
  }

  Future<void> addDownloadedPackageId(String packageId) async {
    final current = await getDownloadedPackageIds();
    current.add(packageId);
    await _localStorage.setStringList(
      AppConstants.downloadedPackagesKey,
      current.toList(),
    );
  }

  Future<void> removeDownloadedPackageId(String packageId) async {
    final current = await getDownloadedPackageIds();
    current.remove(packageId);
    await _localStorage.setStringList(
      AppConstants.downloadedPackagesKey,
      current.toList(),
    );
  }

  Future<bool> isPackageDownloaded(String packageId) async {
    final downloaded = await getDownloadedPackageIds();
    return downloaded.contains(packageId);
  }

  String getPackageFilePath(String packageId) {
    return _localStorage.getPackageFilePath(packageId);
  }

  Future<bool> packageFileExists(String packageId) {
    return _localStorage.packageFileExists(packageId);
  }

  Future<void> deletePackageFile(String packageId) async {
    await _localStorage.deletePackageFile(packageId);
    await removeDownloadedPackageId(packageId);
  }

  Future<String> readPackageContent(String packageId) {
    return _localStorage.readPackageFile(packageId);
  }

  Future<void> savePackageMetadata(PackageModel package) async {
    final metadataKey = 'package_metadata_${package.id}';
    await _localStorage.setString(metadataKey, jsonEncode(package.toJson()));
  }

  Future<PackageModel?> getPackageMetadata(String packageId) async {
    final metadataKey = 'package_metadata_$packageId';
    final jsonString = _localStorage.getString(metadataKey);
    if (jsonString == null) return null;
    
    try {
      return PackageModel.fromJson(jsonDecode(jsonString));
    } catch (_) {
      return null;
    }
  }
}