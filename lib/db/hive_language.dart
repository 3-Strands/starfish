import 'package:hive/hive.dart';

part 'hive_language.g.dart';

@HiveType(typeId: 1)
class HiveLanguage {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  HiveLanguage({required this.id, required this.name});
}
