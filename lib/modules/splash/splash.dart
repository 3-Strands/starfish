import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Container(
          width: 303.w,
          height: 372.h,
          child: SvgPicture.asset(AssetsPath.logoSplash),
        ),
      ),
    );
  }
}
