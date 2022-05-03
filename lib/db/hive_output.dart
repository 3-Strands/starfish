import 'package:fixnum/fixnum.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/db/hive_output_marker.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

part 'hive_output.g.dart';

@HiveType(typeId: 22)
class HiveOutput extends HiveObject {
  @HiveField(0)
  String? groupId;
  @HiveField(1)
  HiveOutputMarker? outputMarker;
  @HiveField(2)
  HiveDate? month;
  @HiveField(3)
  String? value;
  @HiveField(4)
  bool isNew = false;
  @HiveField(5)
  bool isUpdated = false;
  @HiveField(6)
  bool isDirty = false;

  HiveOutput({
    this.groupId,
    this.month,
    this.value,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
  });

  HiveOutput.from(Output output) {
    this.groupId = output.groupId;
    this.outputMarker = HiveOutputMarker.from(output.outputMarker);
    this.month = HiveDate.from(output.month);
    this.value = output.value.toString();
  }

  Output toOutput() {
    return Output(
        groupId: this.groupId,
        outputMarker: this.outputMarker?.toOutputMarker(),
        month: this.month?.toDate(),
        value: Int64.parseRadix(this.value!, 10));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutput &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          outputMarker == other.outputMarker &&
          month == other.month;

  @override
  int get hashCode => groupId.hashCode ^ outputMarker.hashCode ^ month.hashCode;

  String toString() {
    return '''{ groupId: ${this.groupId}, outputMarker: ${this.outputMarker}, 
              month: ${this.month}, value: ${this.value} }''';
  }
}
