part of 'otp_timer_bloc.dart';

@immutable
abstract class OtpTimerEvent {
  const OtpTimerEvent();
}

class Ticked extends OtpTimerEvent {
  const Ticked();
}

class Reset extends OtpTimerEvent {
  const Reset();
}
