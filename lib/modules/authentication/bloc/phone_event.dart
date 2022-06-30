part of 'phone_bloc.dart';

@immutable
abstract class PhoneEvent {
  const PhoneEvent();
}

class NumberChanged extends PhoneEvent {
  final String number;

  const NumberChanged(this.number);
}

class ValidityChanged extends PhoneEvent {
  final bool isValid;

  const ValidityChanged(this.isValid);
}
