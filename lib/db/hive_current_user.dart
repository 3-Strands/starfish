import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_group.dart';

part 'hive_current_user.g.dart';

@HiveType(typeId: 2)
class HiveCurrentUser {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final bool linkGroup;

  @HiveField(4)
  List<String> countryIds;

  @HiveField(5)
  List<String> languageIds;

  @HiveField(6)
  final List<HiveGroup> groups;

  @HiveField(7)
  final List<HiveAction> actions;

  @HiveField(8)
  final String selectedActionsTab;

  @HiveField(9)
  final String selectedResultsTab;

  HiveCurrentUser(
      {required this.id,
      required this.name,
      required this.phone,
      required this.linkGroup,
      required this.countryIds,
      required this.languageIds,
      required this.groups,
      required this.actions,
      required this.selectedActionsTab,
      required this.selectedResultsTab});
}
