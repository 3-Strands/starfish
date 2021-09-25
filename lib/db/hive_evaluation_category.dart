import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_evaluation_category.g.dart';

@HiveType(typeId: 14)
class HiveEvaluationCategory extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;

  HiveEvaluationCategory({
    this.id,
    this.name,
  });

  HiveEvaluationCategory.from(EvaluationCategory category) {
    this.id = category.id;
    this.name = category.name;
  }
}
