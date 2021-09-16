import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';

class SepratorLine extends StatelessWidget {
  final double hight;
  final EdgeInsets edgeInsets;

  SepratorLine({
    Key? key,
    required this.hight,
    required this.edgeInsets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: hight, margin: edgeInsets, color: AppColors.sepratorLineColor);
  }
}
