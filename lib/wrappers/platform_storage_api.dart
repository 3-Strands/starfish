abstract class PlatformStorageApi {
  Future<bool?> getBool(String key);
  Future<bool> setBool(String key, bool value);
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);
  Future<String> getEncryptedString(String key);
  Future<bool> setEncryptedString(String key, String value);
}
