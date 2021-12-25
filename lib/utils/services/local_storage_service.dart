import 'package:shared_preferences/shared_preferences.dart';

class StarfishSharedPreference {
  final String _kUserLoggedIn = "isUserLoggedIn";
  final String _kAccessToken = "accessToken";
  final String _kDeviceLanguage = "deviceLanguage";

  setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kUserLoggedIn, value);
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

  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAccessToken) ?? '';
  }

  Future<String> getDeviceLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kDeviceLanguage) ?? '';
  }
}
