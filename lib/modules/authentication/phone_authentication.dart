import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:starfish/bloc/session_bloc.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/authentication/bloc/phone_bloc.dart';
import 'package:starfish/modules/authentication/footer.dart';
import 'package:starfish/modules/authentication/otp_verification.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PhoneAuthentication extends StatelessWidget {
  const PhoneAuthentication({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneBloc(),
      child: const PhoneAuthenticationView(),
    );
  }
}

class PhoneAuthenticationView extends StatelessWidget {
  const PhoneAuthenticationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final footerHeight = 75.h;

    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: Colors.white,
      ),
    );

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SessionBloc, SessionState>(
            listener: (context, state) {
              if (state.isPendingState && !EasyLoading.isShow) {
                EasyLoading.show();
              } else if (!state.isPendingState && EasyLoading.isShow) {
                EasyLoading.dismiss();
              }
            },
          ),
          // Push the OTP page when the state changes to [CodeNeededFromUser]
          BlocListener<SessionBloc, SessionState>(
            listenWhen: (previous, current) => current is CodeNeededFromUser && !(previous is CodeNeededFromUser),
            listener: (context, state) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OTPVerification(),
                ),
              );
            },
          ),
        ],
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
                  title: appLocalizations.phoneAuthenticationTitle,
                  align: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                BlocBuilder<PhoneBloc, PhoneState>(
                  builder: (context, state) {
                    final phoneBloc = BlocProvider.of<PhoneBloc>(context);

                    return InternationalPhoneNumberInput(
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        showFlags: true,
                        useEmoji: true,
                      ),
                      inputDecoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: formTitleHintStyle,
                        hintText: appLocalizations.phoneNumberHint,
                        hintStyle: formTitleHintStyle,
                        contentPadding: EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        // errorBorder: outlineInputBorder,
                        // focusedErrorBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        filled: true,
                        fillColor: AppColors.txtFieldBackground,
                      ),
                      onInputChanged: (value) => phoneBloc.add(NumberChanged(value.dialCode! + value.phoneNumber!)),
                      onInputValidated: (isValid) => phoneBloc.add(ValidityChanged(isValid)),
                      onFieldSubmitted: (_) =>
                        BlocProvider.of<SessionBloc>(context).add(SignInRequested(state.number)),
                      errorMessage: appLocalizations.invalidPhoneNumber,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      formatInput: false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Footer(
        height: footerHeight,
        child: BlocBuilder<PhoneBloc, PhoneState>(
          builder: (context, state) {
            return ElevatedButton(
              child: Text(
                appLocalizations.next,
                textAlign: TextAlign.start,
                style: buttonTextStyle,
              ),
              onPressed: () =>
                BlocProvider.of<SessionBloc>(context).add(SignInRequested(state.number)),
              style: ElevatedButton.styleFrom(
                primary: (!state.isValid)
                    ? Colors.grey
                    : AppColors.selectedButtonBG,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
