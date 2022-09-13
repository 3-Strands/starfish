import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/authentication/otp_field.dart';
import 'package:starfish/modules/authentication/otp_submit_button.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'authentication_error_handler.dart';
import 'bloc/login_flow_bloc.dart';
import 'bloc/otp_bloc.dart';
import 'bloc/otp_timer_bloc.dart';
import 'footer.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({Key? key}) : super(key: key);

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

class OTPVerificationView extends StatefulWidget {
  const OTPVerificationView({Key? key}) : super(key: key);

  @override
  State<OTPVerificationView> createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final _buttonFocus = FocusNode();

  @override
  void dispose() {
    _buttonFocus.dispose();
    super.dispose();
  }

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: OtpField(
                      onCompleted: (_) {
                        _buttonFocus.requestFocus();
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Center(
                  child: ResendOtp(),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
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
                child: OtpSubmitButton(
                  focusNode: _buttonFocus,
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
