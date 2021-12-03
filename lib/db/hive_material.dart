import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/db/providers/action_provider.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_material.g.dart';

@HiveType(typeId: 5)
class HiveMaterial extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? creatorId;
  @HiveField(2)
  int? status;
  @HiveField(3)
  int? visibility;
  @HiveField(4)
  int? editability;
  @HiveField(5)
  String? title;
  @HiveField(6)
  String? description;
  @HiveField(7)
  String? targetAudience;
  @HiveField(8)
  String? url;
  @HiveField(9)
  List<String>? files;
  @HiveField(10)
  List<String>? languageIds;
  @HiveField(11)
  List<String>? typeIds;
  @HiveField(12)
  List<String>? topics;
  @HiveField(13)
  List<HiveMaterialFeedback>? feedbacks;
  @HiveField(14)
  HiveDate? dateCreated;
  @HiveField(15)
  HiveDate? dateUpdated;
  @HiveField(16)
  bool isNew = false;
  @HiveField(17)
  bool isUpdated = false;
  @HiveField(18)
  bool isDirty = false;
  @HiveField(19)
  List<HiveEdit>? editHistory;

  HiveMaterial({
    this.id,
    this.creatorId,
    this.status = 0,
    this.title,
    this.description,
    this.url,
    this.languageIds,
    this.typeIds,
    this.topics,
    this.visibility,
    this.editability,
    this.editHistory,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
  });

  HiveMaterial.from(Material material) {
    this.id = material.id;
    this.creatorId = material.creatorId;
    this.status = material.status.value; // Material_Status
    this.visibility = material.visibility.value; // Material_Visibility
    this.editability = material.editability.value; // Material_Editability
    this.title = material.title;
    this.description = material.description;
    this.targetAudience = material.targetAudience;
    this.url = material.url;
    this.files = material.files;
    this.languageIds = material.languageIds;
    this.typeIds = material.typeIds;
    this.topics = material.topics;
    this.feedbacks = material.feedbacks.map((MaterialFeedback feedback) {
      return HiveMaterialFeedback.from(feedback);
    }).toList();
    this.editHistory =
        material.editHistory.map((Edit e) => HiveEdit.from(e)).toList();
    this.dateCreated = HiveDate.from(material.dateCreated);
    this.dateUpdated = HiveDate.from(material.dateUpdated);
  }

  Material toMaterial() {
    return Material(
      id: this.id,
      creatorId: this.creatorId,
      status: Material_Status.valueOf(this.status ?? 0),
      visibility: Material_Visibility.valueOf(this.visibility ?? 0),
      editability: Material_Editability.valueOf(this.editability ?? 0),
      title: this.title,
      description: this.description,
      targetAudience: this.targetAudience,
      url: this.url,
      files: this.files,
      languageIds: this.languageIds,
      typeIds: this.typeIds,
      topics: this.topics,
      //feedbacks: this.feedbacks,
      //editHistory: this.editHistory?.map((HiveEdit e) => e.toEdit()).toList(),
      dateCreated: this.dateCreated?.toDate(),
      dateUpdated: this.dateUpdated?.toDate(),
    );
  }

  @override
  String toString() {
    return '{id: ${this.id}, creatorId: ${this.creatorId}, status: ${this.status}, visibility: ${this.visibility}, editability: ${this.editability}, title: ${this.title}, description: ${this.description}, targetAudience: ${this.targetAudience},}';
  }
}

extension HiveMaterialExt on HiveMaterial {
  bool get isAssignedToMe {
    bool isAssigned = false;
    ActionProvider().getAllActions().forEach((action) {
      if ((action.materialId != null && action.materialId!.isNotEmpty) &&
          action.isIndividualAction &&
          action.materialId == this.id) {
        isAssigned = true;
      }
    });

    return isAssigned;
  }

  bool get isAssignedToGroupWithLeaderRole {
    bool isAssigned = false;
    ActionProvider().getAllActions().forEach((action) {
      if ((action.materialId != null && action.materialId!.isNotEmpty) &&
          !action.isIndividualAction &&
          (action.leaders != null && action.leaders!.length > 0) &&
          action.materialId == this.id) {
        isAssigned = true;
      }
    });

    return isAssigned;
  }

  ActionStatus get myActionStatus {
    bool statusOverdue = false;
    bool statusNotDone = false;
    bool statusDone = false;
    ActionProvider().getAllActions().forEach((action) {
      if ((action.materialId != null || action.materialId!.isNotEmpty) &&
          action.isIndividualAction &&
          action.materialId == this.id) {
        if (action.actionStatus == ActionStatus.OVERDUE) {
          statusOverdue = true;
          statusDone = false;
        } else if (action.actionStatus == ActionStatus.NOT_DONE) {
          statusNotDone = true;
          statusDone = false;
        } else if (action.actionStatus == ActionStatus.DONE) {
          statusDone = true;
        } else {
          statusDone = false;
        }
      }
    });

    if (statusDone) {
      return ActionStatus.DONE;
    }
    if (statusNotDone) {
      return ActionStatus.NOT_DONE;
    }
    if (statusOverdue) {
      return ActionStatus.OVERDUE;
    }
    return ActionStatus.UNSPECIFIED_STATUS;
  }
}
