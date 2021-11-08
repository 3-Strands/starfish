import 'package:hive/hive.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_action_user.g.dart';

@HiveType(typeId: 15)
class HiveActionUser extends HiveObject {
  @HiveField(0)
  String? actionId;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  int? status = ActionUser_Status.UNSPECIFIED_STATUS.value;
  @HiveField(3)
  String? teacherResponse;
  @HiveField(4)
  String? userResponse;
  @HiveField(5)
  int? evaluation = ActionUser_Evaluation.UNSPECIFIED_EVALUATION.value;
  @HiveField(6)
  bool isNew = false;
  @HiveField(7)
  bool isUpdated = false;
  @HiveField(8)
  bool isDirty = false;

  HiveActionUser(
      {this.actionId, this.userId, this.status, this.teacherResponse});

  HiveActionUser.from(ActionUser actionUser) {
    this.actionId = actionUser.actionId;
    this.userId = actionUser.userId;
    this.status = actionUser.status.value;
    this.teacherResponse = actionUser.teacherResponse;
    this.userResponse = actionUser.userResponse;
    this.evaluation = actionUser.evaluation.value;
  }

  ActionUser toActionUser() {
    return ActionUser(
        actionId: this.actionId,
        userId: this.userId,
        status: ActionUser_Status.valueOf(this.status!),
        teacherResponse: this.teacherResponse,
        userResponse: this.userResponse,
        evaluation: ActionUser_Evaluation.valueOf(this.evaluation!));
  }

  String toString() {
    return '''{ actionId: ${this.actionId}, userId: ${this.userId}, status: ${this.status}, 
              teacherResponse: ${this.teacherResponse}, teacherResponse: ${this.teacherResponse},
              evaluation: ${this.evaluation} }''';
  }
}
