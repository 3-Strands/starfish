// import 'package:collection/src/iterable_extensions.dart';
// import 'package:hive/hive.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_evaluation_category.dart';

// class EvaluationCategoryProvider {
//   late Box<HiveEvaluationCategory> _evaluationCategoryBox;

//   EvaluationCategoryProvider() {
//     _evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
//         HiveDatabase.EVALUATION_CATEGORIES_BOX);
//   }

//   HiveEvaluationCategory? getCategoryById(String categoryId) {
//     return _evaluationCategoryBox.values
//         .firstWhereOrNull((element) => element.id == categoryId);
//   }
// }
