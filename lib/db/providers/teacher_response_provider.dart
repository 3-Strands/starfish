import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_teacher_response.dart';

class TeacherResponseProvider {
  late Box<HiveTeacherResponse> _teacherResponseBox;

  TeacherResponseProvider() {
    _teacherResponseBox =
        Hive.box<HiveTeacherResponse>(HiveDatabase.TEACHER_RESPONSE_BOX);
  }

  List<HiveTeacherResponse> getGroupUserTeacherResponse(
      String userId, String groupId) {
    return _teacherResponseBox.values
        .where((element) =>
            element.learnerId! == userId && element.groupId! == groupId)
        .toList();
  }

  Future<void> createUpdateTeacherResponse(
      HiveTeacherResponse _teacherResponse) async {
    int _currentIndex = -1;
    _teacherResponseBox.values.toList().asMap().forEach((key, feedback) {
      if (feedback.id == _teacherResponse.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _teacherResponseBox.putAt(_currentIndex, _teacherResponse);
    } else {
      _teacherResponseBox.add(_teacherResponse);
    }
  }
}
