import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/models/user.dart';
import 'package:starfish/repositories/model_wrappers/group_with_actions_and_roles.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

extension AsList<T> on Box<T> {
  List<T> asList() => values.toList();
}

class DataRepository {
  DataRepository({
    HiveApiInterface hiveApi = globalHiveApi,
    required AppUser user,
  })  : _hiveApi = hiveApi,
        _userId = user.id;

  final HiveApiInterface _hiveApi;
  final String _userId;

  Stream<List<T>> _streamBox<T>(Box<T> box) =>
      box.watch().map((_) => box.asList());

  void addDelta(DeltaBase delta) {
    // TODO: Save the generated request in the DB.
    delta.apply();
  }

  User get currentUser => _hiveApi.user.get(_userId)!;

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

  List<GroupWithActionsAndRoles> getGroupsWithActionsAndRoles() {
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

    return currentGroups.map((group) {
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
        admin: groupAdmin == null ? null : _hiveApi.user.get(groupAdmin.userId),
        teacher: groupTeacher == null
            ? null
            : _hiveApi.user.get(groupTeacher.userId),
        myRole: group.users.firstWhere((user) => user.userId == _userId).role,
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

  Stream<List<Action>> getActionsByGroup(Group group) {
    throw UnimplementedError();
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
