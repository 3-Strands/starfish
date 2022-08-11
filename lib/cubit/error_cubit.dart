import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:starfish/repositories/error_repository.dart';

class ErrorCubit extends Cubit<UserFacingError?> {
  ErrorCubit(this._errorRepository) : super(null) {
    _subscription = _errorRepository.userErrors.listen(emit);
  }

  final ErrorRepository _errorRepository;
  late StreamSubscription _subscription;

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
