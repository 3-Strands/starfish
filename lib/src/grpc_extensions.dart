import 'package:collection/collection.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

export 'package:starfish/src/generated/google/type/date.pb.dart';
export 'package:starfish/src/generated/starfish.pb.dart';

extension DateExt on Date {
  DateTime toDateTime() => DateTime(year, month, day == 0 ? 1 : day);

  bool get isValidDate {
    return this.year != 0 && this.month != 0 && this.day != 0;
  }

  int compareTo(Date other) => year < other.year
      ? -1
      : year > other.year
          ? 1
          : month < other.month
              ? -1
              : month > other.month
                  ? 1
                  : day < other.day
                      ? -1
                      : day > other.day
                          ? 1
                          : 0;

  int compareMonthTo(Date other) => year < other.year
      ? -1
      : year > other.year
          ? 1
          : month < other.month
              ? -1
              : month > other.month
                  ? 1
                  : 0;

  bool isSameMonth(Date other) => year == other.year && month == other.month;

  static Date fromDateTime(DateTime dateTime) {
    return Date(year: dateTime.year, month: dateTime.month, day: dateTime.day);
  }

  Date nextMonth() {
    if (month == 12) {
      return Date(year: year + 1, month: month);
    }
    return Date(year: year, month: month + 1);
  }

  static Iterable<Date> monthsInRange(Date from, Date to) sync* {
    var current = from;
    while (current.compareMonthTo(to) <= 0) {
      yield current;
      current = current.nextMonth();
    }
  }

  // Returns previous month and year
  Date get previousMonth {
    int currentMonth = this.month;
    int currentYear = this.year;

    if (currentMonth > 1) {
      return Date(year: currentYear, month: currentMonth - 1);
    } else {
      return Date(year: currentYear - 1, month: 12);
    }
  }
}

extension FileReferenceExt on FileReference {
  static FileReference getFileReference({
    required String entityId,
    required EntityType entityType,
    required String filename,
  }) {
    final key = FileReference.keyFrom(entityId, filename);
    final fileReference = globalHiveApi.file.get(key);
    if (fileReference != null) {
      return fileReference;
    }
    final newFileReference = FileReference(
      entityId: entityId,
      entityType: entityType.value,
      filename: filename,
    );
    globalHiveApi.file.put(key, newFileReference);
    return newFileReference;
  }
}

extension MaterialExt on Material {
  String get key => id;

  List<String> get languageNames => languageIds
      .map(
        (languageId) =>
            globalHiveApi.language.get(languageId)?.name ??
            languages[languageId] ??
            '',
      )
      .toList();

  List<FileReference> get fileReferences => files
      .map((filename) => FileReferenceExt.getFileReference(
          entityId: id, entityType: EntityType.MATERIAL, filename: filename))
      .toList();
}

extension ActionExt on Action {
  Group? get group => globalHiveApi.group.get(groupId);

  bool get isIndividualAction => groupId.isEmpty;

  bool get isPastDueDate => dateDue.isValidDate
      ? dateDue.toDateTime().isBefore(DateTime.now())
      : false;

  bool get hasValidDueDate {
    return this.dateDue.year != 0 &&
        this.dateDue.month != 0 &&
        this.dateDue.day != 0;
  }

  Material? get material => globalHiveApi.material.get(materialId);
}

extension ActionUserExt on ActionUser {
  Action? get action => globalHiveApi.action.get(actionId);
}

extension GroupExt on Group {
  List<User> get fullUsers => users.map((groupUser) => groupUser.user).toList();

  List<User> get learners => users
      .where((user) =>
          user.maybeUser != null && user.role == GroupUser_Role.LEARNER)
      .map((groupUser) => groupUser.user)
      .toList();

  List<User> get adminAndTeachers => users
      .where((user) =>
          user.maybeUser != null &&
          (user.role == GroupUser_Role.ADMIN ||
              user.role == GroupUser_Role.TEACHER))
      .map((groupUser) => groupUser.user)
      .toList();

  List<String> get teachersName => users
      .where((groupUser) =>
          groupUser.role == GroupUser_Role.ADMIN ||
          groupUser.role == GroupUser_Role.TEACHER)
      .map((groupUser) => groupUser.user.name)
      .toList();
  // List<UserWithGroupRole> get usersWithRole => users
  //     .map((groupUser) => UserWithGroupRole(groupUser.user, groupUser.role))
  //     .toList();
}

extension GroupUserExt on GroupUser {
  User? get maybeUser => globalHiveApi.user.get(userId);
  User get user => maybeUser!;

  Group? get group => globalHiveApi.group.get(groupId);

  bool get userIsInvitedToGroup {
    final user = this.user;
    return user.phone.isNotEmpty && user.status != User_Status.ACTIVE;
  }
}

extension UserExt on User {
  String get diallingCodeWithPlus {
    if (this.diallingCode.isEmpty) {
      return this.diallingCode;
    }

    if (RegExp("^\\+[0-9]").hasMatch(this.diallingCode)) {
      return this.diallingCode;
    }
    return '+${this.diallingCode}';
  }

  String get fullPhone =>
      '${diallingCode.isNotEmpty ? '+${diallingCode.replaceFirst('+', '')} ' : ''}$phone';

  bool get hasFullPhone => phone.isNotEmpty;

  List<Group> get adminGroups => List<Group>.from(
        groups
            .where((groupUser) => groupUser.role == GroupUser_Role.ADMIN)
            .map((groupUser) => groupUser.group)
            .where((group) => group != null),
      );

  List<Group> get teacherGroups => List<Group>.from(
        groups
            .where((groupUser) => groupUser.role == GroupUser_Role.TEACHER)
            .map((groupUser) => groupUser.group)
            .where((group) => group != null),
      );
}

extension TeacherResponseExt on TeacherResponse {
  User? get teacher => globalHiveApi.user.get(teacherId);
}

extension TransformationExt on Transformation {
  List<FileReference> get fileReferences => files
      .map((filename) => FileReferenceExt.getFileReference(
          entityId: id, entityType: EntityType.MATERIAL, filename: filename))
      .toList();
}

extension EvaluationCategoryExt on EvaluationCategory {
  String getEvaluationNameFromValue(int value) =>
      valueNames
          .firstWhereOrNull(
            (element) => element.value == value,
          )
          ?.name ??
      value.toString();
}
