import 'package:hive/hive.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

part 'hive_date.g.dart';

@HiveType(typeId: 7)
class HiveDate extends Comparable {
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

  HiveDate.create(int year, int month, int day) {
    this.year = year;
    this.month = month;
    this.day = day;
  }

  Date toDate() {
    return Date(year: this.year, month: this.month, day: this.day);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDate &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;

  @override
  int compareTo(other) {
    if (year == other.year && month == other.month && day == other.day) {
      return 0;
    } else if (year > other.year ||
        (year == other.year && month > other.month) ||
        (year == other.year && month == other.month && day > other.day)) {
      return 1;
    } else {
      return -1;
    }
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

  HiveDate get toMonth {
    int currentMonth = this.month;
    int currentYear = this.year;
    return HiveDate.create(currentYear, currentMonth, 0);
  }

  // to get previous month and year
  HiveDate get previousMonth {
    int currentMonth = this.month;
    int currentYear = this.year;

    if (currentMonth > 1) {
      return HiveDate.create(currentYear, currentMonth - 1, 0);
    } else {
      return HiveDate.create(currentYear - 1, 12, 0);
    }
  }

  bool isOnOrAfter(HiveDate other) {
    return compareTo(other) == 0 || compareTo(other) == 1;
  }

  bool isOnOrBefore(HiveDate other) {
    return compareTo(other) == 0 || compareTo(other) == -1;
  }

  bool isAfter(HiveDate other) {
    return compareTo(other) == 1;
  }

  bool isBefore(HiveDate other) {
    return compareTo(other) == -1;
  }
}
