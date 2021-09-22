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
  String? role;

  HiveGroupUser.from(GroupUser group) {
    this.groupId = group.groupId;
    this.userId = group.userId;
    this.role = group.role as String;
  }

  HiveGroupUser({
    this.groupId,
    this.userId,
    this.role,
  });

  String toString() {
    return '{groupId: ${this.groupId}, userId: ${this.userId}, role: ${this.role}}';
  }
}
