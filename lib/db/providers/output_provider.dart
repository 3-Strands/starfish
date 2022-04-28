import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_output.dart';
import 'package:starfish/db/hive_output_marker.dart';

class OutputProvider {
  late Box<HiveOutput> _outputBox;

  OutputProvider() {
    _outputBox = Hive.box<HiveOutput>(HiveDatabase.OUTPUT_BOX);
  }

  HiveOutput? getGroupOutputForMonth(
      String groupId, HiveOutputMarker outputMarker, HiveDate month) {
    return _outputBox.values.firstWhereOrNull((element) =>
        element.groupId! == groupId &&
        element.outputMarker == outputMarker &&
        element.month!.year == month.year &&
        element.month!.month == month.month);
  }

  Future<void> createUpdateOutput(HiveOutput hiveOutput) async {
    int _currentIndex = -1;
    _outputBox.values.toList().asMap().forEach((key, output) {
      if (output.groupId == hiveOutput.groupId &&
          output.outputMarker == hiveOutput.outputMarker &&
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
