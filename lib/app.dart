import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';
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
  late Locale _locale;

  @override
  void initState() {
    _locale = Locale('en');
    initDeviceLanguage();
    SyncService().syncAll();
    super.initState();
  }

  initDeviceLanguage() async {
    await StarfishSharedPreference().getDeviceLanguage().then((value) =>
        {(value == '') ? setLocale(Locale('en')) : setLocale(Locale(value))});
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
            routes: Routes.routes),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
