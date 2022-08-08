import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';

class SeparatorLine extends StatelessWidget {
  final double? height;
  final EdgeInsets? padding;

  const SeparatorLine({
    Key? key,
    this.height,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1.h,
      margin: padding,
      color: AppColors.separatorLineColor,
    );
  }
}
