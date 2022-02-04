import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'config/routes/routes.dart';
import 'constants/app_styles.dart';
import 'l10n/l10n.dart';
import 'modules/splash/splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Starfish extends StatefulWidget {
  @override
  _StarfishState createState() => _StarfishState();
  static _StarfishState? of(BuildContext context) =>
      context.findAncestorStateOfType<_StarfishState>();
}

class _StarfishState extends State<Starfish> {
  Locale _locale = Locale('en');

  @override
  void initState() {
    // _locale = Locale('en');
    initDeviceLanguage();
    super.initState();

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..userInteractions = false
      ..dismissOnTap = false
      ..backgroundColor = Colors.blue.shade300
      ..indicatorColor = Colors.grey.shade200
      ..textColor = Colors.black45
      ..maskColor = Colors.blue.withOpacity(0.5);
  }

  initDeviceLanguage() async {
    String deviceLanguage = Platform.localeName.substring(0, 2);
    await StarfishSharedPreference().getDeviceLanguage().then((value) => {
          (value == '')
              ? {
                  (deviceLanguage == 'hi')
                      ? setLocale(Locale(deviceLanguage))
                      : setLocale(Locale('en'))
                }
              : setLocale(Locale(value))
        });
  }

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Provider(
        child: MaterialApp(
          locale: _locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          navigatorKey: NavigationService.navigatorKey, // set property
          debugShowCheckedModeBanner: false,
          title: '',
          theme: AppStyles.defaultTheme(),
          home: SplashScreen(),
          routes: Routes.routes,
          builder: EasyLoading.init(
            builder: (context, widget) {
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
