import 'dart:async';

enum Severity {
  low,
  high,
}

enum ErrorType {
  groupMustHaveAdmin,
}

class UserFacingError {
  const UserFacingError(this.type, this.severity);

  final ErrorType type;
  final Severity severity;
}

class ErrorRepository {
  ErrorRepository();

  final _controller = StreamController<UserFacingError>.broadcast();

  Stream<UserFacingError> get userErrors => _controller.stream;

  void addUserFacingError(ErrorType type, {Severity severity = Severity.low}) =>
      _controller.add(UserFacingError(type, severity));

  void dispose() {
    _controller.close();
  }
}
