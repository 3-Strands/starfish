import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/src/generated/google/protobuf/timestamp.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

class HiveEdit {
  @HiveField(0)
  String? username;
  @HiveField(1)
  Timestamp? time;
  @HiveField(2)
  int? event;

  HiveEdit();

  HiveEdit.from(Edit edit) {
    this.username = edit.username;
    this.time = edit.time;
    this.event = edit.event.value;
  }

  Edit toEdit() {
    return Edit(
        username: this.username,
        time: this.time,
        event: Edit_Event.valueOf(this.event!));
  }

  String toString() {
    return '{ username: ${this.username}, time: ${this.time.toString()}, event: ${this.event} } }';
  }
}
