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

  Future<void> createUpdateTransformation(
      HiveTransformation _transformation) async {
    int _currentIndex = -1;
    _transformationBox.values.toList().asMap().forEach((key, trasnform) {
      if (trasnform.id == _transformation.id) {
        _currentIndex = key;
      }
    });

    if (_currentIndex > -1) {
      return _transformationBox.putAt(_currentIndex, _transformation);
    } else {
      _transformationBox.add(_transformation);
    }
  }
}
