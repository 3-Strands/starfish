import 'package:hive/hive.dart';

part 'hive_language.g.dart';

@HiveType(typeId: 1)
class HiveLanguage extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  HiveLanguage({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLanguage &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

 static String toDisplay(HiveLanguage item) => item.name;
}
