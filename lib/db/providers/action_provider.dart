import 'package:hive_flutter/adapters.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_database.dart';

class ActionProvider {
  late Box<HiveAction> _actionBox;

  ActionProvider() {
    _actionBox = Hive.box<HiveAction>(HiveDatabase.ACTIONS_BOX);
  }

  Future<List<HiveAction>> getAllActions(List<String> groupIds) async {
    return _actionBox.values.where((element) {
      return groupIds.contains(element.groupId);
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
}
