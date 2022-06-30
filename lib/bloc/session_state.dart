part of 'session_bloc.dart';

@immutable
abstract class SessionState {
  const SessionState();

  bool get isPendingState => this is PendingSessionState;
}

abstract class PendingSessionState extends SessionState {
  const PendingSessionState();
}

class SessionInactive extends SessionState {
  const SessionInactive();
}
class SignInPending extends PendingSessionState {
  const SignInPending();
}
class PhoneVerificationFailure extends SessionState {
  final String? code;

  const PhoneVerificationFailure([this.code]);
}
class CodeNeededFromUser extends SessionState {
  final Future<UserCredential> Function(String code) getUserCredentialFromCode;
  final String phoneNumber;
  final int? resendToken;

  const CodeNeededFromUser({
    required this.getUserCredentialFromCode,
    required this.phoneNumber,
    this.resendToken,
  });
}
class CodeVerificationPending extends PendingSessionState {
  const CodeVerificationPending();
}
class CodeVerificationFailure extends SessionState {
  const CodeVerificationFailure();
}
class SessionActive extends SessionState {
  final Session session;

  const SessionActive(this.session);
}
