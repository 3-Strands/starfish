import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_group_action.g.dart';

@HiveType(typeId: 13)
class HiveGroupAction extends HiveObject {
  @HiveField(0)
  String? groupId;
  @HiveField(1)
  String? actionId;
  @HiveField(2)
  HiveDate? dueDate;

  HiveGroupAction({
    this.groupId,
    this.actionId,
    this.dueDate,
  });

  // HiveGroupAction.from(GroupAction action) {
  //   this.groupId = action.groupId;
  //   this.actionId = action.actionId;
  //   this.dueDate = HiveDate.from(action.dueDate);
  // }

  // GroupAction toGroupAction() {
  //   return GroupAction(
  //       groupId: this.actionId,
  //       actionId: this.actionId,
  //       dueDate: this.dueDate?.toDate());
  // }

  @override
  String toString() {
    return '{ groupId: ${this.groupId}, actionId: ${this.actionId}, dueDate: ${this.dueDate} }';
  }
}
