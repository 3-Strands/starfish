import 'package:hive/hive.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 16)
class HiveUser {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  bool linkGroups = false;
  @HiveField(4)
  List<String>? countryIds;
  @HiveField(5)
  List<String>? languageIds;
  @HiveField(6)
  List<HiveGroupUser>? groups;
  @HiveField(7)
  List<HiveActionUser>? actions;
  @HiveField(8)
  int? selectedActionsTab;
  @HiveField(9)
  int? selectedResultsTab;
  @HiveField(10)
  String? diallingCode;
  @HiveField(11)
  String? phoneCountryId;
  @HiveField(12)
  bool isNew;
  @HiveField(13)
  bool isUpdated;
  @HiveField(14)
  bool isDeleted;

  HiveUser({
    required this.id,
    required this.name,
    this.phone,
    this.linkGroups = false,
    this.countryIds,
    this.languageIds,
    this.groups,
    this.actions,
    this.selectedActionsTab,
    this.selectedResultsTab,
    this.phoneCountryId,
    this.diallingCode,
    this.isNew = false,
    this.isUpdated = false,
    this.isDeleted = false,
  });

  User toUser() {
    return User(
      id: this.id,
      name: this.name,
      phone: this.phone,
      linkGroups: this.linkGroups,
      countryIds: this.countryIds,
      languageIds: this.languageIds,
      groups: this.groups?.map((e) => e.toGroupUser()),
      actions: this.actions?.map((e) => e.toActionUser()),
      selectedActionsTab: ActionTab.valueOf(this.selectedActionsTab!),
      selectedResultsTab: ResultsTab.valueOf(this.selectedResultsTab!),
      phoneCountryId: this.phoneCountryId,
      diallingCode: this.diallingCode,
    );
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, phone: ${this.phone}, 
        linkGroups: ${this.linkGroups}, diallingCode: ${this.diallingCode}, 
        countryIds: ${this.countryIds?.toString()}, languageIds: ${this.languageIds?.toString()}}''';
  }
}
