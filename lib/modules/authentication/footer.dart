import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({ Key? key, required this.child, this.height }) : super(key: key);

  final double? height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: AppColors.txtFieldBackground,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: SizedBox(
          width: 319.w,
          height: 37.h,
          child: child,
        ),
      ),
    );
  }
}
