import 'package:starfish/config/app_config.dart';
import 'package:starfish/src/generated/starfish.pb.dart' as grpc;

class AppUser {
  final String id;

  final String name;

  final String phone;

  final bool linkGroups;

  final List<String> countryIds;

  final List<String> languageIds;

  final int selectedActionsTab;

  final int selectedResultsTab;

  final String diallingCode;

  final String phoneCountryId;

  final String? creatorId;

  AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.linkGroups,
    required this.countryIds,
    required this.languageIds,
    required this.selectedActionsTab,
    required this.selectedResultsTab,
    required this.phoneCountryId,
    required this.diallingCode,
    required this.creatorId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  AppUser copyWith({
    String? name,
    List<String>? countryIds,
    List<String>? languageIds,
  }) => AppUser(
    id: this.id,
    name: name ?? this.name,
    phone: this.phone,
    linkGroups: this.linkGroups,
    countryIds: countryIds ?? this.countryIds,
    languageIds: languageIds ?? this.languageIds,
    selectedActionsTab: this.selectedActionsTab,
    selectedResultsTab: this.selectedResultsTab,
    phoneCountryId: this.phoneCountryId,
    diallingCode: this.diallingCode,
    creatorId: this.creatorId,
  );

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      linkGroups: json['linkGroups'],
      countryIds: List<String>.from(json['countryIds']),
      languageIds: List<String>.from(json['languageIds']),
      selectedActionsTab: json['selectedActionsTab'],
      selectedResultsTab: json['selectedResultsTab'],
      phoneCountryId: json['phoneCountryId'],
      diallingCode: json['diallingCode'],
      creatorId: json['creatorId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'linkGroups': linkGroups,
      'countryIds': countryIds,
      'languageIds': languageIds,
      'selectedActionsTab': selectedActionsTab,
      'selectedResultsTab': selectedResultsTab,
      'phoneCountryId': phoneCountryId,
      'diallingCode': diallingCode,
      'creatorId': creatorId,
    };
  }

  AppUser.fromUser(grpc.User user) :
    id = user.id,
    name = user.name,
    phone = user.phone,
    linkGroups = user.linkGroups,
    countryIds = user.countryIds,
    languageIds = user.languageIds,
    diallingCode = user.diallingCode,
    phoneCountryId = user.phoneCountryId,
    selectedActionsTab = user.selectedActionsTab.value,
    selectedResultsTab = user.selectedResultsTab.value,
    creatorId = user.creatorId;

  grpc.User toUser() {
    return grpc.User(
      id: this.id,
      name: this.name,
      phone: this.phone,
      linkGroups: this.linkGroups,
      countryIds: this.countryIds,
      languageIds: this.languageIds,
      selectedActionsTab: grpc.ActionTab.valueOf(this.selectedActionsTab),
      selectedResultsTab: grpc.ResultsTab.valueOf(this.selectedResultsTab),
      phoneCountryId: this.phoneCountryId,
      diallingCode: this.diallingCode,
      creatorId: this.creatorId,
    );
  }

  // bool get hasAdminOrTeacherRole {
  //   return this
  //           .groups
  //           .where((HiveGroupUser groupUser) =>
  //               grpc.GroupUser_Role.valueOf(groupUser.role!) ==
  //                   grpc.GroupUser_Role.ADMIN ||
  //               grpc.GroupUser_Role.valueOf(groupUser.role!) ==
  //                   grpc.GroupUser_Role.TEACHER)
  //           .toList()
  //           .length >
  //       0;
  // }

  // List<HiveGroupUser> groupsWithRole(List<grpc.GroupUser_Role> groupUserRole) {
  //   return this
  //       .groups
  //       .where((element) =>
  //           groupUserRole.contains(grpc.GroupUser_Role.valueOf(element.role!)))
  //       .toList();
  // }

  String get diallingCodeWithPlus {
    if (this.diallingCode.isEmpty) {
      return this.diallingCode;
    }

    if (RegExp("^\\+[0-9]").hasMatch(this.diallingCode)) {
      return this.diallingCode;
    }
    return '+${this.diallingCode}';
  }

  // FOR DEBUG only
  String get debugDiallingCode {
    return FlavorConfig.instance?.flavor == Flavor.PROD
        ? this.diallingCode
        : "91";
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, phone: ${this.phone}, 
        linkGroups: ${this.linkGroups}, diallingCode: ${this.diallingCode}, 
        countryIds: ${this.countryIds.toString()}, languageIds: ${this.languageIds.toString()}}''';
  }
}
