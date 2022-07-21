import 'package:hive/hive.dart';
import 'package:starfish/db/hive_concrete.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_material_feedback.g.dart';

@HiveType(typeId: 6)
class HiveMaterialFeedback extends HiveConcrete {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int type;
  @HiveField(2)
  final String reporterId;
  @HiveField(3)
  final String report;
  @HiveField(4)
  String response;
  @HiveField(5)
  final String materialId;

  @HiveField(14)
  bool isNew = false;
  @HiveField(15)
  bool isUpdated = false;
  @HiveField(16)
  bool isDirty = false;

  HiveMaterialFeedback({
    required this.id,
    required this.type,
    required this.reporterId,
    required this.report,
    this.response = '',
    required this.materialId,
  });

  HiveMaterialFeedback.from(MaterialFeedback feedback) :
    id = feedback.id,
    type = feedback.type.value,
    reporterId = feedback.reporterId,
    report = feedback.report,
    response = feedback.response,
    materialId = feedback.materialId;
}
