import 'package:starfish/src/grpc_extensions.dart';

class GroupWithActionsAndRoles {
  const GroupWithActionsAndRoles({
    required this.group,
    required this.completedActions,
    required this.incompleteActions,
    required this.overdueActions,
    this.admin,
    this.teacher,
    required this.myRole,
  });

  final Group group;
  final int completedActions;
  final int incompleteActions;
  final int overdueActions;
  final User? admin;
  final User? teacher;
  final GroupUser_Role myRole;
}
