import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';

class AppThemeDataFactory {
  static ThemeData prepareThemeData() => ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
       // accentColor: AppColors.primary,
        backgroundColor: AppColors.background,
        buttonColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
   canvasColor: Colors.transparent,


        iconTheme: IconThemeData(
          color: AppColors.primary,
        ),
        fontFamily: "OpenSans",
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
          subtitle2: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
          subtitle1: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
          bodyText2: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      );
}
