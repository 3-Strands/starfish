import 'package:hive/hive.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

part 'hive_date.g.dart';

@HiveType(typeId: 7)
class HiveDate implements Comparable {
  @HiveField(0)
  final int year;
  @HiveField(1)
  final int month;
  @HiveField(2)
  final int day;

  const HiveDate({required this.year, required this.month, required this.day});

  static const none = const HiveDate(year: 0, month: 0, day: 0);

  HiveDate.from(Date date) :
    year = date.year,
    month = date.month,
    day = date.day;

  HiveDate.fromDateTime(DateTime dateTime) :
    year = dateTime.year,
    month = dateTime.month,
    day = dateTime.day;

  HiveDate.create(this.year, this.month, this.day);

  Date toDate() {
    return Date(year: year, month: month, day: day);
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

  /// Gets a number representation of this date for comparison purposes.
  /// Years are weighted more than months, which are weighted more than days.
  int get _numberRepresentation => day + month * 100 + year * 1000;

  @override
  int compareTo(other) {
    if (other is HiveDate) {
      return _numberRepresentation.compareTo(other._numberRepresentation);
      // if (year == other.year && month == other.month && day == other.day) {
      //   return 0;
      // } else if (year > other.year ||
      //     (year == other.year && month > other.month) ||
      //     (year == other.year && month == other.month && day > other.day)) {
      //   return 1;
      // } else {
      //   return -1;
      // }
    }
    throw TypeError();
  }

  String toString() {
    return '{ year: ${this.year}, month: ${this.month}, day: ${this.day} }';
  }

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
