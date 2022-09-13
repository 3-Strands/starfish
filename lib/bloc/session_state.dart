part of 'session_bloc.dart';

@immutable
abstract class SessionState {
  const SessionState();

  factory SessionState.fromSession(Session? session) {
    return session == null ? const SessionInactive() : SessionActive(session);
  }
}

class SessionInactive extends SessionState {
  const SessionInactive();
}

class SessionActive extends SessionState {
  final Session session;
  final Completer<void>? pendingReauthenticate;

  const SessionActive(this.session, {this.pendingReauthenticate});
}
