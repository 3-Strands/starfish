import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static ThemeData defaultTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      backgroundColor: AppColors.background,
      primaryColor: AppColors.selectedButtonBG,
      // primaryColorLight: AppColors.selectedButtonBG,
      // primaryColorDark: AppColors.selectedButtonBG,
      accentColor: AppColors.selectedButtonBG,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(20),
        hintStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: "OpenSans",
            fontStyle: FontStyle.normal,
            color: AppColors.txtFieldTextColor,
            fontSize: 18.0),
        errorStyle: TextStyle(
          color: Colors.red,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.background,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.background,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.background,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),
    );
  }
}
