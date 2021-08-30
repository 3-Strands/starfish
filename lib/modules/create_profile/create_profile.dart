import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/italic_title_label_widget.dart';
import 'package:starfish/widgets/title_label_widget.dart';

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
                height: 100.0.h,
                width: 100.0.w,
                padding: EdgeInsets.fromLTRB(0.0.w, 14.0.h, 0.0.w, 4.0.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      AppLogo(hight: 19.4.h, width: 43.0.w),
                      SizedBox(height: 4.0.h),
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
      width: 100.0.w,
      height: 18.25.h,
      margin: EdgeInsets.only(left: 4.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TitleLabel(title: Strings.enterName),
          SizedBox(height: 1.0.h),
          _getNameField(),
          SizedBox(height: 1.0.h),
          ItalicitleLabel(title: Strings.enterNameDetail),
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
      width: 100.0.w,
      height: 18.25.h,
      margin: EdgeInsets.only(left: 4.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleLabel(title: Strings.selectCountry),
          SizedBox(height: 1.0.h),
          _getSelectCountryOption(),
          SizedBox(height: 1.0.h),
          ItalicitleLabel(title: Strings.selectCountryDetail),
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
      width: 100.0.w,
      height: 18.25.h,
      margin: EdgeInsets.only(left: 4.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleLabel(title: Strings.selectLanugages),
          SizedBox(height: 1.0.h),
          _getSelectLanguagesOption(),
          SizedBox(height: 1.0.h),
          ItalicitleLabel(title: Strings.selectLanugagesDetail),
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
            width: 85.0.w,
            height: 4.5.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.selectedButtonBG,
            ),
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                height: 4.5.h,
                width: 85.0.w,
                child: ElevatedButton(
                  child: Text(
                    Strings.finish,
                    textAlign: TextAlign.start,
                    style: textButtonTextStyle,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedButtonBG,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
