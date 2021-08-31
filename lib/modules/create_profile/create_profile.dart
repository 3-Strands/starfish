import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/modules/dashboard/dashboard.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/italic_title_label_widget.dart';
import 'package:starfish/widgets/select_country_dropdown_widget.dart';
import 'package:starfish/widgets/select_languages_dropdown_widget.dart';
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
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              height: 90.0.h,
              color: AppColors.background,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 14.5.h),
                    AppLogo(hight: 19.4.h, width: 100.0.w),
                    SizedBox(height: 5.17.h),
                    //--> Name text field section
                    TitleLabel(
                      title: Strings.enterName,
                      align: TextAlign.left,
                    ),
                    SizedBox(height: 1.2.h),
                    _getNameField(),
                    SizedBox(height: 1.2.h),
                    ItalicitleLabel(title: Strings.enterNameDetail),
                    //--------------------------
                    SizedBox(height: 3.69.h),
                    //--> Select country section
                    TitleLabel(
                      title: Strings.selectCountry,
                      align: TextAlign.left,
                    ),
                    SizedBox(height: 1.2.h),
                    CountryDropDown(
                      onCountrySelect: (selectedCountry) {},
                    ),
                    SizedBox(height: 1.2.h),
                    ItalicitleLabel(title: Strings.selectCountryDetail),
                    //--------------------------
                    SizedBox(height: 3.69.h),
                    //--> Select language section
                    TitleLabel(
                      title: Strings.selectLanugages,
                      align: TextAlign.left,
                    ),
                    SizedBox(height: 1.2.h),
                    LanguageDropDown(
                      onLanguageSelect: (langage) {},
                    ),
                    SizedBox(height: 1.2.h),
                    ItalicitleLabel(title: Strings.selectCountryDetail),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                    ),
                  ],
                ),
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Container _getNameField() {
    return Container(
      height: 6.4.h,
      margin: EdgeInsets.fromLTRB(4.0.w, 0.0, 4.0.w, 0.0),
      child: TextFormField(
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
      ),
    );
  }

  Align _footer() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: _finishButton() //Your widget here,
          ),
    );
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
