import 'platform_storage_api.dart';

class PlatformStorage implements PlatformStorageApi {
  @override
  Future<bool?> getBool(String key) {
    throw UnimplementedError();
  }

  @override
  Future<String> getEncryptedString(String key) {
    throw UnimplementedError();
  }

  @override
  Future<String?> getString(String key) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setBool(String key, bool value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setEncryptedString(String key, String value) {
    throw UnimplementedError();
  }

  @override
  Future<bool> setString(String key, String value) {
    throw UnimplementedError();
  }
}
