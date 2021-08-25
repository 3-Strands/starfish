import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'modules/splash/splash.dart';

class Starfish extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: ThemeData.light(),
          home: SplashScreen(),
        );
      },
    );
  }
}
