import 'package:collection/collection.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_user.dart';

class ActionProvider {
  late Box<HiveUser> _userBox;
  late Box<HiveAction> _actionBox;
  late Box<HiveActionUser> _actionUserBox;

  ActionProvider() {
    _userBox = Hive.box<HiveUser>(HiveDatabase.USER_BOX);
    _actionBox = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
    _actionUserBox = Hive.box<HiveActionUser>(HiveDatabase.ACTION_USER_BOX);
  }

  Future<List<HiveAction>> getAllActionsForGroup(List<String> groupIds) async {
    return _actionBox.values.where((element) {
      return groupIds.contains(element.groupId) && !element.isDirty;
    }).toList();
  }

  Future<List<HiveAction>> getAllActionsForMe(List<String> groupIds) async {
    return _actionBox.values.where((element) {
      return (element.isIndividualAction ||
              groupIds.contains(element.groupId)) &&
          !element.isDirty;
    }).toList();
  }

  Future<void> createUpdateAction(HiveAction action) async {
    int _currentIndex = -1;
    _actionBox.values.toList().asMap().forEach((key, hiveAction) {
      if (hiveAction.id == action.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _actionBox.put(_currentIndex, action);
    } else {
      _actionBox.add(action);
    }
  }

  HiveActionUser? getActionUser(String userId, String actionId) {
    // First check in HiveActionUser box, to check for local changes
    // If not found then check in HiveUser's actions attibute
    HiveActionUser? actionUser = _actionUserBox.values
        .firstWhereOrNull((element) => element.userId! == userId);

    if (actionUser != null) {
      return actionUser;
    }

    HiveUser? _hiveUser =
        _userBox.values.firstWhereOrNull((element) => element.id! == userId);

    if (_hiveUser != null) {
      return _hiveUser.actions?.firstWhereOrNull((element) =>
          element.userId! == userId && element.actionId! == actionId);
    }
    return null;
  }

  Future<void> createUpdateActionUser(HiveActionUser actionUser) async {
    int _currentIndex = -1;
    _actionUserBox.values.toList().asMap().forEach((key, hiveActionUser) {
      if (hiveActionUser.actionId == actionUser.actionId &&
          hiveActionUser.userId == actionUser.userId) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      actionUser.isUpdated = true;
      return _actionUserBox.put(_currentIndex, actionUser);
    } else {
      actionUser.isNew = true;
      _actionUserBox.add(actionUser);
    }
  }
}
