import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(const OtpState('')) {
    on<OtpEvent>((event, emit) {
      emit(OtpState(event.code));
    });
  }
}
