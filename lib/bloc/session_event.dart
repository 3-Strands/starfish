part of 'session_bloc.dart';

@immutable
abstract class SessionEvent {
  const SessionEvent();
}

class SessionChanged extends SessionEvent {
  const SessionChanged(this.session);

  final Session? session;
}

class SessionRefreshRequested extends SessionEvent {
  const SessionRefreshRequested();
}

class SignOutRequested extends SessionEvent {
  const SignOutRequested();
}
