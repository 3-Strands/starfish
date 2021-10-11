import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:starfish/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralFunctions {
  static void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  Future<bool> isNetworkAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static openUrl(String url) async {
    if (!url.contains('http')) url = 'https://$url';
    var urlLaunchable =
        await canLaunch(url); //canLaunch is from url_launcher package
    if (urlLaunchable) {
      await launch(url); //launch is from url_launcher package to launch URL
    } else {
      print("URL can't be launched.");
    }
  }

  static String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return Strings.emptyMobileNumbers;
    } else if (!regExp.hasMatch(value)) {
      return Strings.invalidMobileNumbers;
    }
    return '';
  }

  static String validateFullName(String value) {
    String pattern = r"^[\p{L} ,.'-]*$";
    RegExp regExp =
        new RegExp(pattern, caseSensitive: false, unicode: true, dotAll: true);
    if (value.length == 0) {
      return Strings.emptyFullName;
    } else if (!regExp.hasMatch(value)) {
      return Strings.invalidFullName;
    }
    return '';
  }
}
