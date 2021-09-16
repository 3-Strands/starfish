import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/strings.dart';

class CustomIconButton extends StatefulWidget {
  final Icon icon;
  final String text;
  final VoidCallback onButtonTap;
  TextStyle? textStyle;

  CustomIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onButtonTap,
    this.textStyle,
  }) : super(key: key);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onButtonTap();
      },
      child: Container(
        width: 55.w,
        height: 44.h,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.icon,
            Text(
              widget.text,
              style: widget.textStyle ??
                  TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
