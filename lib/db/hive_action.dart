import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/action_user_status.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
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
    question: ${this.question}, dateDue: ${this.dateDue}, isIndividualAction: ${this.isIndividualAction}
    creator: ${this.creator}, group: ${this.group}, actionStatus: ${this.actionStatus}, material: ${this.material} }''';
  }
}

extension HiveActionExt on HiveAction {
  bool get hasValidDueDate {
    return this.dateDue!.year != 0 &&
        this.dateDue!.month != 0 &&
        this.dateDue!.day != 0;
  }

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
        .activeUsers
        ?.map((HiveGroupUser groupUser) => groupUser.user!)
        .toList();
  }

  List<HiveUser>? get learners {
    if (this.group == null) {
      return null;
    }
    return this
        .group!
        .activeUsers
        ?.where((element) =>
            GroupUser_Role.valueOf(element.role!) == GroupUser_Role.LEARNER &&
            element.user != null)
        .map((HiveGroupUser groupUser) => groupUser.user!)
        .toList();
  }

  List<HiveUser>? get leaders {
    // Admin and Teachers
    if (this.group == null) {
      return null;
    }
    return this
        .group!
        .activeUsers
        ?.where((element) =>
            (GroupUser_Role.valueOf(element.role!) == GroupUser_Role.ADMIN ||
                GroupUser_Role.valueOf(element.role!) ==
                    GroupUser_Role.TEACHER) &&
            element.user != null)
        .map((HiveGroupUser groupUser) => groupUser.user!)
        .toList();
  }

  bool get isIndividualAction {
    // action created individual action i.e. for me
    return (groupId == null || groupId!.isEmpty) ? true : false;
  }

  int memberCountByActionStatus(ActionStatus actionStatus) {
    int i = 0;
    this.learners?.forEach((element) {
      if (element.actionStatusbyId(this) == actionStatus) {
        i++;
      }
    });
    return i;
  }

  int learnerCountByEvaluation(ActionUser_Evaluation actionUserEvaluation) {
    int i = 0;
    this.learners?.forEach((element) {
      if (element.actionUserEvaluationById(this) == actionUserEvaluation) {
        i++;
      }
    });
    return i;
  }

  HiveUser? get creator {
    // user created individual action i.e. for me
    HiveUser currentUser = CurrentUserProvider().user;
    if (this.isIndividualAction) {
      return currentUser.id == creatorId ? currentUser : null;
    } else {
      return this
          .group!
          .activeUsers
          ?.firstWhereOrNull((element) =>
              element.groupId == groupId && element.userId == creatorId)
          //?.map((HiveGroupUser groupUser) => groupUser.user!)
          ?.user!;
    }
  }

  ActionStatus get actionStatus {
    /*HiveUser currentUser = CurrentUserProvider().user;

    return currentUser.actionStatusbyId(this);*/

    /*return this.mineAction != null
        ? ActionUser_Status.valueOf(mineAction!.status!)!.convertTo()
        : ActionStatus.NOT_DONE;*/

    HiveActionUser? actionUser = this.mineAction;

    if (actionUser != null) {
      ActionStatus? actionStatus = actionUser.status != null
          ? ActionUser_Status.valueOf(actionUser.status!)!.convertTo()
          : ActionStatus.NOT_DONE;

      //
      if (actionStatus == ActionStatus.DONE) {
        return ActionStatus.DONE;
      }
    }

    // We need to check if the action is not done yet, if it's overdue or not
    if (this.dateDue == null || !this.hasValidDueDate) {
      return ActionStatus.NOT_DONE;
    } else if (this.dateDue != null &&
        this
            .dateDue!
            .toDateTime()
            .isBefore(DateTimeUtils.toHiveDate(DateTime.now()).toDateTime())) {
      return ActionStatus.OVERDUE;
    } else {
      return ActionStatus.NOT_DONE;
    }
  }

  HiveActionUser? get mineAction {
    HiveCurrentUser _currentUser = CurrentUserRepository().getUserSyncFromDB();
    HiveActionUser? hiveActionUser = _currentUser.actions
        .firstWhereOrNull((element) => element.actionId == this.id);

    // Check if action is only in local DB
    if (hiveActionUser == null) {
      hiveActionUser = ActionRepository()
          .getAllActionsUser()
          .firstWhereOrNull((element) => element.actionId == this.id);
    }

    return hiveActionUser;
  }
  /*ActionStatus get actionStatus {
    HiveUser? hiveUser;
    if (this.isIndividualAction) {
      hiveUser = this.creator;

      HiveActionUser? hiveActionUser = hiveUser?.actions!.firstWhere(
          (element) => element.userId == creatorId && element.actionId == id);

      ActionUser_Status.valueOf(hiveActionUser!.status!);

    } else {
      hiveUser = this.group!.users?.firstWhereOrNull(
          (element) => element.id == creatorId && groupId == element.);
      HiveUser currentUser = CurrentUserProvider().user;
      hiveUser = this
          .group!
          .users
          ?.where((HiveGroupUser element) =>
              element.groupId == groupId && element.userId == currentUser.id)
          .map((HiveGroupUser groupUser) => groupUser.user!)
          .first;
    }

    return hiveUser != null
        ? hiveUser.actionStatusbyId(this)
        : ActionStatus.UNSPECIFIED_STATUS;
  }*/
}
