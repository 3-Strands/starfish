part of 'session_bloc.dart';

@immutable
abstract class SessionEvent {
  const SessionEvent();
}

class SignInRequested extends SessionEvent {
  final String phoneNumber;

  const SignInRequested(this.phoneNumber);
}
class PhoneVerificationFailed extends SessionEvent {
  final String? code;

  const PhoneVerificationFailed([this.code]);
}
class SMSCodeEntered extends SessionEvent {
  final String code;

  const SMSCodeEntered(this.code);
}
class SMSCodeRefreshRequested extends SessionEvent {
  const SMSCodeRefreshRequested();
}
class SignOutRequested extends SessionEvent {
  const SignOutRequested();
}
class SessionRefreshRequested extends SessionEvent {
  const SessionRefreshRequested();
}
