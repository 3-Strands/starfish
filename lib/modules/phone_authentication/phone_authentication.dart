import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/modules/otp_verification/otp_verification.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/global_app_logo.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  PhoneAuthenticationScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _PhoneAuthenticationScreenState createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  final _countryCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final FocusNode _countryCodeFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();

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
              height: 100.h,
              width: 100.h,
              color: AppColors.background,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(4.0.w, 14.5.h, 4.0.w, 4.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GlobalWidgets.logo(context),
                      SizedBox(height: 6.1.h),
                      GlobalWidgets.title(
                          context, Strings.phoneAuthenticationTitle),
                      SizedBox(height: 3.7.h),
                      _selectCountyField(),
                      SizedBox(height: 3.7.h),
                      _phoneNumberContainer()
                    ],
                  ),
                ),
              ),
            ),
            _footer()
          ],
        ),
      ),
    );
  }

  Container _selectCountyField() {
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

  Container _phoneNumberContainer() {
    return Container(
      height: 6.4.h,
      child: Row(
        children: [
          Container(
            height: 6.4.h,
            width: 23.2.w,
            child: _countryCodeField(),
          ),
          SizedBox(width: 4.0.w),
          Container(
            height: 6.4.h,
            width: 64.8.w,
            child: _phoneNumberField(),
          )
        ],
      ),
    );
  }

  TextFormField _countryCodeField() {
    return TextFormField(
      controller: _countryCodeController,
      focusNode: _countryCodeFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _countryCodeFocus, _phoneNumberFocus);
      },
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.normal,
        fontSize: 16.0.sp,
        color: AppColors.txtFieldTextColor,
      ),
      decoration: InputDecoration(
        hintText: Strings.countryCodeHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
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

  TextFormField _phoneNumberField() {
    return TextFormField(
      controller: _phoneNumberController,
      focusNode: _phoneNumberFocus,
      onFieldSubmitted: (term) {
        _phoneNumberFocus.unfocus();
      },
      keyboardType: TextInputType.phone,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.normal,
        fontSize: 16.0.sp,
        color: AppColors.txtFieldTextColor,
      ),
      decoration: InputDecoration(
        hintText: Strings.phoneNumberHint,
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

  Positioned _footer() {
    return Positioned(bottom: 0, child: _nextButton());
  }

  Container _nextButton() {
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
              color: Colors.blue,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationScreen(),
                  ),
                );
              },
              child: Text(
                Strings.next,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
