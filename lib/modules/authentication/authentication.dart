import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:starfish/repositories/authentication_repository.dart';

import 'bloc/login_flow_bloc.dart';
import 'otp_verification.dart';
import 'phone_authentication.dart';

class Authentication extends StatelessWidget {
  const Authentication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFlowBloc(authenticationRepository: context.read<AuthenticationRepository>()),
      child: Navigator(
        onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => const AuthenticationView()),
      ),
    );
  }
}

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // Handle showing and dismissing the loader when the [isPending] state changes
        BlocListener<LoginFlowBloc, LoginFlowState>(
          listenWhen: (previous, current) => previous.isPending != current.isPending,
          listener: (context, state) {
            if (state.isPending) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
        ),
        // Handle pushing and popping the [OTPVerification] route when necessary
        BlocListener<LoginFlowBloc, LoginFlowState>(
          listenWhen: (previous, current) => previous.otpHandler.isSome != current.otpHandler.isSome,
          listener: (context, state) {
            if (state.otpHandler.isSome) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OTPVerification(),
                ),
              );
            } else {
              Navigator.popUntil(context, (route) => false);
            }
          },
        ),
      ],
      child: const PhoneAuthentication(),
    );
  }
}
