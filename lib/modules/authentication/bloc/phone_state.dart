part of 'phone_bloc.dart';

@immutable
class PhoneState {
  final String number;
  final bool isValid;

  const PhoneState(this.number, [this.isValid = false]);

  PhoneState copyWith({String? number, bool? isValid}) =>
    PhoneState(number ?? this.number, isValid ?? this.isValid);
}
