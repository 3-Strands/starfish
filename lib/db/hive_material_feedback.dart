import 'package:hive/hive.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_material_feedback.g.dart';

@HiveType(typeId: 6)
class HiveMaterialFeedback extends HiveObject {
  @HiveField(0)
  String id = '';
  @HiveField(1)
  String type = '';
  @HiveField(2)
  String reporterId = '';
  @HiveField(3)
  String report = '';
  @HiveField(4)
  String response = '';
  @HiveField(5)
  String materialId = '';

  @HiveField(14)
  bool isNew = false;
  @HiveField(15)
  bool isUpdated = false;
  @HiveField(16)
  bool isDirty = false;

  HiveMaterialFeedback();

  HiveMaterialFeedback.from(MaterialFeedback feedback) {
    this.id = feedback.id;
    this.type = feedback.type.toString();
    this.reporterId = feedback.reporterId;
    this.report = feedback.report;
    this.response = feedback.response;
    this.materialId = feedback.materialId;
  }
}
