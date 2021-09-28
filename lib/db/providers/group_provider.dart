import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/modules/groups_view/add_edit_group_screen.dart';

class GroupProvider {
  late Box<HiveGroup> _groupBox;

  GroupProvider() {
    _groupBox = Hive.box<HiveGroup>(HiveDatabase.GROUP_BOX);
  }

  Future<List<HiveGroup>> getGroups() async {
    return _groupBox.values.toList();
  }

  Future<int> addEditGroup(HiveGroup group) async {
    return _groupBox.add(group);
  }
}
