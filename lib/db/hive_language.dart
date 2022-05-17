import 'package:hive/hive.dart';
import 'package:starfish/select_items/select_drop_down.dart';

part 'hive_language.g.dart';

@HiveType(typeId: 1)
class HiveLanguage implements Named {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  HiveLanguage({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLanguage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String getName() => name;
}
