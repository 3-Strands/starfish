import 'package:flutter/material.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:sizer/sizer.dart';

class ItalicitleLabel extends StatelessWidget {
  final String title;
  ItalicitleLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      margin: EdgeInsets.fromLTRB(4.0.w, 0.0, 4.0.w, 0.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: italicDetailTextTextStyle,
      ),
    );
  }
}
