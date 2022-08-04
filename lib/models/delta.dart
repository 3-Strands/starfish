import 'package:hive/hive.dart';

class Delta extends HiveObject {
  Delta({
    required this.typeId,
    this.updateFields,
    required this.pointer,
  });

  final int typeId;
  final List<String>? updateFields;
  final Pointer pointer;

  @override
  get key => '$typeId:${pointer.key}';

  // get isCreateDelta =>

  void merge(Delta other) {
    assert(key == other.key, 'Attempting to merge non-matching deltas');
  }
}

abstract class Pointer {
  String get key;
}

// @HiveType(typeId: 201)
class SimplePointer extends Pointer {
  SimplePointer(this.key);

  // @HiveField(0)
  final String key;
}

// @HiveType(typeId: 202)
class NestedPointer extends Pointer {
  NestedPointer({required this.parentKey, required this.modelKey});

  // @HiveField(0)
  final String parentKey;
  // @HiveField(1)
  final String modelKey;

  @override
  String get key => '$parentKey:$modelKey';
}
