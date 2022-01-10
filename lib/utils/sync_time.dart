import 'package:hive/hive.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/utils/date_time_utils.dart';

class SyncTime {
  late Box<HiveLastSyncDateTime> _lastSyncDataTimeBox;

  SyncTime() {
    _lastSyncDataTimeBox =
        Hive.box<HiveLastSyncDateTime>(HiveDatabase.LAST_SYNC_BOX);
  }

  String lastSyncDateTimeString() {
    HiveLastSyncDateTime _lastSyncDateTime = _lastSyncDataTimeBox.values.first;
    return DateTimeUtils.formatDate(
        _lastSyncDateTime.toDateTime(), "dd-MMM-yyyy HH:mm");
  }
}
