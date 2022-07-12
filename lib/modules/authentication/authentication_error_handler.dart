import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starfish/modules/authentication/bloc/login_flow_bloc.dart';
import 'package:starfish/utils/helpers/snackbar.dart';

/// Shows the snacbkar with the contextualized error message when the error comes.
class AuthenticationErrorHandler extends StatelessWidget {
  const AuthenticationErrorHandler({ Key? key, required this.child }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginFlowBloc, LoginFlowState>(
      // Only create the snackbar when the error exists and has changed.
      listenWhen: (previous, current) => current.errorCode.isSome && !identical(previous.errorCode, current.errorCode),
      listener: (context, state) {
        final code = state.errorCode.value!;
        // TODO: show contextualized message based on code.
        StarfishSnackbar.showErrorMessage(context, 'Authentication error: $code');
      },
      child: child,
    );
  }
}