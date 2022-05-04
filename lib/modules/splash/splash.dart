import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
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
