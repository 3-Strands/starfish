import 'package:hive/hive.dart';

part 'hive_country.g.dart';

@HiveType(typeId: 0)
class HiveCountry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String diallingCode;

  HiveCountry(
      {required this.id, required this.name, required this.diallingCode});
}
