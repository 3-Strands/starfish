import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_transformation.dart';

class TransformationProvider {
  late Box<HiveTransformation> _transformationBox;
  late Box<HiveFile> _fileBox;

  TransformationProvider() {
    _transformationBox =
        Hive.box<HiveTransformation>(HiveDatabase.TRANSFORMATION_BOX);
    _fileBox = Hive.box<HiveFile>(HiveDatabase.FILE_BOX);
  }

  List<HiveTransformation> getGroupUserTransformations(
      String userId, String groupId) {
    return _transformationBox.values
        .where((element) =>
            element.userId! == userId && element.groupId! == groupId)
        .toList();
  }

  Future<void> createUpdateTransformation(HiveTransformation _transformation,
      {List<HiveFile>? transformationFiles}) async {
    if (transformationFiles != null && transformationFiles.length > 0) {
      createUpdateTransformationFiles(transformationFiles);
    }
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

  createUpdateTransformationFiles(List<HiveFile> files) {
    files.forEach((file) {
      int _currentIndex = -1;
      _fileBox.values.toList().asMap().forEach((key, hiveFile) {
        if (hiveFile == file) {
          _currentIndex = key;
        }
      });

      if (_currentIndex > -1) {
        _fileBox.putAt(_currentIndex, file);
      } else {
        _fileBox.add(file);
      }
    });
  }
}
