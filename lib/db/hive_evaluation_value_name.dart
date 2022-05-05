import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_evaluation_value_name.g.dart';

@HiveType(typeId: 24)
class HiveEvaluationValueName extends HiveObject {
  @HiveField(0)
  int? value;
  @HiveField(1)
  String? name;

  HiveEvaluationValueName({
    this.value,
    this.name,
  });

  HiveEvaluationValueName.from(EvaluationValueName valueName) {
    this.value = valueName.value;
    this.name = valueName.name;
  }
}
