import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_current_user.g.dart';

@HiveType(typeId: 2)
class HiveCurrentUser {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  bool linkGroups;

  @HiveField(4)
  List<String> countryIds;

  @HiveField(5)
  List<String> languageIds;

  @HiveField(6)
  final List<HiveGroupUser> groups;

  @HiveField(7)
  final List<HiveActionUser> actions;

  @HiveField(8)
  final int selectedActionsTab;

  @HiveField(9)
  final int selectedResultsTab;

  @HiveField(10)
  String diallingCode;

  @HiveField(11)
  String phoneCountryId;

  @HiveField(12)
  bool isUpdated;

  HiveCurrentUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.linkGroups,
    required this.countryIds,
    required this.languageIds,
    required this.groups,
    required this.actions,
    required this.selectedActionsTab,
    required this.selectedResultsTab,
    required this.phoneCountryId,
    required this.diallingCode,
    this.isUpdated = false,
  });

  User toUser() {
    return User(
      id: this.id,
      name: this.name,
      phone: this.phone,
      linkGroups: this.linkGroups,
      countryIds: this.countryIds,
      languageIds: this.languageIds,
      groups: this.groups.map((e) => e.toGroupUser()),
      actions: this.actions.map((e) => e.toActionUser()),
      selectedActionsTab: ActionTab.valueOf(this.selectedActionsTab),
      selectedResultsTab: ResultsTab.valueOf(this.selectedResultsTab),
      phoneCountryId: this.phoneCountryId,
      diallingCode: this.diallingCode,
    );
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, phone: ${this.phone}, 
        linkGroups: ${this.linkGroups}, diallingCode: ${this.diallingCode}, 
        countryIds: ${this.countryIds.toString()}, languageIds: ${this.languageIds.toString()}}''';
  }
}
