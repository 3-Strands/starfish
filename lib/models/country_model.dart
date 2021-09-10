import 'package:hive/hive.dart';

part 'country_model.g.dart';

@HiveType(typeId: 0)
class CountryModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String diallingCode;

  CountryModel(
      {required this.id, required this.name, required this.diallingCode});
}
