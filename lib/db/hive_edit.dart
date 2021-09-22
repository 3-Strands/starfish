import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

part 'hive_edit.g.dart';

@HiveType(typeId: 11)
class HiveEdit extends HiveObject {
  @HiveField(0)
  String? username;
  @HiveField(1)
  DateTime? time;
  @HiveField(2)
  int? event;

  HiveEdit();

  HiveEdit.from(Edit edit) {
    this.username = edit.username;
    this.time = edit.time.toDateTime();
    this.event = edit.event.value;
  }

  String toString() {
    return '{ username: ${this.username}, time: ${this.time.toString()}, event: ${this.event} } }';
  }
}
