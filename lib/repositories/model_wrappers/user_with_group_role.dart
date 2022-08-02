import 'package:starfish/src/grpc_extensions.dart';

class UserWithGroupRole {
  const UserWithGroupRole(this.user, this.groupUser);

  final User user;
  final GroupUser groupUser;
}
