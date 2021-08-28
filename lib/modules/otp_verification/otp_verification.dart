import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/modules/create_profile/create_profile.dart';
import 'package:sizer/sizer.dart';
import 'package:starfish/widgets/global_app_logo.dart';

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
              child: Center(
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
                        Container(
                          height: 8.8.h,
                          // alignment: Alignment.center,
                          // decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(color: Colors.transparent),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(20))),
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
                              fieldHeight: 50,
                              fieldWidth: 40,
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
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 60.0,
                          color: Colors.transparent,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              Strings.resentOTP,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 50.0,
                      color: Colors.grey[400],
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          Strings.back,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 50.0,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateProfileScreen(),
                            ),
                          );
                        },
                        child: Text(Strings.next),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
