import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';

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
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              // height: 100.h,
              // width: 100.h,
              color: AppColors.background,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 17.7.h),
                    AppLogo(hight: 19.4.h, width: 43.0.w),
                    SizedBox(height: 8.8.h),
                    TitleLabel(
                      title: Strings.enterOneTimePassword,
                      align: TextAlign.center,
                    ),
                    SizedBox(height: 3.7.h),
                    _pinCodeContiner(),
                    SizedBox(height: 5.0.h),
                    _resendOTPContainer(),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
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

  Align _footer() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: _footerOptionButtons() //Your widget here,
          ),
    );
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
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                width: 38.6.w,
                height: 40.0,
                child: ElevatedButton(
                  child: Text(
                    Strings.back,
                    textAlign: TextAlign.start,
                    style: textButtonTextStyle,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.unselectedButtonBG,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
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
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: SizedBox(
                width: 38.6.w,
                height: 40.0,
                child: ElevatedButton(
                  child: Text(
                    Strings.next,
                    textAlign: TextAlign.start,
                    style: textButtonTextStyle,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateProfileScreen(),
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
