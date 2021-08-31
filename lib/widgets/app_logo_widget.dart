import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/assets_path.dart';

class AppLogo extends StatelessWidget {
  final double hight;
  final double width;

  AppLogo({
    Key? key,
    required this.hight,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      child: Center(
        child: SvgPicture.asset(AssetsPath.logoStarfish),
      ),
    );
  }
}
