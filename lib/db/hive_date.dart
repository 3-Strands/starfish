import 'package:hive/hive.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';

part 'hive_date.g.dart';

@HiveType(typeId: 7)
class HiveDate {
  @HiveField(0)
  late int year;
  @HiveField(1)
  late int month;
  @HiveField(2)
  late int day;

  HiveDate();

  HiveDate.from(Date date) {
    this.year = date.year;
    this.month = date.month;
    this.day = date.day;
  }

  Date toDate() {
    return Date(year: this.year, month: this.month, day: this.day);
  }

  String toString() {
    return '{ year: ${this.year}, month: ${this.month}, day: ${this.day} }';
  }
}
