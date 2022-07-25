import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/material_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/action_user_status.dart';
import 'package:starfish/models/user.dart';
import 'package:starfish/repository/action_repository.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/date_time_utils.dart';
// import 'package:starfish_annotations/starfish_annotations.dart';

import 'hive_concrete.dart';
import 'hive_syncable.dart';

part 'hive_action.g.dart';

// @starfishGen
@HiveType(typeId: 4)
class HiveAction extends HiveConcrete implements HiveSyncable<Action> {
  // @primary
  @HiveField(0)
  final String id;
  @HiveField(1)
  int type;
  @HiveField(2)
  String name;
  @HiveField(3)
  final String creatorId;
  @HiveField(4)
  String groupId;
  @HiveField(5)
  String instructions;
  @HiveField(6)
  String materialId;
  @HiveField(7)
  String question;
  @HiveField(8)
  HiveDate dateDue;
  @HiveField(9)
  List<HiveEdit> editHistory;
  @HiveField(10)
  bool isNew = false;
  @HiveField(11)
  bool isUpdated = false;
  @HiveField(12)
  bool isDirty = false;
  @HiveField(13)
  HiveDate? createdDate;

  HiveAction({
    required this.id,
    required this.type,
    required this.name,
    required this.creatorId,
    this.groupId = '',
    this.instructions = '',
    this.materialId = '',
    this.question = '',
    this.dateDue = HiveDate.none,
    this.createdDate,
    this.editHistory = const [],
  });

  HiveAction.from(Action action)
      : id = action.id,
        type = action.type.value,
        name = action.name,
        creatorId = action.creatorId,
        groupId = action.groupId,
        instructions = action.instructions,
        materialId = action.materialId,
        question = action.question,
        dateDue = HiveDate.from(action.dateDue),
        editHistory = action.editHistory.map(HiveEdit.from).toList();

  static void populateBox(Action action) {
    final hiveAction = HiveAction.from(action);
    globalHiveApi.action.put(hiveAction.key, hiveAction);
  }

  bool isDueInMonth(HiveDate hiveDate) {
    return dateDue.year == hiveDate.year && dateDue.month == hiveDate.month;
  }

  bool dueDateIsOrAfterMonth(HiveDate hiveDate) {
    return dateDue.year >= hiveDate.year &&
        dateDue.month >= hiveDate.month &&
        createdOn.year <= hiveDate.year &&
        createdOn.month <= hiveDate.month;
  }

  HiveGroup? get group =>
      groupId.isNotEmpty ? globalHiveApi.group.get(groupId) : null;

  HiveMaterial? get material =>
      materialId.isNotEmpty ? globalHiveApi.material.get(materialId) : null;

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, type: ${this.type}, 
    creatorId: ${this.creatorId.toString()}, groupId: ${this.groupId.toString()}, 
    instructions: ${this.instructions.toString()}, materialId: ${this.materialId.toString()}, 
    question: ${this.question}, dateDue: ${this.dateDue}, isIndividualAction: ${this.isIndividualAction}
    group: ${this.group}, actionStatus: ${this.actionStatus}, material: ${this.material}, createdDate: ${this.createdDate} }''';
  }

  @override
  Action toGrpcCompatible() {
    return Action(
      id: this.id,
      type: Action_Type.valueOf(this.type),
      name: this.name,
      creatorId: this.creatorId,
      groupId: this.groupId,
      instructions: this.instructions,
      materialId: this.materialId,
      question: this.question,
      dateDue: this.dateDue.toDate(),
    );
  }
}

extension HiveActionExt on HiveAction {
  bool get hasValidDueDate {
    return this.dateDue.year != 0 &&
        this.dateDue.month != 0 &&
        this.dateDue.day != 0;
  }

  HiveDate get createdOn {
    HiveEdit? _edit = editHistory.firstWhereOrNull((HiveEdit element) =>
        Edit_Event.valueOf(element.event!) == Edit_Event.CREATE);

    return _edit != null ? HiveDate.fromDateTime(_edit.time!) : createdDate!;
  }

  HiveMaterial? get material {
    return MaterialProvider().getMaterialById(this.materialId);
  }

  HiveGroup? get group {
    return this.groupId != null
        ? GroupProvider().getGroupById(this.groupId)
        : null;
  }

  // List<HiveUser>? get users {
  //   if (this.group == null || this.group!.activeUsers == null) {
  //     return null;
  //   }
  //   List<HiveUser> _users = [];
  //   this.group!.activeUsers!.forEach((HiveGroupUser groupUser) {
  //     _users.add(groupUser.user!);
  //   });

  //   return _users;
  // }

  // List<HiveUser>? get learners {
  //   if (this.group == null || this.group?.learners == null) {
  //     return null;
  //   }
  //   List<HiveUser> _learners = [];
  //   this.group!.learners!.forEach((HiveGroupUser groupUser) {
  //     if (groupUser.user != null) {
  //       _learners.add(groupUser.user!);
  //     }
  //   });

  //   return _learners;
  // }

  // List<HiveUser>? get leaders {
  //   // Admin and Teachers
  //   if (this.group == null || this.group!.activeUsers == null) {
  //     return null;
  //   }
  //   List<HiveUser> _leaders = [];

  //   this
  //       .group!
  //       .activeUsers
  //       ?.where((element) => (GroupUser_Role.valueOf(element.role!) ==
  //               GroupUser_Role.ADMIN ||
  //           GroupUser_Role.valueOf(element.role!) == GroupUser_Role.TEACHER))
  //       .forEach((groupUser) {
  //     if (groupUser.user != null) {
  //       _leaders.add(groupUser.user!);
  //     }
  //   });
  //   return _leaders;
  // }

  bool get isIndividualAction {
    return groupId.isEmpty;
  }

  // int memberCountByActionStatus(ActionStatus actionStatus) {
  //   int i = 0;
  //   this.learners?.forEach((element) {
  //     if (element.actionStatusbyId(this) == actionStatus) {
  //       i++;
  //     }
  //   });
  //   return i;
  // }

  // int learnerCountByEvaluation(ActionUser_Evaluation actionUserEvaluation) {
  //   int i = 0;
  //   this.learners?.forEach((element) {
  //     if (element.actionUserEvaluationById(this) == actionUserEvaluation) {
  //       i++;
  //     }
  //   });
  //   return i;
  // }

  // HiveUser? get creator {
  //   // user created individual action i.e. for me
  //   HiveUser currentUser = CurrentUserProvider().user;
  //   if (this.isIndividualAction) {
  //     return currentUser.id == creatorId ? currentUser : null;
  //   } else {
  //     return this
  //         .group!
  //         .activeUsers
  //         ?.firstWhereOrNull((element) =>
  //             element.groupId == groupId && element.userId == creatorId)
  //         //?.map((HiveGroupUser groupUser) => groupUser.user!)
  //         ?.user!;
  //   }
  // }

  ActionStatus get actionStatus {
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
            .dateDue
            .toDateTime()
            .isBefore(HiveDate.fromDateTime(DateTime.now()).toDateTime())) {
      return ActionStatus.OVERDUE;
    } else {
      return ActionStatus.NOT_DONE;
    }
  }

  HiveActionUser? get mineAction {
    // TODO
    return null;
    // AppUser _currentUser = CurrentUserRepository().getUserSyncFromDB();
    // HiveActionUser? hiveActionUser = _currentUser.actions
    //     .firstWhereOrNull((element) => element.actionId == this.id);

    // // Check if action is only in local DB
    // if (hiveActionUser == null) {
    //   hiveActionUser = ActionRepository()
    //       .getAllActionsUser()
    //       .firstWhereOrNull((element) => element.actionId == this.id);
    // }

    // return hiveActionUser;
  }

  List<HiveActionUser>? get actionsUsers {
    return ActionProvider().getAllActionsUser();
  }
}
