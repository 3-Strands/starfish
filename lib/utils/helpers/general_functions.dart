import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';

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
      debugPrint("URL can't be launched.");
    }
  }

  static String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .emptyMobileNumbers;
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .invalidMobileNumbers;
    }
    return '';
  }

  static String validateFullName(String value) {
    String pattern = r"^[\p{L} ,.'-]*$";
    RegExp regExp =
        new RegExp(pattern, caseSensitive: false, unicode: true, dotAll: true);
    if (value.length == 0) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .emptyFullName;
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(
              NavigationService.navigatorKey.currentContext!)!
          .invalidFullName;
    }
    return '';
  }

  static void handleGrpcError(GrpcError grpcError) {
    if (grpcError.code == StatusCode.unauthenticated) {
      StarfishSharedPreference().isUserLoggedIn().then((value) {
        if (value == true) {
          StarfishSharedPreference().setLoginStatus(false);
          StarfishSharedPreference().setAccessToken('');
          StarfishSnackbar.showErrorMessage(
              NavigationService.navigatorKey.currentContext!,
              grpcError.message!);
          Navigator.of(NavigationService.navigatorKey.currentContext!)
              .pushNamedAndRemoveUntil(
                  Routes.phoneAuthentication, (Route<dynamic> route) => false);
        }
      });
    }
  }
}
