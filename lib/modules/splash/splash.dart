import 'dart:async';
import 'package:flutter/material.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/modules/phone_authentication/phone_authentication.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            settings: RouteSettings(name: "/phoneAuthentication"),
            builder: (BuildContext context) => PhoneAuthenticationScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(ImagePath.logoSplash),
          ],
        ),
      ),
    );
  }
}

///A screen to decide the navigation according to the present input
///It stays for 3 seconds and navigates automatically
/*
import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashScreen> {
  void navigateToNextPage() {
    LocalStorageService().isUserLoggedIn().then((onValue) {
      if (onValue) {
        LocalStorageService().isVehicleAssign().then((onValue) {
          onValue
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.dashBoard, (Route<dynamic> route) => false)
              : Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.assignVehicle, (Route<dynamic> route) => false);
        });
      } else {
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ApplicationPage()),
            );
        // Navigator.of(context).pushNamedAndRemoveUntil(
        //     Routes.signin, (Route<dynamic> route) => false);
      }
    });
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
      backgroundColor: AppColors.primary,
      body: Container(
        child: Stack(
          children: <Widget>[
            _buildPositionedLogo(),
            _buildPositionedFader(),
          ],
        ),
      ),
    );
  }

  Positioned _buildPositionedFader() {
    return Positioned(
      top: 56.h,
      left: 0.w,
      right: 0.w,
      child: Image.asset(
        AssetsPath.fader,
      ),
    );
  }

  Positioned _buildPositionedLogo() {
    return Positioned(
      top: 26.h,
      left: 16.w,
      right: 16.w,
      child: Image.asset(
        AssetsPath.logo,
      ),
    );
  }
}
*/