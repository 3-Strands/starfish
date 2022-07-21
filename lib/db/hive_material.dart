import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_edit.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

import 'hive_concrete.dart';
import 'hive_material_topic.dart';
import 'hive_material_type.dart';
import 'hive_syncable.dart';

part 'hive_material.g.dart';

@HiveType(typeId: 5)
class HiveMaterial extends HiveConcrete implements HiveSyncable<Material> {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String creatorId;
  @HiveField(2)
  int status;
  @HiveField(3)
  int visibility;
  @HiveField(4)
  int editability;
  @HiveField(5)
  String title;
  @HiveField(6)
  String description;
  @HiveField(7)
  String targetAudience;
  @HiveField(8)
  String url;
  @HiveField(9)
  List<String> fileNames;
  @HiveField(10)
  List<String> languageIds;
  @HiveField(11)
  List<String> typeIds;
  @HiveField(12)
  List<String> topicIds;
  @HiveField(13)
  HiveList<HiveMaterialFeedback> feedbacks = HiveList(globalHiveApi.materialFeedback);
  @HiveField(14)
  HiveDate dateCreated;
  @HiveField(15)
  HiveDate dateUpdated;
  @HiveField(16)
  bool isNew = false;
  @HiveField(17)
  bool isUpdated = false;
  @HiveField(18)
  bool isDirty = false;
  @HiveField(19)
  List<HiveEdit> editHistory;
  @HiveField(20)
  Map<String, String> languages;

  HiveMaterial({
    required this.id,
    required this.creatorId,
    this.status = 0,
    required this.title,
    required this.description,
    required this.url,
    required this.targetAudience,
    this.fileNames = const[],
    this.languageIds = const [],
    this.typeIds = const [],
    this.topicIds = const [],
    required this.visibility,
    required this.editability,
    this.editHistory = const [],
    required this.dateCreated,
    required this.dateUpdated,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
    this.languages = const {},
  });

  HiveMaterial.from(Material material) :
    id = material.id,
    creatorId = material.creatorId,
    status = material.status.value, // Material_Status
    visibility = material.visibility.value, // Material_Visibility
    editability = material.editability.value, // Material_Editability
    title = material.title,
    description = material.description,
    targetAudience = material.targetAudience,
    url = material.url,
    fileNames = material.files,
    languageIds = material.languageIds,
    typeIds = material.typeIds,
    topicIds = material.topics,
    // feedbacks = HiveList(Hive.box(HiveDatabase.MATERIAL_FEEDBACK_BOX)),
    editHistory =
        material.editHistory.map((Edit e) => HiveEdit.from(e)).toList(),
    dateCreated = HiveDate.from(material.dateCreated),
    dateUpdated = HiveDate.from(material.dateUpdated),
    languages = material.languages;
  
  static void populateBox(Material material) {
    final hiveMaterial = HiveMaterial.from(material);
    globalHiveApi.material.put(hiveMaterial.key, hiveMaterial);
    material.feedbacks.map(HiveMaterialFeedback.from).forEach(hiveMaterial.addFeedback);
  }

  void addFeedback(HiveMaterialFeedback feedback) {
    globalHiveApi.materialFeedback.put(feedback.key, feedback);
    feedbacks.add(feedback);
  }

  Material toGrpcCompatible() {
    return Material(
      id: this.id,
      creatorId: this.creatorId,
      status: Material_Status.valueOf(this.status),
      visibility: Material_Visibility.valueOf(this.visibility),
      editability: Material_Editability.valueOf(this.editability),
      title: this.title,
      description: this.description,
      targetAudience: this.targetAudience,
      url: this.url,
      files: this.fileNames,
      languageIds: this.languageIds,
      typeIds: this.typeIds,
      topics: this.topicIds,
      //feedbacks: this.feedbacks,
      //editHistory: this.editHistory?.map((HiveEdit e) => e.toEdit()).toList(),
      dateCreated: this.dateCreated.toDate(),
      dateUpdated: this.dateUpdated.toDate(),
    );
  }

  @override
  String toString() {
    return '{id: ${this.id}, creatorId: ${this.creatorId}, status: ${this.status}, visibility: ${this.visibility}, editability: ${this.editability}, title: ${this.title}, description: ${this.description}, targetAudience: ${this.targetAudience}, files: ${this.fileNames}, }';
  }

  // bool get isAssignedToMe {
  //   bool isAssigned = false;
  //   ActionProvider().getAllActiveActions().forEach((action) {
  //     if ((action.materialId != null && action.materialId!.isNotEmpty) &&
  //         action.isIndividualAction &&
  //         action.materialId == this.id) {
  //       isAssigned = true;
  //     }
  //   });

  //   return isAssigned;
  // }

  // bool get isAssignedToGroupWithLeaderRole {
  //   bool isAssigned = false;
  //   ActionProvider().getAllActiveActions().forEach((action) {
  //     if ((action.materialId != null && action.materialId!.isNotEmpty) &&
  //         !action.isIndividualAction &&
  //         (action.leaders != null && action.leaders!.length > 0) &&
  //         action.materialId == this.id) {
  //       isAssigned = true;
  //     }
  //   });

  //   return isAssigned;
  // }

  // ActionStatus get myActionStatus {
  //   bool statusOverdue = false;
  //   bool statusNotDone = false;
  //   bool statusDone = false;
  //   ActionProvider().getAllActiveActions().forEach((action) {
  //     if ((action.materialId != null && action.materialId!.isNotEmpty) &&
  //         action.isIndividualAction &&
  //         action.materialId == this.id) {
  //       if (action.actionStatus == ActionStatus.OVERDUE) {
  //         statusOverdue = true;
  //         statusDone = false;
  //       } else if (action.actionStatus == ActionStatus.NOT_DONE) {
  //         statusNotDone = true;
  //         statusDone = false;
  //       } else if (action.actionStatus == ActionStatus.DONE) {
  //         statusDone = true;
  //       } else {
  //         statusDone = false;
  //       }
  //     }
  //   });

  //   if (statusDone) {
  //     return ActionStatus.DONE;
  //   }
  //   if (statusNotDone) {
  //     return ActionStatus.NOT_DONE;
  //   }
  //   if (statusOverdue) {
  //     return ActionStatus.OVERDUE;
  //   }
  //   return ActionStatus.NOT_DONE;
  // }

  List<HiveFile> get files {
    return fileNames.map(
      (filename) => globalHiveApi.file.get(HiveFile.keyFrom(id, filename))!,
    ).toList();
  }

  List<String> get languageNames => languageIds.map(
    (languageId) => globalHiveApi.language.get(languageId)?.name ?? languages[languageId] ?? '',
  ).toList();

  // List<HiveLanguage> get allLanguages {
  //   List<HiveLanguage> _languages = [];
  //   this.languageIds.forEach((id) {
  //     HiveLanguage? _language = LanguageProvider().getById(id);

  //     // There may be case the material language is not available in the Natiations followed by this user,
  //     // so get the name of language in `this.languages`
  //     if (_language == null) {
  //       this.languages.forEach((key, value) {
  //         if (key == id) {
  //           _language = HiveLanguage(id: key, name: value);
  //         }
  //       });
  //     }
  //     if (_language != null) {
  //       _languages.add(_language!);
  //     }
  //   });
  //   return _languages;
  // }
}
