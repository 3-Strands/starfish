import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/models/tokens.dart';
import 'package:starfish/models/user.dart';
import 'package:starfish/wrappers/platform_storage.dart';

class LocalStorageApi {
  static final String _kUserLoggedIn = "isUserLoggedIn";
  static final String _kIsSyncingFirstTime = "isSyncingFirstTime";
  static final String _kHasBeenRemindedToDeleteFiles = "hasBeenRemindedToDeleteFiles";
  static final String _kAccessToken = "accessToken";
  static final String _kDeviceLanguage = "deviceLanguage";
  static final String _kRefreshToken = "refreshToken";
  static final String _kSessionUserId = "sessionUserId";
  static final String _kUser = "user";
  static final String _kEncryptionKey = "encryptionKey";

  static LocalStorageApi? _instance;

  final PlatformStorage _storage;

  LocalStorageApi._(this._storage);

  factory LocalStorageApi() {
    _instance = _instance ?? LocalStorageApi._(PlatformStorage());
    return _instance!;
  }

  Future<bool> _setLoginStatus(bool value) {
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

  Future<bool> _setAccessToken(String value) {
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

  Future<bool> saveUser(AppUser user) {
    return _storage.setString(_kUser, jsonEncode(user.toJson()));
  }

  Future<AppUser?> getUser() async {
    final userData = await _storage.getString(_kUser);
    if (userData != null) {
      return AppUser.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<bool> clearUser(AppUser user) =>
    _storage.setString(_kUser, '');

  Future<void> saveTokens(Tokens session) async {
    await Future.wait([
      _setLoginStatus(true),
      _setAccessToken(session.accessToken),
      _setRefreshToken(session.refreshToken),
      _setSessionUserId(session.userId),
    ]);
  }

  Future<void> clearTokens() async {
    await Future.wait([
      _setLoginStatus(false),
      _setAccessToken(''),
      _setRefreshToken(''),
      _setSessionUserId(''),
    ]);
  }

  Future<Tokens?> getTokens() async {
    final items = await Future.wait<dynamic>([
      isUserLoggedIn(),
      _getAccessToken(),
      _getRefreshToken(),
      _getSessionUserId(),
    ]);
    final bool isLoggedIn = items[0];
    if (isLoggedIn) {
      return Tokens(
        accessToken: items[1],
        refreshToken: items[2],
        userId: items[3],
      );
    }
    return null;
  }

  Future<String> _getAccessToken() {
    return _storage.getEncryptedString(_kAccessToken);
  }

  Future<String> getDeviceLanguage() {
    return _storage.getEncryptedString(_kDeviceLanguage);
  }

  Future<bool> _setRefreshToken(String value) {
    return _storage.setEncryptedString(_kRefreshToken, value);
  }

  Future<String> _getRefreshToken() {
    return _storage.getEncryptedString(_kRefreshToken);
  }

  Future<bool> _setSessionUserId(String value) {
    return _storage.setEncryptedString(_kSessionUserId, value);
  }

  Future<String> _getSessionUserId() {
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
