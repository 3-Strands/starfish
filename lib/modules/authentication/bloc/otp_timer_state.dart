part of 'otp_timer_bloc.dart';

@immutable
abstract class OtpTimerState {
  const OtpTimerState();
}

class TimerTicking extends OtpTimerState {
  final int secondsRemaining;

  const TimerTicking(this.secondsRemaining);
}

class TimerComplete extends OtpTimerState {
  const TimerComplete();
}
