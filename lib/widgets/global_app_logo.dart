import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/constants/text_styles.dart';

class GlobalWidgets {
  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget logo(BuildContext context) {
    return Container(
      height: 19.h,
      width: 43.h,
      child: SvgPicture.asset(AssetsPath.logoStarfish),
    );
  }

  static Widget navigationLogo(BuildContext context) {
    return Container(
      height: 4.4.h,
      width: 9.6.h,
      child: SvgPicture.asset(AssetsPath.logoStarfish),
    );
  }

  static Widget title(BuildContext context, String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: titleTextStyle,
    );
  }

  static Widget italicDetailText(BuildContext context, String title) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: italicDetailTextTextStyle,
    );
  }
}
