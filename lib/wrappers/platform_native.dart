import 'dart:io' as io show Platform;

class Platform {
  static const isNative = true;
  static const isWeb = false;
  static get isAndroid => io.Platform.isAndroid;
  static get isIOS => io.Platform.isIOS;
  static get localeName => io.Platform.localeName;
}
