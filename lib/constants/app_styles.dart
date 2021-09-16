import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppStyles {
  static ThemeData defaultTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      appBarTheme: AppBarTheme().copyWith(
        elevation: 0,
        color: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      primaryColor: AppColors.selectedButtonBG,
      // primaryColorLight: AppColors.selectedButtonBG,
      // primaryColorDark: AppColors.selectedButtonBG,
      accentColor: AppColors.selectedButtonBG,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
            borderRadius: BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.background,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.background,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColors.unselectedButtonBG,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(40.0),
          ),
          textStyle: TextStyle(
            inherit: true,
            fontFamily: 'OpenSans',
            fontSize: ScreenUtil().setSp(21),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
