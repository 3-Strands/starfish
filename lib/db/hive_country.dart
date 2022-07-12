import 'package:hive/hive.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCountry &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory HiveCountry.fromGrpcCountry(Country country) {
    return HiveCountry(
      id: country.id,
      name: country.name,
      diallingCode: country.diallingCode,
    );
  }

  static String toDisplay(HiveCountry item) => item.name;
}
