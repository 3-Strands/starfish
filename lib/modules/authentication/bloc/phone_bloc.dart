import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'phone_event.dart';
part 'phone_state.dart';

class PhoneBloc extends Bloc<PhoneEvent, PhoneState> {
  PhoneBloc() : super(PhoneState('')) {
    on<NumberChanged>((event, emit) {
      if (event.number != state.number) {
        emit(state.copyWith(number: event.number));
      }
    });
    on<ValidityChanged>((event, emit) {
      if (event.isValid != state.isValid) {
        emit(state.copyWith(isValid: event.isValid));
      }
    });
  }
}
