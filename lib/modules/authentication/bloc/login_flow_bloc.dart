import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/utils/option.dart';

part 'login_flow_event.dart';
part 'login_flow_state.dart';

class LoginFlowBloc extends Bloc<LoginFlowEvent, LoginFlowState> {
  LoginFlowBloc({
    required this.authenticationRepository,
  }) : super(const LoginFlowState()) {
    on<SignInRequested>((event, emit) async {
      emit(state.copyWith(isPending: true));
      final otpHandler = await authenticationRepository.authenticate(event.phoneNumber);
      emit(state.copyWith(
        otpHandler: Option(otpHandler),
        isPending: false,
      ));
    });
    on<PhoneVerificationFailed>((event, emit) {
      emit(state.copyWith(
        errorCode: Option.some(event.code ?? ''),
        isPending: false,
      ));
    });
    on<SMSCodeRefreshRequested>((event, emit) async {
      final otpHandler = state.otpHandler.value;
      assert(otpHandler != null, 'Received a request to refresh the session while not in an OTP state');
      emit(state.copyWith(isPending: true));
      final newOtpHandler = await otpHandler!.resendOtp();
      emit(state.copyWith(
        otpHandler: Option(newOtpHandler),
        isPending: false,
      ));
    });
    on<SMSCodeEntered>((event, emit) async {
      final otpHandler = state.otpHandler.value;
      assert(otpHandler != null, 'Received a request to complete the session while not in an OTP state');
      emit(state.copyWith(isPending: true));
      await otpHandler!.authenticateWithCode(event.code);
      emit(state.copyWith(isPending: false));
    });
  }

  final AuthenticationRepository authenticationRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    final code = error is AuthenticationException ? error.code : null;
    print(error);
    add(PhoneVerificationFailed(code));
    super.onError(error, stackTrace);
  }
}
