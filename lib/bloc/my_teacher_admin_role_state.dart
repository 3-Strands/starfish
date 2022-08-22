part of 'my_teacher_admin_role_cubit.dart';

@immutable
class MyTeacherAdminRoleState {
  MyTeacherAdminRoleState({
    required this.groupsWhereIAmTeacher,
    required this.groupsWhereIAmAdmin,
  });

  final List<Group> groupsWhereIAmTeacher;
  final List<Group> groupsWhereIAmAdmin;

  bool get hasAdminOrTeacherRole =>
      groupsWhereIAmTeacher.isNotEmpty || groupsWhereIAmAdmin.isNotEmpty;

  MyTeacherAdminRoleState copyWith({
    List<Group>? groupsWhereIAmTeacher,
    List<Group>? groupsWhereIAmAdmin,
  }) =>
      MyTeacherAdminRoleState(
        groupsWhereIAmTeacher:
            groupsWhereIAmTeacher ?? this.groupsWhereIAmTeacher,
        groupsWhereIAmAdmin: groupsWhereIAmAdmin ?? this.groupsWhereIAmAdmin,
      );
}
