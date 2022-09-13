import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/authentication/bloc/login_flow_bloc.dart';
import 'package:starfish/modules/authentication/bloc/otp_bloc.dart';
import 'package:starfish/modules/authentication/bloc/otp_timer_bloc.dart';
import 'package:starfish/modules/authentication/otp_field.dart';
import 'package:starfish/modules/authentication/otp_submit_button.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';

class Reauthenticate extends StatelessWidget {
  const Reauthenticate({Key? key}) : super(key: key);

  static Future<void> init(BuildContext context) async {
    final error = await showDialog(
      context: context,
      builder: (context) => const Reauthenticate(),
      barrierDismissible: false,
    );
    if (error != null) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFlowBloc(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: BlocListener<LoginFlowBloc, LoginFlowState>(
        listenWhen: (previous, current) => current.isFinished,
        listener: (context, state) {
          Navigator.of(context).pop();
        },
        child: const ReauthenticateView(),
      ),
    );
  }
}

class ReauthenticateView extends StatefulWidget {
  const ReauthenticateView({Key? key}) : super(key: key);

  @override
  State<ReauthenticateView> createState() => _ReauthenticateViewState();
}

class _ReauthenticateViewState extends State<ReauthenticateView> {
  final _buttonFocus = FocusNode();

  @override
  void dispose() {
    _buttonFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return BlocBuilder<LoginFlowBloc, LoginFlowState>(
      builder: (context, state) {
        if (state.otpHandler.isSome) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => OtpBloc(),
              ),
              BlocProvider(
                create: (_) => OtpTimerBloc(60),
              ),
            ],
            child: AlertDialog(
              title: Text(appLocalizations.enterOneTimePassword),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OtpField(
                      onCompleted: (_) {
                        _buttonFocus.requestFocus();
                      },
                    ),
                    SizedBox(height: 50.h),
                    const Center(child: ResendOtp()),
                  ],
                ),
              ),
              actions: [
                BlocBuilder<LoginFlowBloc, LoginFlowState>(
                  builder: (context, state) {
                    if (state.isPending) {
                      return const CircularProgressIndicator();
                    }
                    return OtpSubmitButton(focusNode: _buttonFocus);
                  },
                ),
              ],
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        }
        return AlertDialog(
          title: Text(appLocalizations.somethingWentWrong),
          content: Text(appLocalizations.sorryYouNeedToSignInAgain),
          actions: [
            BlocBuilder<LoginFlowBloc, LoginFlowState>(
              builder: (context, state) {
                if (state.isPending) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    final currentUser = context.currentUser;
                    context.read<LoginFlowBloc>().add(
                          SignInRequested(currentUser.diallingCodeWithPlus +
                              currentUser.phone),
                        );
                  },
                  child: Text(appLocalizations.sendOtp, style: buttonTextStyle),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedButtonBG,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
