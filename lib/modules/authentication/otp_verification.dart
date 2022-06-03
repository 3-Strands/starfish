import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/config/routes/routes.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/utils/services/local_storage_service.dart';
import 'package:starfish/utils/services/sync_service.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template_string/template_string.dart';

class OTPVerificationScreen extends StatefulWidget {
  OTPVerificationScreen(
      {Key? key,
      this.title = '',
      this.varificationId,
      this.resentToken,
      this.confirmationResult,
      required this.timeout,
      required this.dialingCode,
      required this.phoneNumber})
      : super(key: key);

  final String title;
  final String dialingCode;
  final String phoneNumber;
  final String? varificationId;
  final int? resentToken;
  final ConfirmationResult? confirmationResult;
  final int timeout;

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late String _smsCode;
  bool _otpEmpty = false;
  //bool _isLoading = false;

  late Timer _timer;

  late String _title;
  late String _dialingCode;
  late String _phoneNumber;
  late String? _verificationId;
  late int? _resendToken;
  late int _timeout;
  late ConfirmationResult? _confirmationResult;

  late AppLocalizations _appLocalizations;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    _title = widget.title;
    _dialingCode = widget.dialingCode;
    _phoneNumber = widget.phoneNumber;
    _verificationId = widget.varificationId;
    _resendToken = widget.resentToken;
    _timeout = widget.timeout;
    _confirmationResult = widget.confirmationResult;

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
    _appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
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
                  title: _appLocalizations.enterOneTimePassword,
                  align: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                _pinCodeContiner(),
                SizedBox(height: 50.h),
                _resendOTPContainer(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _footer(),
    );
  }

  get footerHeight => 75.h;

  SizedBox _footer() {
    return SizedBox(
      height: footerHeight,
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

  Widget _pinCodeContiner() {
    return Center(
      child: Container(
        height: 48.h,
        padding: EdgeInsets.only(left: 15.0.w, right: 15.w),
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
      ),
    );
  }

  _resentOTPOnPhone() async {
    await auth.verifyPhoneNumber(
      phoneNumber: _dialingCode + _phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
        _resendToken = resendToken;
        setState(() {
          _timeout = 60;
        });

        _startResentOptTimer();
      },
      forceResendingToken: _resendToken,
      timeout: Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  _resentOTPOnWeb() async {
    var phoneNumber = _dialingCode + _phoneNumber;
    await auth.signInWithPhoneNumber(phoneNumber).then((confirmationResult) {
      setState(() {
        _confirmationResult = confirmationResult;
        _timeout = 60;
      });
      _startResentOptTimer();
    });
  }

  _verfiyPhoneNumberWithOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId ?? '', smsCode: _smsCode);
      auth
          .signInWithCredential(credential)
          .then((data) => {
                /*setState(() {
                  _isLoading = false;
                })*/
                EasyLoading.dismiss(),
                _getUserInfo(data),
              })
          .onError((error, stackTrace) => _handleError(error));
    } catch (e) {
      _handleError(e);
    }
  }

  _verfiyPhoneNumberWithOTPOnWeb() async {
    UserCredential userCredential =
        await _confirmationResult!.confirm(_smsCode);
    /*setState(() {
      _isLoading = false;
    });*/
    EasyLoading.dismiss();
    _getUserInfo(userCredential);
  }

  Widget _resendOTPContainer() {
    return Center(
      child: Container(
        height: 46.h,
        color: Colors.transparent,
        child: (_timeout > 0)
            ? Text(
                _appLocalizations.waitForSeconds
                    .insertTemplateValues({'timeout': _timeout}),
                style: resentOTPTextStyle,
              )
            : TextButton(
                onPressed: () {
                  if (kIsWeb) {
                    _resentOTPOnWeb();
                  } else {
                    _resentOTPOnPhone();
                  }
                },
                child: Text(
                  _appLocalizations.resentOTP,
                  style: resentOTPTextStyle,
                ),
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
                  _appLocalizations.back,
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
                  _appLocalizations.next,
                  textAlign: TextAlign.start,
                  style: buttonTextStyle,
                ),
                onPressed: () async {
                  if (_otpEmpty) {
                    return;
                  }

                  /*setState(() {
                    _isLoading = true;
                  });*/
                  EasyLoading.show();

                  if (kIsWeb) {
                    _verfiyPhoneNumberWithOTPOnWeb();
                  } else {
                    _verfiyPhoneNumberWithOTP();
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

  void _getUserInfo(UserCredential credential) {
    credential.user!.getIdToken(true).then((jwtToken) =>
        {_sendDataAtServer(jwtToken, credential.user!.phoneNumber)});
  }

  Future<void> _sendDataAtServer(String jwtToken, String? userName) async {
    final CurrentUserRepository _currentUserRepository =
        CurrentUserRepository();
    _currentUserRepository.apiProvider
        .authenticate(jwtToken, userName ?? '')
        .then((AuthenticateResponse _currentUser) async {
      if (_currentUser.userToken.isNotEmpty) {
        StarfishSharedPreference().setLoginStatus(true);
        await _setAccessToken(_dialingCode, _phoneNumber, _currentUser);

        HiveCurrentUser? _existingUser =
            _currentUserRepository.dbProvider.getCurrentUserSync();

        CurrentUserRepository().apiProvider.getCurrentUser().then((user) async {
          HiveCurrentUser _currentUser = HiveCurrentUser(
              id: user.id,
              name: user.name,
              phone: user.phone,
              linkGroups: user.linkGroups,
              countryIds: user.countryIds,
              languageIds: user.languageIds,
              groups: user.groups.map((e) => HiveGroupUser.from(e)).toList(),
              actions: user.actions.map((e) => HiveActionUser.from(e)).toList(),
              diallingCode: user.diallingCode,
              phoneCountryId: user.phoneCountryId,
              selectedActionsTab: user.selectedActionsTab.value,
              selectedResultsTab: user.selectedResultsTab.value,
              status: user.status.value,
              creatorId: user.creatorId);

          await CurrentUserProvider().createUpdate(_currentUser);
          // if country and language is already selected by current user, navigate to dashboard.
          bool isProfileUpdated = _currentUser.countryIds.length > 0 &&
              _currentUser.languageIds.length > 0;

          if (_existingUser == null) {
            _prepareAppAndNavigate(isProfileUpdated: isProfileUpdated);
            return;
          }

          if (_existingUser.id == user.id) {
            _navigateUserToNextScreen(isProfileUpdated: isProfileUpdated);
            //  Navigator.of(context).pushNamed(Routes.showProfile);
          } else {
            SyncService().clearAll();
            _prepareAppAndNavigate(isProfileUpdated: isProfileUpdated);
          }
        });
      }
    });
  }

  _navigateUserToNextScreen({isProfileUpdated = false}) {
    if (isProfileUpdated) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.dashboard, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamed(Routes.showProfile);
    }
  }

  _prepareAppAndNavigate({isProfileUpdated = false}) {
    EasyLoading.show();
    Future.wait([
      //SyncService().syncCurrentUser(),
      SyncService().syncCountries(),
      SyncService().syncLanguages(),
      SyncService().syncMaterialTopics(),
      SyncService().syncMaterialTypes(),
      SyncService().syncEvaluationCategories(),
      SyncService().syncMaterial(),
      SyncService().syncGroup(),
      SyncService().syncActions(),
      SyncService().syncUsers(),
    ]).then((value) {
      SyncService().updateLastSyncDateTime();
      _navigateUserToNextScreen(isProfileUpdated: isProfileUpdated);
      // Navigator.of(context).pushNamed(Routes.showProfile);
    }).onError((error, stackTrace) {
      _handleError(error);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  _setAccessToken(String dialingCode, String phoneNumnber,
      AuthenticateResponse authenticateResponse) async {
    /*if (FlavorConfig.isDevelopment()) {
      //SANDBOX
      StarfishSharedPreference().setAccessToken(_phoneNumber);
    } else if (FlavorConfig.isProduction()) {
      // LIVE
      StarfishSharedPreference().setAccessToken(authenticateResponse.userToken);
    }*/

    debugPrint("AuthenticationResponse: $authenticateResponse");
    await StarfishSharedPreference()
        .setAccessToken(authenticateResponse.userToken);
    await StarfishSharedPreference()
        .setRefreshToken(authenticateResponse.refreshToken);
    await StarfishSharedPreference()
        .setSessionUserId(authenticateResponse.userId);
  }

  _handleError(dynamic e) {
    debugPrint(e.message);
    /*setState(() {
      _isLoading = false;
    });*/
    EasyLoading.dismiss();
    StarfishSnackbar.showErrorMessage(context, '${e.message}');
  }
}
