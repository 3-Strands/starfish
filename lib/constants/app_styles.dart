import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static ThemeData defaultTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      //primarySwatch: Colors.orange,
      backgroundColor: AppColors.BACKGROUND_COLOR,
      primaryColor: AppColors.PRIMARY_COLOR,
      primaryColorLight: AppColors.PRIMARY_COLOR,
      primaryColorDark: AppColors.PRIMARY_COLOR,
      accentColor: AppColors.ACCENT_COLOR,

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
              color: AppColors.TEXT_BORDER_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.TEXT_BORDER_COLOR,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.RED_COLOR,
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

      // deprecated with FlatButton
      buttonTheme: ButtonThemeData(
        height: 60.0,
        minWidth: 334.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        textTheme: ButtonTextTheme.normal,
        buttonColor: AppColors.PRIMARY_COLOR,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: AppColors.PRIMARY_COLOR,
        //onPrimary: Colors.grey[300],
        minimumSize: Size(334.0, 60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
      )),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Colors.white,
          minimumSize: Size(334.0, 60.0),
        ),
      ),
    );
  }
}
