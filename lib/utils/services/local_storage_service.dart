import 'package:shared_preferences/shared_preferences.dart';

class StarfishSharedPreference {
  final String _kUserLoggedIn = "isUserLoggedIn";
  final String _kIsSyncingFirstTime = "isSyncingFirstTime";
  final String _kAccessToken = "accessToken";
  final String _kDeviceLanguage = "deviceLanguage";
  final String _kRefreshToken = "refreshToken";
  final String _kSessionUserId = "sessionUserId";

  setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kUserLoggedIn, value);
  }

  setIsSyncingFirstTime(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsSyncingFirstTime, value);
  }

  setAccessToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kAccessToken, value);
  }

  setDeviceLanguage(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDeviceLanguage, value);
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAccessToken) ?? '';
  }

  Future<String> getDeviceLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kDeviceLanguage) ?? '';
  }

  setRefreshToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kRefreshToken, value);
  }

  Future<String> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kRefreshToken) ?? '';
  }

  setSessionUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kSessionUserId, value);
  }

  Future<String> getSessionUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kSessionUserId) ?? '';
  }
}
