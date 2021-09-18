import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_material.g.dart';

@HiveType(typeId: 5)
class HiveMaterial extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? creatorId;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? visibility;
  @HiveField(4)
  String? editability;
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

  HiveMaterial({
    this.id,
    this.creatorId,
    this.title,
    this.description,
    this.url,
    this.languageIds,
    this.typeIds,
    this.topics,
    this.visibility,
    this.editability,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
  });

  HiveMaterial.from(Material material) {
    this.id = material.id;
    this.creatorId = material.creatorId;
    this.status = material.status.toString(); // Material_Status
    this.visibility = material.visibility.toString(); // Material_Visibility
    this.editability = material.editability.toString(); // Material_Editability
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
    this.dateCreated = HiveDate.from(material.dateCreated);
    this.dateUpdated = HiveDate.from(material.dateUpdated);
  }
}
