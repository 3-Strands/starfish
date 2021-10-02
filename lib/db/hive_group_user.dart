import 'package:hive/hive.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_group_user.g.dart';

@HiveType(typeId: 3)
class HiveGroupUser {
  @HiveField(0)
  String? groupId;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  int? role;

  HiveGroupUser({
    this.groupId,
    this.userId,
    this.role,
  });

  HiveGroupUser.from(GroupUser group) {
    this.groupId = group.groupId;
    this.userId = group.userId;
    this.role = group.role.value;
  }

  GroupUser toGroupUser() {
    return GroupUser(
      userId: this.userId,
      groupId: this.groupId,
      role: GroupUser_Role.valueOf(this.role!),
    );
  }

  String toString() {
    return '{groupId: ${this.groupId}, userId: ${this.userId}, role: ${GroupUser_Role.valueOf(this.role!)}}';
  }
}
