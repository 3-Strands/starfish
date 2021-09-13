import 'dart:ui';
import 'package:flutter/material.dart';
import 'hex_color.dart';

class AppColors {
  static Color primary =Color(0xFF434141);
  static Color background = Color(0xFFFFFFFF);
  static Color txtFieldBackground = Color(0xFFEFEFEF);

  static Color appTitle = Color(0xFF4F4F4F);
  static Color txtFieldTextColor = HexColor('#434141');
  static Color selectedButtonBG = HexColor('#3475F0');
  static Color unselectedButtonBG = HexColor('#ADADAD');

  static Color materialSceenBG = HexColor('#D7E4FC');
  static Color groupScreenBG = HexColor('#F7E8CC');
  static Color actionScreenBG = HexColor('#E2CDE4');

  static Color materialTabBarTextColor = HexColor('#3475F0');
  static Color groupTabBarTextColor = HexColor('#D78A00');
  static Color actionTabBarTextColor = HexColor('#800080');

  static Color completeTaskBGColor = HexColor('#6DE26B');
  static Color assignedTaskBGColor = HexColor('#CBE8FA');
  static Color overdueTaskBGColor = HexColor('#FF5E4D');
  static Color notCompletedTaskBGColor = HexColor('#FFBE4A');
}
