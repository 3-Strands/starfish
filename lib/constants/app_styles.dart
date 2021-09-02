import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static ThemeData defaultTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      backgroundColor: AppColors.background,
      primaryColor: AppColors.background,
      // primaryColorLight: AppColors.ACCENT_COLOR,
      // primaryColorDark: AppColors.ACCENT_COLOR,
      // accentColor: AppColors.ACCENT_COLOR,

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(20),
        hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontWeight: FontWeight.normal,
            fontFamily: "HelveticaNeue",
            fontStyle: FontStyle.normal,
            fontSize: 18.0),
        labelStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: "HelveticaNeue",
            fontStyle: FontStyle.normal,
            fontSize: 18.0),
        errorStyle: TextStyle(
          color: Colors.red,
          fontFamily: "HelveticaNeue",
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
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
          minimumSize: Size(334.0, 60.0),
        ),
      ),
    );
  }
}
