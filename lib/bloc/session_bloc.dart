import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:starfish/models/session.dart';
import 'package:starfish/repositories/session_repository.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionRepository sessionRepository;

  SessionBloc({
    required this.sessionRepository,
    SessionState? initialState,
  }) : super(initialState ?? SessionInactive()) {
    on<SignInRequested>((event, emit) async {
      emit(const SignInPending());
      await authenticate(event.phoneNumber, emit);
    });
    on<PhoneVerificationFailed>((event, emit) {
      emit(PhoneVerificationFailure(event.code));
    });
    on<SMSCodeRefreshRequested>((event, emit) async {
      final state = this.state;
      if (state is CodeNeededFromUser) {
        await authenticate(state.phoneNumber, emit, resendToken: state.resendToken);
      }
    });
    on<SMSCodeEntered>((event, emit) =>
      finishAuthentication(event.code, emit),
    );
    on<SignOutRequested>((event, emit) {
      emit(const SessionInactive());
    });
    on<SessionRefreshRequested>((event, emit) async {
      final currentState = state;
      if (currentState is SessionActive) {
        final newSession = await sessionRepository.refreshSession(currentState.session);
        emit(SessionActive(newSession));
      }
    });
  }

  @override
  void onChange(Change<SessionState> change) {
    super.onChange(change);
    final nextState = change.nextState;
    if (nextState is SessionActive) {
      sessionRepository.cacheTokens(nextState.session);
    } else if (nextState is SessionInactive) {
      sessionRepository.removeTokens();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final code = error is FirebaseAuthException ? error.code : null;
    add(PhoneVerificationFailed(code));
    super.onError(error, stackTrace);
  }

  Future<void> authenticate(String phoneNumber, Emitter<SessionState> emit, {int? resendToken}) =>
    kIsWeb ? _authenticateOnWeb(phoneNumber, emit) : _authenticateOnDevice(phoneNumber, emit, resendToken: resendToken);

  Future<void> _authenticateOnDevice(String phoneNumber, Emitter<SessionState> emit, {int? resendToken}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) => _onVerificationCompleted(phoneAuthCredential, emit),
      verificationFailed: (FirebaseAuthException e) {
        addError(e);
        // if (e.code == 'invalid-phone-number') {
        //   return StarfishSnackbar.showErrorMessage(context, e.message ?? '');
        // }
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(CodeNeededFromUser(
          phoneNumber: phoneNumber,
          resendToken: resendToken,
          getUserCredentialFromCode: (code) {
            final credential = PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: code,
            );
            return FirebaseAuth.instance
              .signInWithCredential(credential);
          }
        ));
      },
      timeout: const Duration(seconds: 60),
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        add(const PhoneVerificationFailed());
      },
    );
  }

  _authenticateOnWeb(String phoneNumber, Emitter<SessionState> emit) async {
    final result = await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
    emit(CodeNeededFromUser(
      phoneNumber: phoneNumber,
      getUserCredentialFromCode: (code) => result.confirm(code)
    ));
  }

  Future<void> finishAuthentication(String code, Emitter<SessionState> emit) async {
    final state = this.state;
    assert(state is CodeNeededFromUser, 'Received an unexpected request to complete session with code');
    if (state is CodeNeededFromUser) {
      final credential = await state.getUserCredentialFromCode(code);
      final session = await _getSession(credential);
      emit(SessionActive(session));
    }
  }

  Future<Session> _getSession(UserCredential credential) async {
    final user = credential.user!;
    return sessionRepository.authenticate(
      await user.getIdToken(), user.phoneNumber!);
  }

  Future<void> _onVerificationCompleted(PhoneAuthCredential phoneAuthCredential, Emitter<SessionState> emit) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
      final session = await _getSession(credential);
      emit(SessionActive(session));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }
}
