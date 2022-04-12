import 'package:hive/hive.dart';
import 'package:collection/collection.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_action_user.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group_evaluation.dart';
import 'package:starfish/db/hive_learner_evaluation.dart';
import 'package:starfish/db/hive_teacher_response.dart';
import 'package:starfish/db/hive_transformation.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/db/providers/current_user_provider.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/db/providers/group_evaluation_provider.dart';
import 'package:starfish/db/providers/learner_evaluation_provider.dart';
import 'package:starfish/db/providers/teacher_response_provider.dart';
import 'package:starfish/db/providers/transformation_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/enums/action_user_status.dart';
import 'package:starfish/repository/current_user_repository.dart';
import 'package:starfish/repository/group_repository.dart';
import 'package:starfish/repository/user_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_group_user.g.dart';

@HiveType(typeId: 3)
class HiveGroupUser extends HiveObject {
  @HiveField(0)
  String? groupId;
  @HiveField(1)
  String? userId;
  @HiveField(2)
  int? role;
  @HiveField(3)
  bool isNew = false;
  @HiveField(4)
  bool isUpdated = false;
  @HiveField(5)
  bool isDirty = false;

  HiveGroupUser({
    this.groupId,
    this.userId,
    this.role,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveGroupUser &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          groupId == other.groupId;

  @override
  int get hashCode => userId.hashCode ^ groupId.hashCode;

  HiveGroupUser.from(GroupUser group) {
    this.groupId = group.groupId;
    this.userId = group.userId;
    this.role = group.role.value;
  }

  GroupUser toGroupUser() {
    return GroupUser(
      userId: this.userId,
      groupId: this.groupId,
      role: GroupUser_Role.valueOf(this.role!),
    );
  }

  HiveTransformation? getTransformationForMonth(HiveDate hiveDate) {
    return this.transformations.firstWhereOrNull((element) {
      if (element.month == null) {
        return false;
      }
      return element.month!.year == hiveDate.year &&
          element.month!.month == hiveDate.month;
    });
  }

  Map<HiveEvaluationCategory, Map<String, int>>
      getLearnerEvaluationsByCategoryForMoth(HiveDate hiveDate) {
    Map<HiveEvaluationCategory, Map<String, int>> _map = Map();
    group?.evaluationCategoryIds?.forEach((categoryId) {
      HiveEvaluationCategory? _evaluationCategory =
          EvaluationCategoryProvider().getCategoryById(categoryId);
      if (_evaluationCategory != null) {
        Map<String, int> _countByMonth = Map();
        _countByMonth["this-month"] =
            _countCategoryLearnerEvaluationsForMonth(categoryId, hiveDate);
        _countByMonth["last-month"] = _countCategoryLearnerEvaluationsForMonth(
            categoryId, hiveDate.previousMonth);

        _map[_evaluationCategory] = _countByMonth;
      }
    });

    return _map;
  }

  int _countCategoryLearnerEvaluationsForMonth(
      String categoryId, HiveDate hiveDate) {
    return this
        .learnerEvaluations
        .where((element) => element.categoryId == categoryId)
        .where((element) {
      if (element.month == null) {
        return false;
      }
      return element.month!.year == hiveDate.year &&
          element.month!.month == hiveDate.month;
    }).length;
  }

  HiveGroupEvaluation? getGroupEvaluationForMonth(HiveDate hiveDate) {
    return this.groupEvaluations.firstWhereOrNull((element) {
      if (element.month == null) {
        return false;
      }
      return element.month!.year == hiveDate.year &&
          element.month!.month == hiveDate.month;
    });
  }

  HiveTeacherResponse? getTeacherResponseForMonth(HiveDate hiveDate) {
    return this.teacherResponses.firstWhereOrNull((element) {
      if (element.month == null) {
        return false;
      }
      return element.month!.year == hiveDate.year &&
          element.month!.month == hiveDate.month;
    });
  }

  String toString() {
    return '''{groupId: ${this.groupId}, userId: ${this.userId}, role: ${GroupUser_Role.valueOf(this.role!)},
    user: ${this.user},  
    isNew: ${this.isNew}, isUpdated: ${this.isUpdated}, isDirty: ${this.isDirty}}''';
  }
}

extension HiveGroupUserExt on HiveGroupUser {
  HiveUser? get user {
    HiveUser? _user = CurrentUserRepository().dbProvider.user;

    if (_user.id == this.userId) {
      return _user;
    }

    _user = UserRepository().dbProvider.getUserById(this.userId!);

    return _user;
  }

  HiveGroup? get group {
    return GroupRepository().dbProvider.getGroupById(this.groupId!);
  }

  String get name {
    return user != null ? user!.name! : 'Unknown User';
  }

  String get phone {
    return user != null && user!.phone != null ? user!.phone! : '';
  }

  String get diallingCode {
    return user != null && user!.diallingCode != null
        ? user!.diallingCode!
        : '';
  }

  bool get isInvited {
    return user != null &&
        (user!.phone != null && user!.phone!.isNotEmpty) &&
        User_Status.valueOf(user!.status!)! != User_Status.ACTIVE;
  }

  bool get isActive {
    return user != null &&
        User_Status.valueOf(user!.status!)! == User_Status.ACTIVE;
  }

  String get phoneWithDialingCode {
    return user != null ? user!.phoneWithDialingCode : '';
  }

  List<HiveLearnerEvaluation> get learnerEvaluations {
    return LearnerEvaluationProvider()
        .getGroupUserLearnerEvaluations(this.userId!, this.groupId!);
  }

  // returns transformations for this 'GroupUser' for all the months
  List<HiveTransformation> get transformations {
    return TransformationProvider()
        .getGroupUserTransformations(this.userId!, this.groupId!);
  }

  // returns groupEvaluations for this 'GroupUser' for all the months
  List<HiveGroupEvaluation> get groupEvaluations {
    return GroupEvaluationProvider()
        .getGroupUserGroupEvaluation(this.userId!, this.groupId!);
  }

  // returns teacherResponses for this 'GroupUser' for all the months
  List<HiveTeacherResponse> get teacherResponses {
    return TeacherResponseProvider()
        .getGroupUserTeacherResponse(this.userId!, this.groupId!);
  }

  List<HiveAction>? get actions {
    ActionProvider().getGroupActions(this.groupId!);
  }

  int get actionsCompleted {
    int count = 0;
    this.actions?.forEach((hiveAction) {
      HiveActionUser? _hiveActionUser =
          ActionProvider().getActionUser(this.userId!, hiveAction.id!);

      if (_hiveActionUser != null &&
          ActionUser_Status.valueOf(_hiveActionUser.status!)!.convertTo() ==
              ActionStatus.DONE) {
        count++;
      }
    });
    /*this.actions?.where((hiveAction) {
      return user?.actionStatusbyId(hiveAction) == ActionStatus.DONE;
    }).length;*/

    return count;
  }

  int get actionsNotCompleted {
    int count = 0;
    this.actions?.forEach((hiveAction) {
      HiveActionUser? _hiveActionUser =
          ActionProvider().getActionUser(this.userId!, hiveAction.id!);

      if (_hiveActionUser != null &&
          ActionUser_Status.valueOf(_hiveActionUser.status!)!.convertTo() ==
              ActionStatus.NOT_DONE) {
        count++;
      }
    });

    return count;
  }

  int get actionsOverdue {
    int count = 0;
    this.actions?.forEach((hiveAction) {
      HiveActionUser? _hiveActionUser =
          ActionProvider().getActionUser(this.userId!, hiveAction.id!);

      if (_hiveActionUser != null &&
          ActionUser_Status.valueOf(_hiveActionUser.status!)!.convertTo() ==
              ActionStatus.OVERDUE) {
        count++;
      }
    });

    return count;
  }
}
