import 'package:flutter/material.dart';
import 'package:starfish/constants/text_styles.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitleLabel extends StatelessWidget {
  final String title;
  final TextAlign align;

  TitleLabel({
    Key? key,
    required this.title,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      margin: EdgeInsets.fromLTRB(15.0.w, 0.0, 15.0.w, 0.0),
      child: Text(
        title,
        textAlign: align,
        style: titleTextStyle,
      ),
    );
  }
}