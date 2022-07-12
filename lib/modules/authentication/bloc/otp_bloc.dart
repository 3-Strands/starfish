import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpChanged, OtpState> {
  OtpBloc() : super(const OtpState('')) {
    on<OtpChanged>((event, emit) {
      emit(OtpState(event.code));
    });
  }
}
