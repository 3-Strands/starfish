import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/wrappers/platform.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/wrappers/file_system.dart' as fs;

class NetworkUnavailableException implements Exception {
  String toString() => "NetworkUnavailableException";
}

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

  static Future<bool> isNetworkAvailable() async {
    ConnectivityResult _connectivityResult =
        await (Connectivity().checkConnectivity());

    if (_connectivityResult == ConnectivityResult.mobile ||
        _connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.ethernet) {
      return true;
    } else {
      // _connectivityResult == ConnectivityResult.none
      return false;
    }
  }

  static Future<void> openFile(FileReference file, BuildContext context) async {
    if (file.filepath != null) {
      await fs.openFile(file.filepath!);
    } else {
      if (!(await isNetworkAvailable())) {
        throw NetworkUnavailableException();
      }
      EasyLoading.show();
      try {
        await context
            .read<AuthenticationRepository>()
            .makeAuthenticatedFileTransferRequest(
              (client) => fs.downloadMaterial(file, client),
            );
        file.save();
        await fs.openFile(file.filepath!);
      } finally {
        EasyLoading.dismiss();
      }
    }

    if (Platform.isWeb &&
        !(await StarfishSharedPreference().hasBeenRemindedToDeleteFiles())) {
      final l18n = AppLocalizations.of(context)!;
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            l18n.warning,
            style: TextStyle(color: const Color(0xFF030303)),
          ),
          content: Text(l18n.rememberToRemoveDownloadedFiles),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(l18n.close),
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
      StarfishSharedPreference().setHasBeenRemindedToDeleteFiles();
    }
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
}
