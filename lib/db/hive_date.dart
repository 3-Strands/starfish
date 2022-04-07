import 'package:hive/hive.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

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

  // TODO: for Dev only, to be removed
  HiveDate.create(int year, int month, int day) {
    this.year = year;
    this.month = month;
    this.day = day;
  }

  Date toDate() {
    return Date(year: this.year, month: this.month, day: this.day);
  }

  String toString() {
    return '{ year: ${this.year}, month: ${this.month}, day: ${this.day} }';
  }
}

extension HiveDateExt on HiveDate {
  DateTime toDateTime() {
    String dateString = '${this.day}-${this.month}-${this.year}';
    return DateTimeUtils.toDateTime(dateString, 'dd-MM-yyyy');
  }
}
