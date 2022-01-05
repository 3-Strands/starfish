import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class TaskStatus extends StatelessWidget {
  final Color color;
  final String label;

  double height = 15;
  double borderRadius = 15;

  TextStyle? textStyle;

  TaskStatus({
    Key? key,
    required this.color,
    required this.label,
    this.height = 15,
    this.borderRadius = 15,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      margin: EdgeInsets.only(left: 5.0.w, right: 15.0.w),
      height: height,
      child: Center(
          child: Text(
        label,
        style: textStyle ??
            TextStyle(
              fontSize: 11.sp,
              fontFamily: "Rubik",
              color: Colors.black,
            ),
      )),
    );
  }
}
