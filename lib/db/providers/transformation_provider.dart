import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_transformation.dart';

class TransformationProvider {
  late Box<HiveTransformation> _transformationBox;

  TransformationProvider() {
    _transformationBox =
        Hive.box<HiveTransformation>(HiveDatabase.TRANSFORMATION_BOX);
  }

  List<HiveTransformation> getGroupUserTransformations(
      String userId, String groupId) {
    return _transformationBox.values
        .where((element) =>
            element.userId! == userId && element.groupId! == groupId)
        .toList();
  }
}
