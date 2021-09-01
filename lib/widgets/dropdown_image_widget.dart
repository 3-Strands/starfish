import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/assets_path.dart';

class DropDownImage extends StatelessWidget {
  final double hight;
  final double width;

  DropDownImage({
    Key? key,
    required this.hight,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsPath.dropdownIcon);
  }
}
