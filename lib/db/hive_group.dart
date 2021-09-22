import 'dart:core';

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
  List<String>? languageIds;
  @HiveField(3)
  List<HiveGroupUser>? users;
  @HiveField(4)
  List<String>? evaluationCategoryIds;
  @HiveField(5)
  List<HiveGroupAction>? actions;
  @HiveField(6)
  List<HiveEdit>? editHistory;
  @HiveField(7)
  bool isNew = false;
  @HiveField(8)
  bool isUpdated = false;
  @HiveField(9)
  bool isDirty = false;

  HiveGroup({
    this.id,
    this.name,
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
    this.languageIds = group.languageIds;
    this.users =
        group.users.map((GroupUser user) => HiveGroupUser.from(user)).toList();
    this.evaluationCategoryIds = group.evaluationCategoryIds;
    this.actions = group.actions
        .map((GroupAction action) => HiveGroupAction.from(action))
        .toList();
  }
}
