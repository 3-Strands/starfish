import 'package:flutter/material.dart';
import 'modules/splash/splash.dart';

class Starfish extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: '',
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}
