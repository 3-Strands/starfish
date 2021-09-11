import 'package:hive/hive.dart';

part 'hive_action.g.dart';

@HiveType(typeId: 4)
class HiveAction {
  @HiveField(0)
  String actionId;
  @HiveField(1)
  String userId;
  @HiveField(2)
  String status;
  @HiveField(3)
  String teacherResponse;

  HiveAction(
      {required this.actionId,
      required this.userId,
      required this.status,
      required this.teacherResponse});
}
