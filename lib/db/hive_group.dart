import 'dart:core';
import 'package:collection/collection.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group_action.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_output.dart';
import 'package:starfish/db/hive_output_marker.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/db/providers/group_provider.dart';
import 'package:starfish/db/providers/learner_evaluation_provider.dart';
import 'package:starfish/db/providers/output_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/select_items/select_drop_down.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_group.g.dart';

@HiveType(typeId: 12)
class HiveGroup extends HiveObject implements Named {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? linkEmail;
  @HiveField(4)
  List<String>? languageIds;
  @HiveField(5)
  List<HiveGroupUser>? users;
  @HiveField(6)
  List<String>? evaluationCategoryIds;
  @HiveField(7)
  List<HiveGroupAction>? actions;
  @HiveField(8)
  int? status;
  @HiveField(9)
  List<HiveOutputMarker>? outputMarkers;
  @HiveField(10)
  List<HiveEdit>? editHistory;
  @HiveField(11)
  bool isNew = false;
  @HiveField(12)
  bool isUpdated = false;
  @HiveField(13)
  bool isDirty = false; //Deprecated
  @HiveField(14)
  bool isMe = false;

  HiveGroup({
    this.id,
    this.name,
    this.description,
    this.linkEmail,
    this.languageIds,
    this.users,
    this.evaluationCategoryIds,
    this.actions,
    this.status = 0, // Group_Status.ACTIVE,
    this.outputMarkers,
    this.editHistory,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
    this.isMe = false,
  });

  HiveGroup.from(Group group) {
    this.id = group.id;
    this.name = group.name;
    this.description = group.description;
    this.linkEmail = group.linkEmail;
    this.languageIds = group.languageIds;
    this.users =
        group.users.map((GroupUser user) => HiveGroupUser.from(user)).toList();
    this.evaluationCategoryIds = group.evaluationCategoryIds;
    this.status = group.status.value;
    this.outputMarkers = group.outputMarkers
        .map((OutputMarker outputMarker) => HiveOutputMarker.from(outputMarker))
        .toList();
    // this.actions = group.actions
    //     .map((GroupAction action) => HiveGroupAction.from(action))
    //     .toList();
    this.editHistory =
        group.editHistory.map((Edit e) => HiveEdit.from(e)).toList();
  }

  Group toGroup() {
    return Group(
        id: this.id,
        name: this.name,
        description: this.description,
        linkEmail: this.linkEmail,
        languageIds: this.languageIds,
        //users: this.users?.map((HiveGroupUser user) => user.toGroupUser()),
        evaluationCategoryIds: this.evaluationCategoryIds,
        // actions:
        //     this.actions?.map((HiveGroupAction action) => action.toGroupAction()),
        status: Group_Status.valueOf(this.status ?? 0));
  }

  GroupUser_Role? currentUserRole;

  set userRole(GroupUser_Role? role) {
    this.currentUserRole = role;
  }

  GroupUser_Role? get userRole {
    return currentUserRole;
  }

  HiveGroupUser? get admin {
    /*return this.activeUsers?.firstWhereOrNull((groupUser) =>
        GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.ADMIN);*/
    return this.admins?.firstOrNull;
  }

  List<HiveGroupUser>? get admins {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.ADMIN)
        .toList();
  }

  List<HiveGroupUser>? get teachers {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.TEACHER)
        .toList();
  }

  List<HiveGroupUser>? get learners {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.LEARNER)
        .toList();
  }

  List<String>? get teachersName {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.ADMIN ||
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.TEACHER)
        .map((e) => e.name)
        .toList();
  }

  /// Returns all 'HiveGroupUser' where 'isDirty' is false
  List<HiveGroupUser>? get activeUsers {
    return this
        .allGroupUsers
        ?.where((groupUser) => groupUser.isDirty == false)
        .toList();
  }

  // Gives all groupUser i.e. remote user + local users from
  List<HiveGroupUser>? get allGroupUsers {
    if (this.users != null) {
      // filter out the duplicate record.
      List<HiveGroupUser> _users =
          this.users!; // + GroupProvider().getGroupUsersByGroupIdSync(this.id);

      GroupProvider().getGroupUsersByGroupIdSync(this.id).forEach((element) {
        if (this.users!.contains(element) && (element.isUpdated)) {
          _users.firstWhere((hiveUser) => hiveUser == element).role =
              element.role;
        } else if (this.users!.contains(element) && element.isDirty) {
          _users.remove(element);
        } else if (!this.users!.contains(element) &&
            (element.isNew && element.user != null)) {
          // TODO: replace '(element.isNew && element.user != null)' hack to prevend 'Unknown Users'
          _users.add(element);
        }
      });
      return _users;
    }
    return this.users;
  }

  Map<HiveOutputMarker, String> getGroupOutputsForMonth(HiveDate hiveDate) {
    Map<HiveOutputMarker, String> _map = Map();
    this.outputMarkers?.forEach((HiveOutputMarker element) {
      HiveOutput? _output =
          OutputProvider().getGroupOutputForMonth(this.id!, element, hiveDate);
      String _markerValue = _output != null ? _output.value!.toString() : '';
      _map[element] = _markerValue;
    });

    return _map;
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, description: ${this.description}, 
    languageIds: ${this.languageIds?.toString()}, status: ${this.status}, users: ${this.users?.toString()},
    editHistory: ${this.editHistory?.toString()}, currentUserRole: ${this.currentUserRole}, outputMarkers: ${this.outputMarkers} }''';
  }

  @override
  String getName() => name ?? '';
}

extension HiveGroupExt on HiveGroup {
  String get adminName {
    if (this.currentUserRole == GroupUser_Role.ADMIN) {
      return 'Me';
    } else {
      return this.admin != null
          ? (this.admin!.user != null ? this.admin!.user!.name! : 'Unknown')
          : 'NA';
    }
  }

  GroupUser_Role getMyRole(String userId) {
    if (this.users == null) {
      return GroupUser_Role.UNSPECIFIED_ROLE;
    }
    HiveGroupUser? _groupUser = this.users!.firstWhereOrNull(
        (element) => element.userId == userId && !element.isDirty);
    return _groupUser != null
        ? GroupUser_Role.valueOf(_groupUser.role!)!
        : GroupUser_Role.UNSPECIFIED_ROLE;
  }

  bool containsUserName(String query) {
    if (this.activeUsers == null) {
      return false;
    }
    return this
            .activeUsers!
            .where((element) => element.name.toLowerCase().contains(query))
            .length >
        0;
  }

  int getActionsCompletedInMonth(HiveDate month) {
    int count = 0;
    this
        .groupActionList
        ?.where((element) => element.isDueInMonth(month))
        .forEach((hiveAction) =>
            count += hiveAction.memberCountByActionStatus(ActionStatus.DONE));

    return count;
  }

  int getActionsNotYetCompletedInMonth(HiveDate month) {
    int count = 0;
    this
        .groupActionList
        ?.where((element) => element.isDueInMonth(month))
        .forEach((hiveAction) => count +=
            hiveAction.memberCountByActionStatus(ActionStatus.NOT_DONE));

    return count;
  }

  int getActionsOverdueInMonth(HiveDate month) {
    int count = 0;
    this
        .groupActionList
        ?.where((element) => element.isDueInMonth(month))
        .forEach((hiveAction) => count +=
            hiveAction.memberCountByActionStatus(ActionStatus.OVERDUE));

    return count;
  }

  List<HiveAction>? get groupActionList {
    return ActionProvider().getGroupActions(this.id!);
  }

  List<HiveEvaluationCategory> get groupEvaluationCategories {
    List<HiveEvaluationCategory> _categoryies = [];
    this.evaluationCategoryIds?.forEach((e) {
      HiveEvaluationCategory? _category =
          EvaluationCategoryProvider().getCategoryById(e);
      if (_category != null) {
        _categoryies.add(_category);
      }
    });
    return _categoryies;
  }

  List<HiveLearnerEvaluation> get groupLearnerEvaluations {
    return LearnerEvaluationProvider().getGroupLearnerEvaluations(this.id!);
  }

  int get actionsCompleted {
    int count = 0;
    this.groupActionList?.forEach((hiveAction) =>
        count += hiveAction.memberCountByActionStatus(ActionStatus.DONE));

    return count;
  }

  int get actionsNotDoneYet {
    int count = 0;
    this.groupActionList?.forEach((hiveAction) =>
        count += hiveAction.memberCountByActionStatus(ActionStatus.NOT_DONE));

    return count;
  }

  int get actionsOverdue {
    int count = 0;
    this.groupActionList?.forEach((hiveAction) =>
        count += hiveAction.memberCountByActionStatus(ActionStatus.OVERDUE));

    return count;
  }

  // TODO: check if this is needed or not
  int get learnersEvaluationGood {
    int count = 0;
    this.groupActionList?.forEach((hiveAction) => count +=
        hiveAction.learnerCountByEvaluation(ActionUser_Evaluation.GOOD));
    return count;
  }

// TODO: check if this is needed or not
  int get learnersEvaluationNotGood {
    int count = 0;
    this.groupActionList?.forEach((hiveAction) => count +=
        hiveAction.learnerCountByEvaluation(ActionUser_Evaluation.BAD));
    return count;
  }
}
