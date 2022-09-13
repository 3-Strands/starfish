part of 'session_bloc.dart';

@immutable
abstract class SessionEvent {
  const SessionEvent();
}

class SessionChanged extends SessionEvent {
  const SessionChanged(this.session);

  final Session? session;
}

class SessionReauthenticationChanged extends SessionEvent {
  const SessionReauthenticationChanged(this.completer);

  final Completer<void>? completer;
}

class SessionRefreshRequested extends SessionEvent {
  const SessionRefreshRequested();
}

class SignOutRequested extends SessionEvent {
  const SignOutRequested();
}
