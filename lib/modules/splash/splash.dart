import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashScreen> {
  bool isUserLogin = false;

  @override
  void initState() {
    super.initState();
    _isAlreadyLoggedIn();
    _startSplashScreenTimer();
  }

  void _isAlreadyLoggedIn() async {
    final bool status = await StarfishSharedPreference().isUserLoggedIn();
    setState(() {
      isUserLogin = false;
    });
  }

  void _navigateToNextPage() {
    if (isUserLogin) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.phoneAuthentication, (Route<dynamic> route) => false);
    }
  }

  _startSplashScreenTimer() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, _navigateToNextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: _logo(),
      ),
    );
  }

  Container _logo() {
    return Container(
      width: 303.w,
      height: 372.h,
      child: SvgPicture.asset(AssetsPath.logoSplash),
    );
  }
}
