import 'package:hive/hive.dart';

import 'hive_keyed.dart';

abstract class HiveConcrete extends HiveObject implements HiveKeyed {
  String get id;

  /// Used to uniquely key this item in its box.
  String get key => id;
}
