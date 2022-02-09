import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaterialLinkButton extends StatefulWidget {
  final Icon icon;
  final String text;
  final VoidCallback onButtonTap;
  TextStyle? textStyle;

  MaterialLinkButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onButtonTap,
    this.textStyle,
  }) : super(key: key);

  @override
  _MaterialLinkButtonState createState() => _MaterialLinkButtonState();
}

class _MaterialLinkButtonState extends State<MaterialLinkButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onButtonTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.icon,
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Text(
                widget.text,
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
