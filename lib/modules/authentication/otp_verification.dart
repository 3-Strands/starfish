import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:template_string/template_string.dart';

import 'authentication_error_handler.dart';
import 'bloc/login_flow_bloc.dart';
import 'bloc/otp_bloc.dart';
import 'bloc/otp_timer_bloc.dart';
import 'footer.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OtpBloc(),
        ),
        BlocProvider(
          create: (_) => OtpTimerBloc(60),
        ),
      ],
      child: const OTPVerificationView(),
    );
  }
}

class OTPVerificationView extends StatelessWidget {
  const OTPVerificationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final footerHeight = 75.h;

    return Scaffold(
      body: AuthenticationErrorHandler(
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
                  title: appLocalizations.enterOneTimePassword,
                  align: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: BlocBuilder<OtpBloc, OtpState>(
                      builder: (context, state) {
                        return PinCodeTextField(
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
                          onChanged: (value) =>
                            context.read<OtpBloc>().add(OtpChanged(value)),
                          onSubmitted: state.isComplete
                            ? (_) => context.read<LoginFlowBloc>().add(SMSCodeEntered(state.code))
                            : null,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: Container(
                    height: 46.h,
                    color: Colors.transparent,
                    child: BlocBuilder<OtpTimerBloc, OtpTimerState>(
                      builder: (context, state) {
                        if (state is TimerTicking) {
                          return Text(
                            appLocalizations.waitForSeconds
                                .insertTemplateValues({'timeout': state.secondsRemaining}),
                            style: resentOTPTextStyle,
                          );
                        }
                        return TextButton(
                          onPressed: () =>
                            context.read<LoginFlowBloc>().add(const SMSCodeRefreshRequested()),
                          child: Text(
                            appLocalizations.resentOTP,
                            style: resentOTPTextStyle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Footer(
        height: footerHeight,
        child: Container(
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
                      appLocalizations.back,
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
                  child: BlocBuilder<OtpBloc, OtpState>(
                    buildWhen: (previous, current) => previous.isComplete != current.isComplete,
                    builder: (context, state) {
                      return ElevatedButton(
                        child: Text(
                          appLocalizations.next,
                          textAlign: TextAlign.start,
                          style: buttonTextStyle,
                        ),
                        onPressed: state.isComplete
                          ? () => context.read<LoginFlowBloc>().add(SMSCodeEntered(state.code))
                          : null,
                        style: ElevatedButton.styleFrom(
                          primary:
                              state.isComplete ? AppColors.selectedButtonBG : Colors.grey,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0),
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _OTPVerificationScreenState extends State<OTPVerificationScreen> {

//   Future<void> _sendDataAtServer(String jwtToken, String? userName) async {
//     final CurrentUserRepository _currentUserRepository =
//         CurrentUserRepository();
//     _currentUserRepository.apiProvider
//         .authenticate(jwtToken, userName ?? '')
//         .then((AuthenticateResponse _currentUser) async {
//       if (_currentUser.userToken.isNotEmpty) {
//         StarfishSharedPreference().setLoginStatus(true);
//         await _setAccessToken(_dialingCode, _phoneNumber, _currentUser);

//         HiveCurrentUser? _existingUser =
//             _currentUserRepository.dbProvider.getCurrentUserSync();

//         CurrentUserRepository().apiProvider.getCurrentUser().then((user) async {
//           HiveCurrentUser _currentUser = HiveCurrentUser(
//               id: user.id,
//               name: user.name,
//               phone: user.phone,
//               linkGroups: user.linkGroups,
//               countryIds: user.countryIds,
//               languageIds: user.languageIds,
//               groups: user.groups.map((e) => HiveGroupUser.from(e)).toList(),
//               actions: user.actions.map((e) => HiveActionUser.from(e)).toList(),
//               diallingCode: user.diallingCode,
//               phoneCountryId: user.phoneCountryId,
//               selectedActionsTab: user.selectedActionsTab.value,
//               selectedResultsTab: user.selectedResultsTab.value,
//               status: user.status.value,
//               creatorId: user.creatorId);

//           await CurrentUserProvider().createUpdate(_currentUser);
//           // if country and language is already selected by current user, navigate to dashboard.
//           bool isProfileUpdated = _currentUser.countryIds.length > 0 &&
//               _currentUser.languageIds.length > 0;

//           if (_existingUser == null) {
//             _prepareAppAndNavigate(isProfileUpdated: isProfileUpdated);
//             return;
//           }

//           if (_existingUser.id == user.id) {
//             _navigateUserToNextScreen(isProfileUpdated: isProfileUpdated);
//             //  Navigator.of(context).pushNamed(Routes.showProfile);
//           } else {
//             SyncService().clearAll();
//             _prepareAppAndNavigate(isProfileUpdated: isProfileUpdated);
//           }
//         });
//       }
//     });
//   }

//   _navigateUserToNextScreen({isProfileUpdated = false}) {
//     if (isProfileUpdated) {
//       Navigator.of(context).pushNamedAndRemoveUntil(
//           Routes.dashboard, (Route<dynamic> route) => false);
//     } else {
//       Navigator.of(context).pushNamed(Routes.showProfile);
//     }
//   }

//   _prepareAppAndNavigate({isProfileUpdated = false}) {
//     EasyLoading.show();
//     Future.wait([
//       //SyncService().syncCurrentUser(),
//       SyncService().syncCountries(),
//       SyncService().syncLanguages(),
//       SyncService().syncMaterialTopics(),
//       SyncService().syncMaterialTypes(),
//       SyncService().syncEvaluationCategories(),
//       SyncService().syncMaterial(),
//       SyncService().syncGroup(),
//       SyncService().syncActions(),
//       SyncService().syncUsers(),
//     ]).then((value) {
//       SyncService().updateLastSyncDateTime();
//       _navigateUserToNextScreen(isProfileUpdated: isProfileUpdated);
//       // Navigator.of(context).pushNamed(Routes.showProfile);
//     }).onError((error, stackTrace) {
//       _handleError(error);
//     }).whenComplete(() {
//       EasyLoading.dismiss();
//     });
//   }

//   _handleError(dynamic e) {
//     debugPrint(e.message);
//     /*setState(() {
//       _isLoading = false;
//     });*/
//     EasyLoading.dismiss();
//     StarfishSnackbar.showErrorMessage(context, '${e.message}');
//   }
// }
