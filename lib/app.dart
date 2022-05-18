import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/navigation_service.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/widgets/constrain_center.dart';
import 'package:starfish/wrappers/platform.dart';
import 'package:starfish/wrappers/window.dart';
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
  bool _isInitialized = false;
  String? _initialRoute;
  Locale _locale = Locale('en');

  @override
  void initState() {
    // _locale = Locale('en');
    initContext();
    super.initState();

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..userInteractions = false
      ..dismissOnTap = false
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.blue
      ..textColor = Colors.black45
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..boxShadow = <BoxShadow>[];
  }

  initContext() async {
    final results = await Future.wait([
      StarfishSharedPreference().isUserLoggedIn(),
      StarfishSharedPreference().getDeviceLanguage(),
      // want to show the splash screen for at least 3 seconds on mobile
      Future.delayed(Duration(seconds: Platform.isWeb ? 0 : 3)),
    ]);
    final isSignedIn = results[0] as bool;
    final savedLocale = results[1] as String;
    final deviceLanguage = Platform.localeName.substring(0, 2);
    final locale = (savedLocale == '')
      ? (
        deviceLanguage == 'hi'
          ? deviceLanguage
          : 'en'
      )
      : savedLocale;

    setState(() {
      if (!isSignedIn) {
        _initialRoute = Routes.phoneAuthentication;
      }
      _locale = Locale(locale);
      _isInitialized = true;
      removeSplashScreen();
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final app = _isInitialized
      ? MaterialApp(
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
        // home: SplashScreen(),
        initialRoute: _initialRoute,
        routes: Routes.routes,
        builder: EasyLoading.init(
          builder: (context, widget) {
            ScreenUtil.setContext(context);
            Widget wrapper = MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
            if (Platform.isWeb) {
              ScreenUtil().uiSize = MediaQuery.of(context).size;
              wrapper = ConstrainCenter(child: wrapper);
            }
            return wrapper;
          },
        ),
      )
      : MaterialApp(
        onGenerateRoute: (_) =>
          MaterialPageRoute(
            builder: (_) => Platform.isWeb ? SizedBox.shrink() : SplashScreen(),
          ),
      );

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_) => Provider(
        child: app,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
