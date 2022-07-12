part of 'login_flow_bloc.dart';

@immutable
abstract class LoginFlowEvent {
  const LoginFlowEvent();
}

class SignInRequested extends LoginFlowEvent {
  final String phoneNumber;

  const SignInRequested(this.phoneNumber);
}
class PhoneVerificationFailed extends LoginFlowEvent {
  final String? code;

  const PhoneVerificationFailed([this.code]);
}
class SMSCodeEntered extends LoginFlowEvent {
  final String code;

  const SMSCodeEntered(this.code);
}
class SMSCodeRefreshRequested extends LoginFlowEvent {
  const SMSCodeRefreshRequested();
}
class SignOutRequested extends LoginFlowEvent {
  const SignOutRequested();
}
class SessionRefreshRequested extends LoginFlowEvent {
  const SessionRefreshRequested();
}
