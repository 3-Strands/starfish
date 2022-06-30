part of 'otp_bloc.dart';

@immutable
class OtpState {
  const OtpState(this.code);

  final String code;

  bool get isComplete => code.length == 6;
}
