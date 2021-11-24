import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPVerificationScreen extends StatefulWidget {
  OTPVerificationScreen(
      {Key? key,
      this.title = '',
      this.varificationId,
      this.resentToken,
      required this.timeout,
      required this.phoneNumber})
      : super(key: key);

  final String title;
  final String phoneNumber;
  final String? varificationId;
  final int? resentToken;
  final int timeout;

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late String _smsCode;
  bool _otpEmpty = true;
  bool _isLoading = false;

  late int _timeout;
  late Timer _timer;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    _timeout = widget.timeout;
    _startResentOptTimer();
    super.initState();
  }

  _startResentOptTimer() async {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_timeout == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _timeout--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: Stack(children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 118.h),
                    AppLogo(hight: 156.h, width: 163.w),
                    SizedBox(height: 50.h),
                    TitleLabel(
                      title: Strings.enterOneTimePassword,
                      align: TextAlign.center,
                    ),
                    SizedBox(height: 30.h),
                    _pinCodeContiner(),
                    SizedBox(height: 50.h),
                    _resendOTPContainer(),
                  ],
                ),
              ),
              (_isLoading == true)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
            ]),
          ),
        ),
        bottomNavigationBar: _footer());
  }

  SizedBox _footer() {
    return SizedBox(
      height: 75.h,
      child: Stack(
        children: [
          Positioned(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: AppColors.txtFieldBackground,
                    padding: EdgeInsets.all(15.0),
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: _footerOptionButtons(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _pinCodeContiner() {
    return Container(
      height: 48.h,
      padding: EdgeInsets.only(left: 15.0.w, right: 15.w), //all(19.0),
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
          fieldHeight: 48.h,
          fieldWidth: 48.w,
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
        onCompleted: (value) {
          print('completed sms code=>>');
          print(value);
          setState(() {
            _otpEmpty = false;
          });
          _smsCode = value;
        },
        onChanged: (value) {
          setState(() {
            _otpEmpty = true;
          });
        },
      ),
    );
  }

  Container _resendOTPContainer() {
    return Container(
      height: 46.h,
      // padding: EdgeInsets.all(19.0),
      color: Colors.transparent,
      child: (_timeout > 0)
          ? Text(
              'Please wait for $_timeout seconds',
              style: resentOTPTextStyle,
            )
          : TextButton(
              onPressed: () {},
              child: Text(
                Strings.resentOTP,
                style: resentOTPTextStyle,
              ),
            ),
    );
  }

  Container _footerOptionButtons() {
    return Container(
      width: 319.w,
      height: 37.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 145.w,
            height: 37.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.unselectedButtonBG,
            ),
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: ElevatedButton(
                child: Text(
                  Strings.back,
                  textAlign: TextAlign.start,
                  style: buttonTextStyle,
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
          Container(
            width: 145.w,
            height: 37.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: AppColors.selectedButtonBG,
            ),
            child: Padding(
              padding: EdgeInsets.all(0.0),
              child: ElevatedButton(
                child: Text(
                  Strings.next,
                  textAlign: TextAlign.start,
                  style: buttonTextStyle,
                ),
                onPressed: () async {
                  if (_otpEmpty) {
                    return;
                  }

                  setState(() {
                    _isLoading = true;
                  });

                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.varificationId ?? '',
                            smsCode: _smsCode);

                    await auth.signInWithCredential(credential).then((data) => {
                          setState(() {
                            _isLoading = false;
                          }),
                          _sendDataAtServer(data),
                        });
                  } catch (e) {
                    setState(() {
                      _isLoading = false;
                    });
                    _handleError(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary:
                      (_otpEmpty) ? Colors.grey : AppColors.selectedButtonBG,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendDataAtServer(UserCredential credential) {
    debugPrint('user =>>, ${credential.user}');
    debugPrint('user name =>>, ${credential.user!.displayName}');
    debugPrint('uid =>>, ${credential.user!.uid}');

    StarfishSharedPreference().setAccessToken(widget.phoneNumber);
    Navigator.of(context).pushNamed(Routes.showProfile);
  }

  void _handleError(e) {
    debugPrint(e.message);
    StarfishSnackbar.showErrorMessage(context, '${e.message}');
  }
}
