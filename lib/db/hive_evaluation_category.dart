import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_evaluation_value_name.dart';
import 'package:starfish/db/providers/evaluation_category_provider.dart';
import 'package:starfish/select_items/select_list.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_evaluation_category.g.dart';

@HiveType(typeId: 14)
class HiveEvaluationCategory extends HiveObject implements Named {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(3)
  List<HiveEvaluationValueName>? valueNames;

  HiveEvaluationCategory({
    this.id,
    this.name,
  });

  HiveEvaluationCategory.from(EvaluationCategory category) {
    this.id = category.id;
    this.name = category.name;
    this.valueNames = category.valueNames
        .map((e) => HiveEvaluationValueName.from(e))
        .toList();
  }

  @override
  String getName() => name ?? '';
}

extension HiveEvaluationCategoryExt on HiveEvaluationCategory {
  String getEvaluationNameFromValue(int value) {
    HiveEvaluationValueName? _hiveEvaluationValueName =
        this.valueNames?.firstWhereOrNull((element) => element.value! == value);

    return _hiveEvaluationValueName != null
        ? _hiveEvaluationValueName.name!
        : value.toString();
  }
}
