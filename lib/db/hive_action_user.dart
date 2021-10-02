import 'package:hive/hive.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_action_user.g.dart';

@HiveType(typeId: 15)
class HiveActionUser {
  @HiveField(0)
  String? actionId;
  @HiveField(1)
  String? userId;
  @HiveField(2) // ActionUser_Status
  int? status;
  @HiveField(3)
  String? teacherResponse;

  HiveActionUser(
      {this.actionId, this.userId, this.status, this.teacherResponse});

  HiveActionUser.from(ActionUser actionUser) {
    this.actionId = actionUser.actionId;
    this.userId = actionUser.userId;
    this.status = actionUser.status.value;
    this.teacherResponse = actionUser.teacherResponse;
  }

  ActionUser toActionUser() {
    return ActionUser(
        actionId: this.actionId,
        userId: this.userId,
        status: ActionUser_Status.valueOf(this.status!),
        teacherResponse: this.teacherResponse);
  }

  String toString() {
    return '{ actionId: ${this.actionId}, userId: ${this.userId}, status: ${this.status}, teacherResponse: ${this.teacherResponse} }';
  }
}
