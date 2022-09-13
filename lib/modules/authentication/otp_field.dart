import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/authentication/bloc/login_flow_bloc.dart';
import 'package:starfish/modules/authentication/bloc/otp_bloc.dart';
import 'package:starfish/modules/authentication/bloc/otp_timer_bloc.dart';
import 'package:template_string/template_string.dart';

class OtpField extends StatelessWidget {
  const OtpField({Key? key, this.onCompleted}) : super(key: key);

  final void Function(String)? onCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          return PinCodeTextField(
            autoFocus: true,
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
                ? (_) => context
                    .read<LoginFlowBloc>()
                    .add(SMSCodeEntered(state.code))
                : null,
            onCompleted: onCompleted,
          );
        },
      ),
    );
  }
}

class ResendOtp extends StatelessWidget {
  const ResendOtp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
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
            onPressed: () => context
                .read<LoginFlowBloc>()
                .add(const SMSCodeRefreshRequested()),
            child: Text(
              appLocalizations.resentOTP,
              style: resentOTPTextStyle,
            ),
          );
        },
      ),
    );
  }
}
