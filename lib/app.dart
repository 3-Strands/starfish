import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/bloc/provider.dart';
import 'package:starfish/navigation_service.dart';
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
}

class _StarfishState extends State<Starfish> {
  @override
  void initState() {
    SyncService().syncAll();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => Provider(
        child: MaterialApp(
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
