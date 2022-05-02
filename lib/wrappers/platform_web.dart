import 'dart:html' show window;

class Platform {
  static const isNative = false;
  static const isWeb = true;
  static const isAndroid = false;
  static const isIOS = false;
  static get localeName => window.navigator.language;
}
