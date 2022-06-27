import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/authentication/otp_verification.dart';
import 'package:starfish/utils/helpers/general_functions.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/constrain_center.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  const PhoneAuthenticationScreen({Key? key, this.title = ''})
      : super(key: key);

  final String title;

  @override
  _PhoneAuthenticationScreenState createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  bool _isPhoneNumberValid = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  PhoneNumber? _phoneNumber;

  late AppLocalizations _appLocalizations;

  @override
  void initState() {
    super.initState();

    _isPhoneNumberValid = false;

    SyncService obj = SyncService();
    obj.syncAll();
  }

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: footerHeight),
          child: Center(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              shrinkWrap: true,
              children: <Widget>[
                AppLogo(hight: 156.h, width: 163.w),
                SizedBox(height: 50.h),
                TitleLabel(
                  title: _appLocalizations.phoneAuthenticationTitle,
                  align: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                _phoneNumberContainer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _footer(),
      //  bottomNavigationBar: _footer(),
    );
  }

  Widget _phoneNumberContainer() {
    OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );
    return ConstrainCenter(
      child: InternationalPhoneNumberInput(
        selectorConfig: SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
          showFlags: true,
          useEmoji: true,
        ),
        inputDecoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: formTitleHintStyle,
          hintText: AppLocalizations.of(context)!.phoneNumberHint,
          hintStyle: formTitleHintStyle,
          contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
          border: _outlineInputBorder,
          enabledBorder: _outlineInputBorder,
          // errorBorder: _outlineInputBorder,
          // focusedErrorBorder: _outlineInputBorder,
          focusedBorder: _outlineInputBorder,
          filled: true,
          fillColor: AppColors.txtFieldBackground,
        ),
        onInputChanged: ((value) {
          setState(() {
            _phoneNumber = value;
          });
        }),
        onInputValidated: (isValid) {
          setState(() {
            _isPhoneNumberValid = isValid;
          });
        },
        errorMessage: AppLocalizations.of(context)!.invalidPhoneNumber,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        formatInput: false,
        maxLength: 15,
      ),
    );
  }

  get footerHeight => 75.h;

  Container _footer() {
    return Container(
      height: footerHeight,
      color: AppColors.txtFieldBackground,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: _nextButton(),
      ),
    );
  }

  Container _nextButton() {
    return Container(
      width: 319.w,
      height: 37.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppColors.selectedButtonBG,
      ),
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: SizedBox(
          width: 319.w,
          height: 37.h,
          child: ElevatedButton(
            child: Text(
              _appLocalizations.next,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () async {
              if (!_isPhoneNumberValid) {
                return;
              }
              EasyLoading.show();

              if (kIsWeb) {
                _authenticateOnWeb(
                    _phoneNumber!.dialCode!, _phoneNumber!.parseNumber());
              } else {
                _authenticateOnDevice(
                    _phoneNumber!.dialCode!, _phoneNumber!.parseNumber());
              }
            },
            style: ElevatedButton.styleFrom(
              primary: (!_isPhoneNumberValid)
                  ? Colors.grey
                  : AppColors.selectedButtonBG,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _authenticateOnDevice(String dialingCode, String phoneNumber) async {
    final String phoneNumberWithDialingCode = dialingCode + phoneNumber;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumberWithDialingCode,
      verificationCompleted: (PhoneAuthCredential credential) {
        EasyLoading.dismiss();
      },
      verificationFailed: (FirebaseAuthException e) {
        EasyLoading.dismiss();
        if (e.code == 'invalid-phone-number') {
          return StarfishSnackbar.showErrorMessage(context, e.message ?? '');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(
              varificationId: verificationId,
              resentToken: resendToken,
              dialingCode: dialingCode,
              phoneNumber: phoneNumber,
              timeout: 60,
            ),
          ),
        );
      },
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  _authenticateOnWeb(String dialingCode, String phoneNumber) async {
    await auth
        .signInWithPhoneNumber(dialingCode + phoneNumber)
        .then((confirmationResult) => {
              EasyLoading.dismiss(),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPVerificationScreen(
                    varificationId: '',
                    confirmationResult: confirmationResult,
                    dialingCode: dialingCode,
                    phoneNumber: phoneNumber,
                    timeout: 60,
                  ),
                ),
              ),
            })
        .onError((error, stackTrace) => {
              EasyLoading.dismiss(),
            });
  }
}
