import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startSplashScreenTimer();
  }

  void _navigateToNextPage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.phoneAuthentication, (Route<dynamic> route) => false);
  }

  _startSplashScreenTimer() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, _navigateToNextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: 100.h,
        width: 100.w,
        child: Center(
          child: _logo(),
        ),
      ),
    );
  }

  Container _logo() {
    return Container(
      height: 45.8.h,
      width: 80.8.w,
      child: SvgPicture.asset(AssetsPath.logoSplash),
    );
  }
}
