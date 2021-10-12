import 'package:hive/hive.dart';
import 'package:starfish/repository/user_repository.dart';
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
  @HiveField(3)
  bool isNew = false;
  @HiveField(4)
  bool isUpdated = false;
  @HiveField(5)
  bool isDirty = false;

  HiveGroupUser({
    this.groupId,
    this.userId,
    this.role,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
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

extension HiveGroupUserExt on HiveGroupUser {
  String get name {
    return UserRepository().dbProvider.getName(this.userId!);
  }

  String get phone {
    return UserRepository().dbProvider.getPhone(this.userId!);
  }

  String get diallingCode {
    return UserRepository().dbProvider.getDiallingCode(this.userId!);
  }
}
