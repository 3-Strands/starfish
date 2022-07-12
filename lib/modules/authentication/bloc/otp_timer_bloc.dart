import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_timer_event.dart';
part 'otp_timer_state.dart';

class OtpTimerBloc extends Bloc<OtpTimerEvent, OtpTimerState> {
  OtpTimerBloc(this.seconds) : super(TimerTicking(seconds)) {
    on<Ticked>((event, emit) async {
      final state = this.state;
      if (state is TimerTicking) {
        final secondsRemaining = state.secondsRemaining;
        if (secondsRemaining <= 1) {
          emit(const TimerComplete());
        } else {
          emit(TimerTicking(secondsRemaining - 1));
          _addTickAfterOneSecond();
        }
      }
    });
    on<Reset>((event, emit) {
      emit(TimerTicking(seconds));
      _addTickAfterOneSecond();
    });
    _addTickAfterOneSecond();
  }

  final int seconds;

  void _addTickAfterOneSecond() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!isClosed) {
      add(const Ticked());
    }
  }
}
