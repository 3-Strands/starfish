part of 'user_action_cubit.dart';

enum UserActionError {
  noMonth,
}

@immutable
class UserActionState {
  const UserActionState({
    required this.action,
    required this.user,
    required this.status,
    required this.evaluation,
    required this.teacherResponse,
    required this.userResponse,
    this.error,
  });

  final Action action;
  final User user;
  final ActionUser_Status status;
  final ActionUser_Evaluation evaluation;
  final String teacherResponse;
  final String userResponse;

  final UserActionError? error;

  UserActionState copywith(
          {Action? action,
          User? user,
          ActionUser_Status? status,
          ActionUser_Evaluation? evaluation,
          String? teacherResponse,
          String? userResponse,
          UserActionError? error}) =>
      UserActionState(
        action: action ?? this.action,
        user: user ?? this.user,
        status: status ?? this.status,
        evaluation: evaluation ?? this.evaluation,
        teacherResponse: teacherResponse ?? this.teacherResponse,
        userResponse: userResponse ?? this.userResponse,
        error: error,
      );
}
