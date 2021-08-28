import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/global_app_logo.dart';
import 'package:starfish/constants/text_styles.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _nameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: 100.0.h,
              width: 100.0.w,
              color: AppColors.background,
              child: Container(
                padding: EdgeInsets.fromLTRB(4.0.w, 14.5.h, 4.0.w, 4.0.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      GlobalWidgets.logo(context),
                      SizedBox(height: 8.8.h),
                      _nameTextFieldContainer(),
                      _selectCountryContainer(),
                      _selectLanguagesContainer(),
                    ],
                  ),
                ),
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Container _nameTextFieldContainer() {
    return Container(
      width: MediaQuery.of(context).size.width - 60.0,
      height: 170.0,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GlobalWidgets.title(context, Strings.enterName),
          SizedBox(height: 10.0),
          _getNameField(),
          SizedBox(height: 10.0),
          GlobalWidgets.italicDetailText(context, Strings.enterNameDetail),
        ],
      ),
    );
  }

  TextFormField _getNameField() {
    return TextFormField(
      controller: _nameController,
      focusNode: _nameFocus,
      onFieldSubmitted: (term) {
        _nameFocus.unfocus();
      },
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.normal,
        fontSize: 16.0.sp,
        color: AppColors.txtFieldTextColor,
      ),
      decoration: InputDecoration(
        hintText: Strings.nameHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        filled: true,
        fillColor: AppColors.txtFieldBackground,
      ),
    );
  }

  Container _selectCountryContainer() {
    return Container(
      width: MediaQuery.of(context).size.width - 60.0,
      height: 170.0,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GlobalWidgets.title(context, Strings.selectCountry),
          SizedBox(height: 10.0),
          _getSelectCountryOption(),
          SizedBox(height: 10.0),
          GlobalWidgets.italicDetailText(context, Strings.selectCountryDetail),
        ],
      ),
    );
  }

  Widget _getSelectCountryOption() {
    return Container(
      height: 6.4.h,
      width: 92.0.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.txtFieldBackground,
      ),
      child: TextButton(
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {},
        child: Text(
          Strings.selectCountry,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.normal,
            fontSize: 16.0.sp,
            color: AppColors.txtFieldTextColor,
          ),
        ),
      ),
    );
  }

  Container _selectLanguagesContainer() {
    return Container(
      width: MediaQuery.of(context).size.width - 60.0,
      height: 170.0,
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GlobalWidgets.title(context, Strings.selectLanugages),
          SizedBox(height: 10.0),
          _getSelectLanguagesOption(),
          SizedBox(height: 10.0),
          GlobalWidgets.italicDetailText(
              context, Strings.selectLanugagesDetail),
        ],
      ),
    );
  }

  Widget _getSelectLanguagesOption() {
    return Container(
      height: 6.4.h,
      width: 92.0.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.txtFieldBackground,
      ),
      child: TextButton(
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {},
        child: Text(
          Strings.selectLanugages,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.normal,
            fontSize: 16.0.sp,
            color: AppColors.txtFieldTextColor,
          ),
        ),
      ),
    );
  }

  Positioned _footer() {
    return Positioned(bottom: 0, child: _finishButton());
  }

  Container _finishButton() {
    return Container(
      color: AppColors.txtFieldBackground,
      width: 100.0.w,
      height: 9.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.selectedButtonBG,
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                Strings.finish,
                style: textButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
