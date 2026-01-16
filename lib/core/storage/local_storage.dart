
import 'dart:convert';
import 'dart:io';


import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/app_exceptions.dart';

part 'local_storage.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) async {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
Future<Directory> packagesDirectory(Ref ref) async {
  final appDir = await getApplicationDocumentsDirectory();
  final packagesDir = Directory('${appDir.path}/packages');
  
  if (!await packagesDir.exists()) {
    await packagesDir.create(recursive: true);
  }
  
  return packagesDir;
}

@riverpod
LocalStorage localStorage(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider).value;
  final packagesDir = ref.watch(packagesDirectoryProvider).value;
  
  if (prefs == null || packagesDir == null) {
    throw const StorageException(message: 'Storage not initialized');
  }
  
  return LocalStorage(prefs, packagesDir);
}

class LocalStorage {
  final SharedPreferences _prefs;
  final Directory _packagesDirectory;

  const LocalStorage(this._prefs, this._packagesDirectory);

  // String operations
  Future<bool> setString(String key, String value) async {
    try {
      return await _prefs.setString(key, value);
    } catch (e) {
      throw StorageException(
        message: 'Failed to save string',
        originalError: e,
      );
    }
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // List operations
  Future<bool> setStringList(String key, List<String> value) async {
    try {
      return await _prefs.setStringList(key, value);
    } catch (e) {
      throw StorageException(
        message: 'Failed to save list',
        originalError: e,
      );
    }
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // JSON operations
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    try {
      final jsonString = jsonEncode(value);
      return await _prefs.setString(key, jsonString);
    } catch (e) {
      throw StorageException(
        message: 'Failed to save JSON',
        originalError: e,
      );
    }
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // File operations
  String getPackageFilePath(String packageId) {
    return '${_packagesDirectory.path}/$packageId.json';
  }

  Future<bool> packageFileExists(String packageId) async {
    final file = File(getPackageFilePath(packageId));
    return file.exists();
  }

  Future<void> deletePackageFile(String packageId) async {
    try {
      final file = File(getPackageFilePath(packageId));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw StorageException(
        message: 'Failed to delete package file',
        originalError: e,
      );
    }
  }

  Future<String> readPackageFile(String packageId) async {
    try {
      final file = File(getPackageFilePath(packageId));
      return await file.readAsString();
    } catch (e) {
      throw StorageException(
        message: 'Failed to read package file',
        originalError: e,
      );
    }
  }

  // Remove key
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }
}