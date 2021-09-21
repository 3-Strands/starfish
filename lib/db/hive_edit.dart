import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

class HiveEdit {
  @HiveField(0)
  String? username;
  @HiveField(1)
  HiveDate? date;

  HiveEdit();

  HiveEdit.from(Edit edit) {
    this.username = edit.username;
    this.date = HiveDate.from(edit.date);
  }

  Edit toEdit() {
    return Edit(username: this.username, date: this.date?.toDate());
  }

  String toString() {
    return '{ username: ${this.username}, date: ${this.date.toString()} }';
  }
}
