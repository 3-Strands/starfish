import 'package:hive/hive.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/repository/group_repository.dart';
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
    return '''{groupId: ${this.groupId}, userId: ${this.userId}, role: ${GroupUser_Role.valueOf(this.role!)}, 
    isNew: ${this.isNew}, , isUpdated: ${this.isUpdated}, , isDirty: ${this.isDirty}}''';
  }
}

extension HiveGroupUserExt on HiveGroupUser {
  HiveUser? get user {
    return UserRepository().dbProvider.getUserById(this.userId!);
  }

  HiveGroup? get group {
    return GroupRepository().dbProvider.getGroupById(this.groupId!);
  }

  String get name {
    return user != null ? user!.name! : user!.id!;
  }

  String get phone {
    return user != null ? user!.phone! : '';
  }

  String get diallingCode {
    return user != null ? user!.diallingCode! : '';
  }

  bool get isInvited {
    return user != null &&
        User_Status.valueOf(user!.status!)! != User_Status.ACTIVE;
  }

  String get phoneWithDialingCode {
    return user != null ? user!.phoneWithDialingCode : '';
  }
}
