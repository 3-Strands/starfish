import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:starfish/models/session.dart';
import 'package:starfish/repositories/authentication_repository.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthenticationRepository authenticationRepository;

  SessionBloc({
    required this.authenticationRepository,
  }) : super(SessionState.fromSession(authenticationRepository.currentSession)) {
    on<SessionChanged>((event, emit) {
      final session = event.session;
      emit(session == null ? const SessionInactive() : SessionActive(session));
    });
    on<SessionRefreshRequested>((event, emit) async {
      await authenticationRepository.refreshSession();
    });
    on<SignOutRequested>((event, emit) {
      emit(const SessionInactive());
    });

    // Note that we never close this listener because it will run for the entirety of the app.
    // For testing purposes this would have to be changed.
    authenticationRepository.session.listen((session) {
      add(SessionChanged(session));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // Kick the user out of the app.
    add(SessionChanged(null));
    super.onError(error, stackTrace);
  }
}
