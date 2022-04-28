import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_output.dart';

class OutputProvider {
  late Box<HiveOutput> _outputBox;

  OutputProvider() {
    _outputBox = Hive.box<HiveOutput>(HiveDatabase.OUTPUT_BOX);
  }

  List<HiveOutput> getGroupOutputsForMonth(String groupId, HiveDate month) {
    return _outputBox.values
        .where((element) =>
            element.groupId! == groupId &&
            element.month!.year == month.year &&
            element.month!.month == month.month)
        .toList();
  }

  Future<void> createUpdateOutput(HiveOutput hiveOutput) async {
    int _currentIndex = -1;
    _outputBox.values.toList().asMap().forEach((key, output) {
      if (output.groupId == hiveOutput.groupId &&
          output.projectId == hiveOutput.projectId &&
          output.markerId == hiveOutput.markerId &&
          output.month == hiveOutput.month) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _outputBox.putAt(_currentIndex, hiveOutput);
    } else {
      _outputBox.add(hiveOutput);
    }
  }
}
