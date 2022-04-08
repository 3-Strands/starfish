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
}
