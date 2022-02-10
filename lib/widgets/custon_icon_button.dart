import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatefulWidget {
  final double minWidth = 55;
  final double minHeight = 44;
  final Icon icon;
  final String text;
  final VoidCallback onButtonTap;
  TextStyle? textStyle;
  double? width;
  double? height;

  CustomIconButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onButtonTap,
    this.textStyle,
    this.width,
    this.height,
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
        //width: widget.width ?? widget.minWidth,
        //height: widget.height ?? widget.minHeight,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            widget.icon,
            SizedBox(width: 8.w,),
            Text(
              widget.text,
              style: widget.textStyle ??
                  TextStyle(
                    fontSize: 17.sp,
                    color: Colors.blue,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
