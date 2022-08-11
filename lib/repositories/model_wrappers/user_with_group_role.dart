import 'package:starfish/src/grpc_extensions.dart';

class UserWithGroupRole {
  const UserWithGroupRole(this.user, this.role);

  final User user;
  final GroupUser_Role role;
}
