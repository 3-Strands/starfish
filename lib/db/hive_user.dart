import 'package:collection/collection.dart';

import 'package:hive/hive.dart';
import 'package:starfish/db/hive_current_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/action_user_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 16)
class HiveUser extends HiveObject {
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
  int? selectedActionsTab = ActionTab.ACTIONS_UNSPECIFIED.value;
  @HiveField(9)
  int? selectedResultsTab = ResultsTab.RESULTS_UNSPECIFIED.value;
  @HiveField(10)
  String? diallingCode;
  @HiveField(11)
  String? phoneCountryId;
  @HiveField(12)
  int? status = User_Status.STATUS_UNSPECIFIED.value;
  @HiveField(13)
  String? creatorId;
  @HiveField(14)
  bool isNew = false;
  @HiveField(15)
  bool isUpdated = false;
  @HiveField(16)
  bool isDeleted = false;

  bool isSelected = false;

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
    this.status = 0,
    this.creatorId,
    this.isNew = false,
    this.isUpdated = false,
    this.isDeleted = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveUser &&
          runtimeType == other.runtimeType &&
          this.id == other.id;

  @override
  int get hashCode => id.hashCode;

  HiveUser.from(User user) {
    this.id = user.id;
    this.name = user.name;
    this.phone = user.phone;
    this.linkGroups = user.linkGroups;
    this.countryIds = user.countryIds;
    this.groups =
        user.groups.map((GroupUser e) => HiveGroupUser.from(e)).toList();
    this.actions = user.actions.map((e) => HiveActionUser.from(e)).toList();
    this.selectedActionsTab = user.selectedActionsTab.value;
    this.selectedResultsTab = user.selectedResultsTab.value;
    this.phoneCountryId = user.phoneCountryId;
    this.diallingCode = user.diallingCode;
    this.status = user.status.value;
    this.creatorId = user.creatorId;
    this.isNew = false;
    this.isUpdated = false;
    this.isDeleted = false;
  }

  HiveUser.fromCurrentUser(HiveCurrentUser user) {
    this.id = user.id;
    this.name = user.name;
    this.phone = user.phone;
    this.linkGroups = user.linkGroups;
    this.countryIds = user.countryIds;
    this.groups = user.groups;
    this.actions = user.actions;
    this.selectedActionsTab = user.selectedActionsTab;
    this.selectedResultsTab = user.selectedResultsTab;
    this.phoneCountryId = user.phoneCountryId;
    this.diallingCode = user.diallingCode;
    this.status = user.status;
    this.creatorId = user.creatorId;
    this.isNew = false;
    this.isUpdated = false;
    this.isDeleted = false;
  }

  User toUser() {
    return User(
      id: this.id,
      name: this.name,
      phone: this.phone ?? '',
      linkGroups: this.linkGroups,
      countryIds: this.countryIds,
      languageIds: this.languageIds,
      groups: this.groups?.map((e) => e.toGroupUser()),
      actions: this.actions?.map((e) => e.toActionUser()),
      selectedActionsTab: this.selectedActionsTab != null
          ? ActionTab.valueOf(this.selectedActionsTab!)
          : ActionTab.ACTIONS_UNSPECIFIED,
      selectedResultsTab: this.selectedResultsTab != null
          ? ResultsTab.valueOf(this.selectedResultsTab!)
          : ResultsTab.RESULTS_UNSPECIFIED,
      phoneCountryId: this.phoneCountryId,
      diallingCode: this.diallingCode ?? '',
      status: this.status != null
          ? User_Status.valueOf(this.status!)
          : User_Status.STATUS_UNSPECIFIED,
      creatorId: this.creatorId,
    );
  }

  bool get isInvited {
    return this.phone != null || this.phone!.isNotEmpty;
  }

  String toString() {
    return '''{id: ${this.id}, name: ${this.name}, phone: ${this.phone}, 
        linkGroups: ${this.linkGroups}, diallingCode: ${this.diallingCode}, 
        countryIds: ${this.countryIds?.toString()}, languageIds: ${this.languageIds?.toString()},
        creatorId: ${this.creatorId}, status: ${this.status}}, isNew: ${this.isNew}, isUpdated: ${this.isUpdated}, isDeleted: ${this.isDeleted} }''';
  }
}

extension HiveUserExt on HiveUser {
  String get diallingCodeWithPlus {
    if (this.diallingCode == null ||
        (this.diallingCode != null && this.diallingCode!.isEmpty)) {
      return '';
    }

    if (RegExp("^\\+[0-9]").hasMatch(this.diallingCode!)) {
      return this.diallingCode!;
    }
    return '+${this.diallingCode}';
  }

  String get phoneWithDialingCode {
    return this.phone != null && this.phone!.isNotEmpty
        ? '${this.diallingCodeWithPlus} ${this.phone}'
        : '';
  }

// TODO: improve by havving a optional param HiveDate, for which the status can be retrieved
  ActionStatus actionStatusbyId(HiveAction action) {
    /*if (this.actions == null || this.actions?.length == 0) {
      print("Check Point 1");
      return ActionStatus.NOT_DONE;
    }*/
    /*HiveActionUser? actionUser = this.actions!.firstWhereOrNull((element) =>
        element.actionId! == action.id! && element.userId! == this.id);*/

    HiveActionUser? actionUser =
        ActionProvider().getActionUser(this.id!, action.id!);

    if (actionUser != null) {
      ActionStatus? actionStatus = actionUser.status != null
          ? ActionUser_Status.valueOf(actionUser.status!)!.convertTo()
          : ActionStatus.NOT_DONE;

      //
      if (actionStatus == ActionStatus.DONE) {
        return ActionStatus.DONE;
      }
    }

    // We need to check if the action is not done yet, if it's overdue or not
    if (action.dateDue == null || !action.hasValidDueDate) {
      return ActionStatus.NOT_DONE;
    } else if (action.dateDue != null &&
        action.dateDue!.isBefore(DateTimeUtils.toHiveDate(DateTime.now()))) {
      return ActionStatus.OVERDUE;
    } else {
      return ActionStatus.NOT_DONE;
    }
  }

  ActionUser_Evaluation actionUserEvaluationById(HiveAction action) {
    HiveActionUser? actionUser =
        ActionProvider().getActionUser(this.id!, action.id!);

    if (actionUser != null) {
      ActionUser_Evaluation actionUserEvaluation = actionUser.evaluation != null
          ? ActionUser_Evaluation.valueOf(actionUser.evaluation!)!
          : ActionUser_Evaluation.UNSPECIFIED_EVALUATION;

      return actionUserEvaluation;
    }
    return ActionUser_Evaluation.UNSPECIFIED_EVALUATION;
  }

  HiveActionUser? actionUser(HiveAction action) {
    return ActionProvider().getActionUser(this.id!, action.id!);
  }
}
