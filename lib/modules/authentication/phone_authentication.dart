import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/modules/authentication/bloc/phone_bloc.dart';
import 'package:starfish/modules/authentication/footer.dart';
import 'package:starfish/widgets/app_logo_widget.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/widgets/title_label_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'authentication_error_handler.dart';
import 'bloc/login_flow_bloc.dart';

class PhoneAuthentication extends StatelessWidget {
  const PhoneAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhoneBloc(),
      child: const PhoneAuthenticationView(),
    );
  }
}

class PhoneAuthenticationView extends StatelessWidget {
  const PhoneAuthenticationView({Key? key}) : super(key: key);

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
                  title: appLocalizations.phoneAuthenticationTitle,
                  align: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                BlocBuilder<PhoneBloc, PhoneState>(
                  builder: (context, state) {
                    return InternationalPhoneNumberInput(
                      autoFocus: true,
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        showFlags: true,
                        useEmoji: true,
                      ),
                      initialValue: PhoneNumber(isoCode: "IN"),
                      inputDecoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: formTitleHintStyle,
                        hintText: appLocalizations.phoneNumberHint,
                        hintStyle: formTitleHintStyle,
                        contentPadding:
                            EdgeInsets.fromLTRB(15.0.w, 0.0, 5.0.w, 0.0),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        // errorBorder: outlineInputBorder,
                        // focusedErrorBorder: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        filled: true,
                        fillColor: AppColors.txtFieldBackground,
                      ),
                      onInputChanged: (value) => context
                          .read<PhoneBloc>()
                          .add(NumberChanged(value.phoneNumber!)),
                      onInputValidated: (isValid) => context
                          .read<PhoneBloc>()
                          .add(ValidityChanged(
                              kIsWeb ? state.number.length > 2 : isValid)),
                      onFieldSubmitted: (_) => context
                          .read<LoginFlowBloc>()
                          .add(SignInRequested(state.number)),
                      errorMessage: appLocalizations.invalidPhoneNumber,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: kIsWeb
                          ? ((value) => (value?.length ?? 0) > 2
                              ? null
                              : appLocalizations.invalidPhoneNumber)
                          : null,
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
              onPressed: () => context
                  .read<LoginFlowBloc>()
                  .add(SignInRequested(state.number)),
              style: ElevatedButton.styleFrom(
                primary:
                    (!state.isValid) ? Colors.grey : AppColors.selectedButtonBG,
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
