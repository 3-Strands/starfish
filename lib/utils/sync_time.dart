import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/db/hive_last_sync_date_time.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/utils/date_time_utils.dart';

class SyncTime {
  late Box<HiveLastSyncDateTime> _lastSyncDataTimeBox;

  // SyncTime() {
  //   _lastSyncDataTimeBox =
  //       Hive.box<HiveLastSyncDateTime>(Database.LAST_SYNC_BOX);
  // }

  // String lastSyncDateTimeString() {
  //   HiveLastSyncDateTime _lastSyncDateTime = _lastSyncDataTimeBox.values.first;
  //   return DateTimeUtils.formatDate(
  //       _lastSyncDateTime.toDateTime(), "dd-MMM-yyyy HH:mm");
  // }

  Date? lastSyncDateTime() {
    // HiveLastSyncDateTime? _lastSyncDateTime =
    //     _lastSyncDataTimeBox.values.firstOrNull;
    // if (_lastSyncDateTime == null) {
    //   return null;
    // }

    // DateTime _utc = _lastSyncDateTime.toDateTime().toUtc();
    // return Date(year: _utc.year, month: _utc.month, day: _utc.day);
    return null;
  }
}
