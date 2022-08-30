import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/user_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_teacher_response.g.dart';

@HiveType(typeId: 19)
class HiveTeacherResponse extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? learnerId;
  @HiveField(2)
  String? teacherId;
  @HiveField(3)
  String? groupId;
  @HiveField(4)
  HiveDate? month;
  @HiveField(5)
  String? response;
  @HiveField(6)
  bool isNew = false;
  @HiveField(7)
  bool isUpdated = false;
  @HiveField(8)
  bool isDirty = false;

  HiveTeacherResponse({
    this.id,
    this.learnerId,
    this.teacherId,
    this.groupId,
    this.month,
    this.response,
  });

  HiveTeacherResponse.from(TeacherResponse teacherResponse) {
    this.id = teacherResponse.id;
    this.learnerId = teacherResponse.learnerId;
    this.teacherId = teacherResponse.teacherId;
    this.groupId = teacherResponse.groupId;
    this.month = HiveDate.from(teacherResponse.month);
    this.response = teacherResponse.response;
  }

  TeacherResponse toTeacherResponse() {
    return TeacherResponse(
      id: this.id,
      learnerId: this.learnerId,
      teacherId: this.teacherId,
      groupId: this.groupId,
      month: this.month?.toDate(),
      response: this.response,
    );
  }

  @override
  String toString() {
    return '''{id: ${this.id}, learnerId: ${this.learnerId}, teacherId: 
      ${this.teacherId}, groupId: ${this.groupId}, month: ${this.month}, response: 
      ${this.response} }''';
  }
}

// extension HiveTeacherResponseExt on HiveTeacherResponse {
//   HiveUser? get teacher {
//     return UserProvider().getUserById(this.teacherId!);
//   }
// }
