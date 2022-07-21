import 'package:hive/hive.dart';
import 'package:starfish/db/hive_concrete.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'hive_language.g.dart';

@HiveType(typeId: 1)
class HiveLanguage extends HiveConcrete {
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

  factory HiveLanguage.from(Language language) {
    return HiveLanguage(
      id: language.id,
      name: language.name,
    );
  }

  static String toDisplay(HiveLanguage item) => item.name;

  String toString() {
    return '{id: ${this.id}, name: ${this.name}}';
  }
}
