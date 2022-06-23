import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'platform_storage_api.dart';

class PlatformStorage implements PlatformStorageApi {
  @override
  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  @override
  Future<String> getEncryptedString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return EncryptedSharedPreferences(prefs: prefs).getString(key);
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<bool> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  @override
  Future<bool> setEncryptedString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return EncryptedSharedPreferences(prefs: prefs).setString(key, value);
  }

  @override
  Future<bool> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }
}
