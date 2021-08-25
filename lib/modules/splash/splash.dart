///A screen to decide the navigation according to the present input
///It stays for 3 seconds and navigates automatically

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashScreen> {
  void navigateToNextPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.phoneAuthentication, (Route<dynamic> route) => false);
  }

  startSplashScreenTimer() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigateToNextPage);
  }

  @override
  void initState() {
    super.initState();
    startSplashScreenTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildPositionedLogo(),
          ],
        ),
      ),
    );
  }

  Positioned _buildPositionedLogo() {
    return Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImagePath.logoSplash,
          ),
        ));
  }
}
