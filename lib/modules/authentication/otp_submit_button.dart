import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/authentication/bloc/login_flow_bloc.dart';
import 'package:starfish/modules/authentication/bloc/otp_bloc.dart';

class OtpSubmitButton extends StatelessWidget {
  const OtpSubmitButton({Key? key, this.focusNode}) : super(key: key);

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<OtpBloc, OtpState>(
      buildWhen: (previous, current) =>
          previous.isComplete != current.isComplete,
      builder: (context, state) {
        return ElevatedButton(
          child: Text(
            appLocalizations.next,
            textAlign: TextAlign.start,
            style: buttonTextStyle,
          ),
          focusNode: focusNode,
          onPressed: state.isComplete
              ? () =>
                  context.read<LoginFlowBloc>().add(SMSCodeEntered(state.code))
              : null,
          style: ElevatedButton.styleFrom(
            primary:
                state.isComplete ? AppColors.selectedButtonBG : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      },
    );
  }
}
