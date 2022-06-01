import 'dart:convert';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarfishSharedPreference {
  final String _kUserLoggedIn = "isUserLoggedIn";
  final String _kIsSyncingFirstTime = "isSyncingFirstTime";
  final String _kAccessToken = "accessToken";
  final String _kDeviceLanguage = "deviceLanguage";
  final String _kRefreshToken = "refreshToken";
  final String _kSessionUserId = "sessionUserId";
  final String _kEncryptionKey = "encryptionKey";

  setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kUserLoggedIn, value);
  }

  setIsSyncingFirstTime(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsSyncingFirstTime, value);
  }

  Future<bool> setAccessToken(String value) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.setString(_kAccessToken, value);
  }

  Future<bool> setDeviceLanguage(String value) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.setString(_kDeviceLanguage, value);
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kUserLoggedIn) ?? false;
  }

  Future<bool> isSyncingFirstTimeDone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsSyncingFirstTime) ?? false;
  }

  Future<String> getAccessToken() async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.getString(_kAccessToken);
  }

  Future<String> getDeviceLanguage() async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.getString(_kDeviceLanguage);
  }

  Future<bool> setRefreshToken(String value) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.setString(_kRefreshToken, value);
  }

  Future<String> getRefreshToken() async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.getString(_kRefreshToken);
  }

  Future<bool> setSessionUserId(String value) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.setString(_kSessionUserId, value);
  }

  Future<String> getSessionUserId() async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    return prefs.getString(_kSessionUserId);
  }

  Future<List<int>> getEncryptionKey() async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    String _encryptionKey = await prefs.getString(_kEncryptionKey);
    if (_encryptionKey.isEmpty) {
      final key = Hive.generateSecureKey();
      _encryptionKey = base64UrlEncode(key);
      await prefs.setString(_kEncryptionKey, _encryptionKey);
    }
    return base64Url.decode(_encryptionKey);
  }
}
