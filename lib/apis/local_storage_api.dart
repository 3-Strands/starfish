import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/wrappers/platform_storage.dart';

class LocalStorageApi {
  static final String _kUserLoggedIn = "isUserLoggedIn";
  static final String _kIsSyncingFirstTime = "isSyncingFirstTime";
  static final String _kHasBeenRemindedToDeleteFiles = "hasBeenRemindedToDeleteFiles";
  static final String _kAccessToken = "accessToken";
  static final String _kDeviceLanguage = "deviceLanguage";
  static final String _kRefreshToken = "refreshToken";
  static final String _kSessionUserId = "sessionUserId";
  static final String _kEncryptionKey = "encryptionKey";

  static LocalStorageApi? _instance;

  final PlatformStorage _storage;

  LocalStorageApi._(this._storage);

  factory LocalStorageApi() {
    _instance = _instance ?? LocalStorageApi._(PlatformStorage());
    return _instance!;
  }

  Future<bool> setLoginStatus(bool value) {
    return _storage.setBool(_kUserLoggedIn, value);
  }

  Future<bool> setIsSyncingFirstTime(bool value) {
    return _storage.setBool(_kIsSyncingFirstTime, value);
  }

  Future<bool> setHasBeenRemindedToDeleteFiles() {
    return _storage.setBool(_kHasBeenRemindedToDeleteFiles, true);
  }

  Future<bool> hasBeenRemindedToDeleteFiles() async {
    return (await _storage.getBool(_kHasBeenRemindedToDeleteFiles)) ?? false;
  }

  Future<bool> setAccessToken(String value) {
    return _storage.setEncryptedString(_kAccessToken, value);
  }

  Future<bool> setDeviceLanguage(String value) {
    return _storage.setEncryptedString(_kDeviceLanguage, value);
  }

  Future<bool> isUserLoggedIn() async {
    return (await _storage.getBool(_kUserLoggedIn)) ?? false;
  }

  Future<bool> isSyncingFirstTimeDone() async {
    return (await _storage.getBool(_kIsSyncingFirstTime)) ?? false;
  }

  Future<String> getAccessToken() {
    return _storage.getEncryptedString(_kAccessToken);
  }

  Future<String> getDeviceLanguage() {
    return _storage.getEncryptedString(_kDeviceLanguage);
  }

  Future<bool> setRefreshToken(String value) {
    return _storage.setEncryptedString(_kRefreshToken, value);
  }

  Future<String> getRefreshToken() {
    return _storage.getEncryptedString(_kRefreshToken);
  }

  Future<bool> setSessionUserId(String value) {
    return _storage.setEncryptedString(_kSessionUserId, value);
  }

  Future<String> getSessionUserId() {
    return _storage.getEncryptedString(_kSessionUserId);
  }

  Future<List<int>> getEncryptionKey() async {
    String _encryptionKey = await _storage.getEncryptedString(_kEncryptionKey);
    if (_encryptionKey.isEmpty) {
      final key = Hive.generateSecureKey();
      _encryptionKey = base64UrlEncode(key);
      await _storage.setEncryptedString(_kEncryptionKey, _encryptionKey);
    }
    return base64Url.decode(_encryptionKey);
  }
}
