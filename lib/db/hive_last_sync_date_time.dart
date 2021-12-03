import 'package:hive/hive.dart';
import 'package:starfish/utils/date_time_utils.dart';

part 'hive_last_sync_date_time.g.dart';

@HiveType(typeId: 8)
class HiveLastSyncDateTime {
  @HiveField(0)
  int year;
  @HiveField(1)
  int month;
  @HiveField(2)
  int day;
  @HiveField(3)
  int hour;
  @HiveField(4)
  int minute;
  @HiveField(5)
  int second;

  HiveLastSyncDateTime({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });
}

extension HiveLastSyncDateTimeExt on HiveLastSyncDateTime {
  DateTime toDateTime() {
    String dateString =
        '${this.day}-${this.month}-${this.year} ${this.hour}:${this.minute}';
    return DateTimeUtils.toDateTime(dateString, 'dd-MM-yyyy HH:mm');
  }
}
