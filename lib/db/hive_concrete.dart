import 'package:hive/hive.dart';

abstract class HiveConcrete extends HiveObject {
  String? id;

  bool matches(Object other) {
    return other is HiveConcrete && other.id == id;
  }
}