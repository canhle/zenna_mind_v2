import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_service.g.dart';

@Riverpod(keepAlive: true)
StorageService storageService(Ref ref) => StorageService();

class StorageKeys {
  const StorageKeys._();

  // Secure storage
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';

  // SharedPreferences
  static const String themeMode = 'theme_mode';
  static const String locale = 'locale';
}

class StorageService {
  final _prefs = SharedPreferencesAsync();
  final _secureStorage = const FlutterSecureStorage();

  // ── SharedPreferences (non-sensitive) ──────────────────────────────────

  Future<String?> getString(String key) => _prefs.getString(key);

  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  Future<int?> getInt(String key) => _prefs.getInt(key);

  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);

  Future<bool?> getBool(String key) => _prefs.getBool(key);

  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);

  Future<void> remove(String key) => _prefs.remove(key);

  Future<void> clearPrefs() => _prefs.clear();

  // ── Secure Storage (tokens, credentials) ───────────────────────────────

  Future<String?> getSecure(String key) => _secureStorage.read(key: key);

  Future<void> setSecure(String key, String value) =>
      _secureStorage.write(key: key, value: value);

  Future<void> removeSecure(String key) => _secureStorage.delete(key: key);

  Future<void> clearSecure() => _secureStorage.deleteAll();
}
