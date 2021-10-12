import 'package:shared_preferences/shared_preferences.dart';

class StarfishSharedPreference {
  final String _kUserLoggedIn = "isUserLoggedIn";
  final String _kAccessToken = "accessToken";

  setLoginStatus(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_kUserLoggedIn, value);
  }

  setAccessToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_kAccessToken, value);
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kUserLoggedIn) ?? false;
  }

  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kAccessToken) ?? '';
  }
}
