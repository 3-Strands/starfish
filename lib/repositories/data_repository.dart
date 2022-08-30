import 'dart:core';

import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/repositories/model_wrappers/action_group_user_with_status.dart';
import 'package:starfish/repositories/model_wrappers/group_with_actions_and_roles.dart';
import 'package:starfish/repositories/model_wrappers/user_with_action_status.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

extension AsList<T> on Box<T> {
  List<T> asList() => values.toList();
}

class DataRepository {
  DataRepository({
    HiveApi hiveApi = globalHiveApi,
    required this.getCurrentUser,
  }) : _hiveApi = hiveApi;

  final HiveApi _hiveApi;
  final User Function() getCurrentUser;

  Stream<List<T>> _streamBox<T>(Box<T> box) => box
      .watch()
      .debounceTime(const Duration(milliseconds: 200))
      .map((_) => box.asList());

  void addDelta(DeltaBase delta) {
    // TODO: Save the generated request in the DB.
    print(delta);
    delta.apply();
  }

  User get currentUser => getCurrentUser();

  // ------------------- Materials -------------------

  Stream<List<Material>> get materials => _streamBox(_hiveApi.material);
  List<Material> get currentMaterials => _hiveApi.material.asList();

  Stream<List<MaterialTopic>> get materialTopics =>
      _streamBox(_hiveApi.materialTopic);
  List<MaterialTopic> get currentMaterialTopics =>
      _hiveApi.materialTopic.asList();

  Stream<List<MaterialType>> get materialTypes =>
      _streamBox(_hiveApi.materialType);
  List<MaterialType> get currentMaterialTypes => _hiveApi.materialType.asList();

  // ------------------- Groups -------------------

  Stream<List<Group>> get groups => _streamBox(_hiveApi.group);
  List<Group> get currentGroups => _hiveApi.group.asList();

  Stream<List<EvaluationCategory>> get evaluationCategories =>
      _streamBox(_hiveApi.evaluationCategory);
  List<EvaluationCategory> get currentEvaluationCategories =>
      _hiveApi.evaluationCategory.asList();

  List<Group> get groupsWithAdminRole {
    final List<Group> _groupsWithAdminRole = [];
    final userId = getCurrentUser().id;
    for (final group in currentGroups) {
      for (final groupUser in group.users) {
        if (groupUser.userId == userId &&
                groupUser.role == GroupUser_Role.ADMIN ||
            groupUser.role == GroupUser_Role.TEACHER) {
          _groupsWithAdminRole.add(group);
          break;
        }
      }
    }
    return _groupsWithAdminRole;
  }

  List<GroupWithActionsAndRoles> getGroupsWithActionsAndRoles() {
    final userId = getCurrentUser().id;

    final completedActions = <String, int>{};
    for (final actionUser in _hiveApi.actionUser.values) {
      completedActions[actionUser.actionId] =
          (completedActions[actionUser.actionId] ?? 0) + 1;
    }

    final actionsByGroup = <String, List<_ActionInfo>>{};

    for (final action in _hiveApi.action.values) {
      if (action.hasGroupId()) {
        (actionsByGroup[action.groupId] ??= []).add(
          _ActionInfo(completedActions[action.id] ?? 0, action.isPastDueDate),
        );
      }
    }

    final myRoleByGroup = <String, GroupUser_Role>{};
    for (final group in currentGroups) {
      for (final groupUser in group.users) {
        if (groupUser.userId == userId) {
          myRoleByGroup[group.id] = groupUser.role;
          break;
        }
      }
    }

    return currentGroups
        .where((group) => myRoleByGroup.containsKey(group.id))
        .map((group) {
      final totalUsers = group.users.length;

      var completedActions = 0;
      var incompleteActions = 0;
      var overdueActions = 0;

      actionsByGroup[group.id]?.forEach((actionInfo) {
        completedActions += actionInfo.numCompleted;
        final remaining = totalUsers - actionInfo.numCompleted;
        if (actionInfo.isOverdue) {
          overdueActions += remaining;
        } else {
          incompleteActions += remaining;
        }
      });

      final groupAdmin = group.users
          .firstWhereOrNull((user) => user.role == GroupUser_Role.ADMIN);
      final groupTeacher = group.users
          .firstWhereOrNull((user) => user.role == GroupUser_Role.TEACHER);

      return GroupWithActionsAndRoles(
        group: group,
        completedActions: completedActions,
        incompleteActions: incompleteActions,
        overdueActions: overdueActions,
        admin: groupAdmin?.maybeUser,
        teacher: groupTeacher?.maybeUser,
        myRole: myRoleByGroup[group.id]!,
      );
    }).toList();
  }

  List<Action> getAllActiveActions() {
    return _hiveApi.action.values.where((action) {
      // Exclude deleted actions
      // if (action.isDirty) {
      //   return false;
      // }
      return action.group?.status != Group_Status.INACTIVE;
    }).toList();
  }

  List<Action> getMyActions() {
    // final actionIdsAssignedToMyGroups = <String>{};
    // for (final group in _hiveApi.group.values) {
    //   group.actions?.forEach((groupAction) {
    //     final actionId = groupAction.actionId;
    //     if (actionId != null) {
    //       actionIdsAssignedToMyGroups.add(actionId);
    //     }
    //   });
    // }
    // final myGroups = _hiveApi.group.values.map((group) => group.id).toSet();
    return _hiveApi.action.values
        .where(
          (action) =>
              action.isIndividualAction ||
              _hiveApi.group.containsKey(action.groupId),
        )
        .toList();
  }

  Map<String, ActionUser_Status> getMyActionStatuses() {
    return Map.fromEntries(currentUser.actions
        .map((userAction) => MapEntry(userAction.actionId, userAction.status)));
    // if (this.dateDue == null || !this.hasValidDueDate) {
    //   return ActionStatus.NOT_DONE;
    // } else if (this.dateDue != null &&
    //     this
    //         .dateDue
    //         .toDateTime()
    //         .isBefore(HiveDate.fromDateTime(DateTime.now()).toDateTime())) {
    //   return ActionStatus.OVERDUE;
    // } else {
    //   return ActionStatus.NOT_DONE;
    // }
  }

  // Returns 'ActionUsers' for the current user
  Map<String, ActionUser> getMyActionUsers() {
    return Map.fromEntries(currentUser.actions
        .map((userAction) => MapEntry(userAction.actionId, userAction)));
  }

  RelatedMaterials getMaterialsRelatedToMe() {
    final actionStatuses = getMyActionStatuses();
    final materialsAssignedToMe = <String, ActionStatus>{};
    final materialsAssignedToGroupWithLeaderRole = <String>{};
    for (final action in getMyActions()) {
      final materialId = action.materialId;
      if (materialId.isNotEmpty) {
        if (action.isIndividualAction) {
          final status =
              actionStatuses[action.id] ?? ActionUser_Status.INCOMPLETE;
          materialsAssignedToMe[materialId] =
              status == ActionUser_Status.COMPLETE
                  ? ActionStatus.DONE
                  : action.isPastDueDate
                      ? ActionStatus.OVERDUE
                      : ActionStatus.NOT_DONE;
        } else {
          materialsAssignedToGroupWithLeaderRole.add(materialId);
        }
      }
    }
    return RelatedMaterials(
        materialsAssignedToMe, materialsAssignedToGroupWithLeaderRole);
  }

  // bool isMaterialAssignedToMe(Material material) =>
  //   getAllActiveActions().any(
  //     (action) => action.isIndividualAction && action.materialId == material.id,
  //   );

  // bool isMaterialAssignedToGroupWithLeaderRole(Material material) =>
  //   getAllActiveActions().any(
  //     (action) => !action.isIndividualAction &&
  //         (action)
  //   );

  // ------------------- Actions -------------------
  Stream<List<Action>> get actions => _streamBox(_hiveApi.action);
  List<Action> get currentActions => _hiveApi.action.asList();

  RelatedActions getActionsRelatedToMe() {
    final actionStatuses = getMyActionStatuses();
    final myActionUsers = getMyActionUsers();
    final actionsAssignedToMe = <String, ActionStatus>{};
    final actionsAssignedToGroupWithLeaderRole = <String>{};
    //final List<ActionGroupUserWithStatus> actionGroups = [];
    final actionGroups = <String, ActionGroupUserWithStatus>{};

    for (final action in getMyActions()) {
      final actionId = action.id;
      final groupId = action.groupId;
      if (action.isIndividualAction) {
        final status =
            actionStatuses[action.id] ?? ActionUser_Status.INCOMPLETE;

        actionsAssignedToMe[actionId] = status == ActionUser_Status.COMPLETE
            ? ActionStatus.DONE
            : action.isPastDueDate
                ? ActionStatus.OVERDUE
                : ActionStatus.NOT_DONE;
      } else {
        actionsAssignedToGroupWithLeaderRole.add(actionId);
      }
      Group? _group = _hiveApi.group.values
          .firstWhereOrNull((element) => element.id == groupId);
      if (_group != null) {
        List<UserWithActionStatus> _usersWithStatus = _group.learners
            .map((user) => UserWithActionStatus(
                user: user,
                action: action,
                actionUser: _getUserAction(user.id, action)))
            .toList();
        actionGroups[actionId] = ActionGroupUserWithStatus(
            group: _group, userWithActionStatus: _usersWithStatus);
      }
    }
    return RelatedActions(actionsAssignedToMe,
        actionsAssignedToGroupWithLeaderRole, actionGroups, myActionUsers);
  }

  ActionUser? _getUserAction(String userId, Action action) {
    return globalHiveApi.user
        .get(userId)
        ?.actions
        .firstWhereOrNull((actionUser) => actionUser.actionId == action.id);
  }

  ActionStatus _getActionStatus(String userId, Action action) {
    ActionUser_Status status = globalHiveApi.user
            .get(userId)
            ?.actions
            .firstWhereOrNull((actionUser) => actionUser.actionId == action.id)
            ?.status ??
        ActionUser_Status.INCOMPLETE;

    return status == ActionUser_Status.COMPLETE
        ? ActionStatus.DONE
        : action.isPastDueDate
            ? ActionStatus.OVERDUE
            : ActionStatus.NOT_DONE;
  }

  Stream<List<Action>> getActionsByGroup(Group group) {
    throw UnimplementedError();
  }

  // ------------------- Actions -------------------
  Stream<List<ActionUser>> get actionUsers => _streamBox(_hiveApi.actionUser);
  List<ActionUser> get currentActionUsers => _hiveApi.actionUser.asList();

  // ------------------- Transformations ---------------------
  Stream<List<Transformation>> get transformations =>
      _streamBox(_hiveApi.transformation);
  List<Transformation> get currentTransformations =>
      _hiveApi.transformation.asList();

  RelatedTransformation getTransformationRelatedToUser(String userId) {
    return RelatedTransformation(globalHiveApi.transformation.values
        .where((transformation) => transformation.userId == userId)
        .toList());
  }
  // ------------------- Countries -------------------

  Stream<List<Country>> get countries => _streamBox(_hiveApi.country);
  List<Country> get currentCountries => _hiveApi.country.asList();

  // ------------------- Languages -------------------

  Stream<List<Language>> get languages => _streamBox(_hiveApi.language);
  List<Language> get currentLanguages => _hiveApi.language.asList();

  void addUserLanguages(Set<String> languageIds) {
    throw UnimplementedError();
  }

  void updateUserLanguages(List<String> languageIds) {
    throw UnimplementedError();
  }
}

class RelatedMaterials {
  RelatedMaterials(
      this.materialsAssignedToMe, this.materialsAssignedToGroupWithLeaderRole);

  final Map<String, ActionStatus> materialsAssignedToMe;
  final Set<String> materialsAssignedToGroupWithLeaderRole;
}

class _ActionInfo {
  final int numCompleted;
  final bool isOverdue;

  const _ActionInfo(this.numCompleted, this.isOverdue);
}

class RelatedActions {
  RelatedActions(
      this.actionsAssignedToMe,
      this.actionsAssignedToGroupWithLeaderRole,
      this.actionGroupUsersWithStatus,
      this.myActionUsers);

  final Map<String, ActionUser> myActionUsers;
  final Map<String, ActionStatus> actionsAssignedToMe;
  final Set<String> actionsAssignedToGroupWithLeaderRole;
  final Map<String, ActionGroupUserWithStatus> actionGroupUsersWithStatus;
}

class RelatedTransformation {
  RelatedTransformation(this.transformations);

  final List<Transformation> transformations;
}
