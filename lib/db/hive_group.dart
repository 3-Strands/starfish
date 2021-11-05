import 'dart:core';
import 'package:collection/collection.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_group_action.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_group.g.dart';

@HiveType(typeId: 12)
class HiveGroup extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  List<String>? languageIds;
  @HiveField(4)
  List<HiveGroupUser>? users;
  @HiveField(5)
  List<String>? evaluationCategoryIds;
  @HiveField(6)
  List<HiveGroupAction>? actions;
  @HiveField(7)
  List<HiveEdit>? editHistory;
  @HiveField(8)
  bool isNew = false;
  @HiveField(9)
  bool isUpdated = false;
  @HiveField(10)
  bool isDirty = false;

  HiveGroup({
    this.id,
    this.name,
    this.description,
    this.languageIds,
    this.users,
    this.evaluationCategoryIds,
    this.actions,
    this.editHistory,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
  });

  HiveGroup.from(Group group) {
    this.id = group.id;
    this.name = group.name;
    this.description = group.description;
    this.languageIds = group.languageIds;
    this.users =
        group.users.map((GroupUser user) => HiveGroupUser.from(user)).toList();
    this.evaluationCategoryIds = group.evaluationCategoryIds;
    // this.actions = group.actions
    //     .map((GroupAction action) => HiveGroupAction.from(action))
    //     .toList();
    this.editHistory =
        group.editHistory.map((Edit e) => HiveEdit.from(e)).toList();
  }

  Group toGroup() {
    return Group(
      id: this.id,
      name: this.name,
      description: this.description,
      languageIds: this.languageIds,
      users: this.users?.map((HiveGroupUser user) => user.toGroupUser()),
      evaluationCategoryIds: this.evaluationCategoryIds,
      // actions:
      //     this.actions?.map((HiveGroupAction action) => action.toGroupAction()),
    );
  }

  GroupUser_Role? currentUserRole;

  set userRole(GroupUser_Role? role) {
    this.currentUserRole = role;
  }

  GroupUser_Role? get userRole {
    return currentUserRole;
  }

  HiveGroupUser? get admin {
    return this.activeUsers?.firstWhereOrNull((groupUser) =>
        GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.ADMIN);
  }

  List<HiveGroupUser>? get teachers {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.TEACHER)
        .toList();
  }

  List<HiveGroupUser>? get learners {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.LEARNER)
        .toList();
  }

  List<String>? get teachersName {
    return this
        .activeUsers
        ?.where((groupUser) =>
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.ADMIN ||
            GroupUser_Role.valueOf(groupUser.role!) == GroupUser_Role.TEACHER)
        .map((e) => e.name)
        .toList();
  }

  /// Returns all 'HiveGroupUser' where 'isDirty' is false
  List<HiveGroupUser>? get activeUsers {
    return this
        .users
        ?.where((groupUser) => groupUser.isDirty == false)
        .toList();
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, description: ${this.description}, 
    languageIds: ${this.languageIds?.toString()}, users: ${this.users?.toString()}, 
    actions: ${this.actions?.toString()}, editHistory: ${this.editHistory?.toString()}, 
    currentUserRole: ${this.currentUserRole} }''';
  }
}

extension HiveGroupExt on HiveGroup {
  String get adminName {
    if (this.currentUserRole == GroupUser_Role.ADMIN) {
      return 'Me';
    } else {
      return this.admin != null ? this.admin!.userId! : 'NA';
    }
  }

  GroupUser_Role getMyRole(String userId) {
    if (this.users == null) {
      return GroupUser_Role.UNSPECIFIED_ROLE;
    }
    HiveGroupUser? _groupUser =
        this.users!.firstWhereOrNull((element) => element.userId == userId);
    return _groupUser != null
        ? GroupUser_Role.valueOf(_groupUser.role!)!
        : GroupUser_Role.UNSPECIFIED_ROLE;
  }

  bool containsUserName(String query) {
    if (this.activeUsers == null) {
      return false;
    }
    return this
            .activeUsers!
            .where((element) => element.name.toLowerCase().contains(query))
            .length >
        0;
  }
}
