import 'package:collection/collection.dart';

import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/date_time_utils.dart';

part 'hive_action.g.dart';

@HiveType(typeId: 4)
class HiveAction extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? type;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? creatorId;
  @HiveField(4)
  String? groupId;
  @HiveField(5)
  String? instructions;
  @HiveField(6)
  String? materialId;
  @HiveField(7)
  String? question;
  @HiveField(8)
  HiveDate? dateDue;
  @HiveField(9)
  List<HiveEdit>? editHistory;
  @HiveField(10)
  bool isNew = false;
  @HiveField(11)
  bool isUpdated = false;
  @HiveField(12)
  bool isDirty = false;

  HiveAction({
    this.id,
    this.type,
    this.name,
    this.creatorId,
    this.groupId,
    this.instructions,
    this.materialId,
    this.question,
    this.dateDue,
  });

  HiveAction.from(Action action) {
    this.id = action.id;
    this.type = action.type.value;
    this.name = action.name;
    this.creatorId = action.creatorId;
    this.groupId = action.groupId;
    this.instructions = action.instructions;
    this.materialId = action.materialId;
    this.question = action.question;
    this.dateDue = HiveDate.from(action.dateDue);
    this.editHistory =
        action.editHistory.map((Edit e) => HiveEdit.from(e)).toList();
  }

  Action toAction() {
    return Action(
      id: this.id,
      type: Action_Type.valueOf(this.type!),
      name: this.name,
      creatorId: this.creatorId,
      groupId: this.groupId,
      instructions: this.instructions,
      materialId: this.materialId,
      question: this.question,
      dateDue: this.dateDue!.toDate(),
    );
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, type: ${this.type}, 
    creatorId: ${this.creatorId?.toString()}, groupId: ${this.groupId?.toString()}, 
    instructions: ${this.instructions?.toString()}, materialId: ${this.materialId?.toString()}, 
    question: ${this.question}, dateDue: ${this.dateDue} }''';
  }
}

extension HiveActionExt on HiveAction {
  HiveMaterial? get material {
    return this.materialId != null
        ? MaterialProvider().getMaterialById(this.materialId!)
        : null;
  }

  HiveGroup? get group {
    return this.groupId != null
        ? GroupProvider().getGroupById(this.groupId!)
        : null;
  }

  /*ActionStatus get actionStatus {
    if (this.dateDue == null) {
      return ActionStatus.NOT_DONE;
    }
    // TODO: need to be updated as it depends on if the user have already taken
    // action or not also,
    if (this.dateDue!.toDateTime().isBefore(DateTime.now())) {
      return ActionStatus.OVERDUE;
    } else if (this.dateDue!.toDateTime().isAfter(DateTime.now())) {
      return ActionStatus.NOT_DONE;
    } else {
      return ActionStatus.DONE;
    }
  }*/

  List<HiveUser>? get users {
    if (this.group == null) {
      return null;
    }
    return this
        .group!
        .users
        ?.map((HiveGroupUser groupUser) => groupUser.user!)
        .toList();
  }

  List<HiveUser>? get learners {
    if (this.group == null) {
      return null;
    }
    return this
        .group!
        .users
        ?.where((element) =>
            GroupUser_Role.valueOf(element.role!) == GroupUser_Role.LEARNER)
        .map((HiveGroupUser groupUser) => groupUser.user!)
        .toList();
  }

  bool get isIndividualAction {
    return (groupId == null || groupId!.isEmpty) ? true : false;
  }

  ActionStatus get actionStatus {
    if (this.isIndividualAction) {
      HiveUser? hiveUser = this.users?.firstWhereOrNull(
          (element) => element.id == creatorId && groupId!.isEmpty);

      /*HiveActionUser? hiveActionUser = hiveUser?.actions!.firstWhere(
          (element) => element.userId == creatorId && element.actionId == id);

      ActionUser_Status.valueOf(hiveActionUser!.status!);*/

      return hiveUser != null
          ? hiveUser.actionStatusbyId(this)
          : ActionStatus.UNSPECIFIED_STATUS;
    } else {
      HiveUser? hiveUser = this.users?.firstWhereOrNull(
          (element) => element.id == creatorId && groupId == element);
    }

    return ActionStatus.UNSPECIFIED_STATUS;
  }

  int memberCountByActionStatus(ActionStatus actionStatus) {
    int i = 0;
    this.users?.forEach((element) {
      print("memberCountByActionStatus: ${element.actionStatusbyId(this)}");
      if (element.actionStatusbyId(this) == actionStatus) {
        i++;
      }
    });
    return i;
  }
}
