import 'package:flutter/material.dart';
import 'package:starfish/constants/text_styles.dart';

class ItalicitleLabel extends StatelessWidget {
  final String title;
  ItalicitleLabel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: italicDetailTextTextStyle,
    );
  }
}
