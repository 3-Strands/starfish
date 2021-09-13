import 'package:hive/hive.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_material.g.dart';

@HiveType(typeId: 5)
class HiveMaterial extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String creatorId;
  @HiveField(2)
  late String status;
  @HiveField(3)
  late String visibility;
  @HiveField(4)
  late String editability;
  @HiveField(5)
  late String title;
  @HiveField(6)
  late String description;
  @HiveField(7)
  late String targetAudience;
  @HiveField(8)
  late String url;
  @HiveField(9)
  List<String> files = [];
  @HiveField(10)
  List<String> languageIds = [];
  @HiveField(11)
  List<String> typeIds = [];
  @HiveField(12)
  List<String> topics = [];
  @HiveField(13)
  List<HiveMaterialFeedback> feedbacks = [];
  @HiveField(14)
  late HiveDate dateCreated;
  @HiveField(15)
  late HiveDate dateUpdated;
  @HiveField(16)
  bool isNew = false;
  @HiveField(17)
  bool isUpdated = false;
  @HiveField(18)
  bool isDirty = false;

  HiveMaterial();

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
    this.feedbacks.addAll(material.feedbacks.map((MaterialFeedback feedback) {
          return HiveMaterialFeedback.from(feedback);
        }).toList());
    this.dateCreated = HiveDate.from(material.dateCreated);
    this.dateUpdated = HiveDate.from(material.dateUpdated);
  }
}
