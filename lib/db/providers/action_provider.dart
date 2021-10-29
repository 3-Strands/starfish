import 'package:hive_flutter/adapters.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_database.dart';

class ActionProvider {
  late Box<HiveAction> _actionBox;
  late Box<HiveActionUser> _actionUserBox;

  ActionProvider() {
    _actionBox = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
    _actionUserBox = Hive.box<HiveActionUser>(HiveDatabase.ACTION_USER_BOX);
  }

  Future<List<HiveAction>> getAllActions(List<String> groupIds) async {
    return _actionBox.values.where((element) {
      return groupIds.contains(element.groupId) && !element.isDirty;
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

  Future<void> createUpdateUserAction(HiveActionUser actionUser) async {
    int _currentIndex = -1;
    _actionUserBox.values.toList().asMap().forEach((key, hiveActionUser) {
      if (hiveActionUser.actionId == actionUser.actionId &&
          hiveActionUser.userId == actionUser.userId) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _actionUserBox.put(_currentIndex, actionUser);
    } else {
      _actionUserBox.add(actionUser);
    }
  }
}
