part of 'login_flow_bloc.dart';

@immutable
class LoginFlowState {
  const LoginFlowState({
    this.isPending = false,
    this.isFinished = false,
    this.errorCode = const Option.none(),
    this.otpHandler = const Option.none(),
  });

  final bool isPending;
  final bool isFinished;
  final Option<String> errorCode;
  final Option<OtpHandler> otpHandler;

  LoginFlowState copyWith({
    bool? isPending,
    bool? isFinished,
    Option<String>? errorCode,
    Option<OtpHandler>? otpHandler,
  }) =>
      LoginFlowState(
        isPending: isPending ?? this.isPending,
        isFinished: isFinished ?? this.isFinished,
        errorCode: errorCode ?? this.errorCode,
        otpHandler: otpHandler ?? this.otpHandler,
      );
}
