import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/global_app_logo.dart';
import 'package:starfish/constants/text_styles.dart';

class OTPVerificationScreen extends StatefulWidget {
  OTPVerificationScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
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
                      SizedBox(height: 8.8.h),
                      GlobalWidgets.title(
                          context, Strings.enterOneTimePassword),
                      SizedBox(height: 3.7.h),
                      _pinCodeContiner(),
                      SizedBox(height: 5.0.h),
                      _resendOTPContainer(),
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

  Container _pinCodeContiner() {
    return Container(
      height: 8.8.h,
      padding: EdgeInsets.all(16.0),
      child: PinCodeTextField(
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.green.shade600,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 48,
          fieldWidth: 48,
        ),
        blinkWhenObscuring: true,
        animationType: AnimationType.fade,
        cursorColor: Colors.black,
        boxShadows: [
          BoxShadow(
            offset: Offset(0, 1),
            color: AppColors.txtFieldBackground,
            blurRadius: 10,
          )
        ],
        onCompleted: (value) {},
        onChanged: (value) {
          // handle verification here
        },
      ),
    );
  }

  Container _resendOTPContainer() {
    return Container(
      width: 90.0.w,
      color: Colors.transparent,
      child: TextButton(
        onPressed: () {},
        child: Text(
          Strings.resentOTP,
          style: resentOTPTextStyle,
        ),
      ),
    );
  }

  Positioned _footer() {
    return Positioned(bottom: 0, child: _footerOptionButtons());
  }

  Container _footerOptionButtons() {
    return Container(
      color: AppColors.txtFieldBackground,
      width: 100.0.w,
      height: 9.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 38.6.w,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.unselectedButtonBG,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(Strings.back, style: textButtonTextStyle),
            ),
          ),
          Container(
            width: 38.6.w,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.selectedButtonBG,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateProfileScreen(),
                  ),
                );
              },
              child: Text(
                Strings.next,
                style: textButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
