import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/db/hive_date.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

part 'hive_output.g.dart';

@HiveType(typeId: 22)
class HiveOutput extends HiveObject {
  @HiveField(0)
  String? groupId;
  @HiveField(1)
  String? projectId;
  @HiveField(2)
  String? markerId;
  @HiveField(3)
  String? markerName;
  @HiveField(4)
  HiveDate? month;
  @HiveField(5)
  int value = 0;
  @HiveField(6)
  bool isNew = false;
  @HiveField(7)
  bool isUpdated = false;
  @HiveField(8)
  bool isDirty = false;

  HiveOutput({
    this.groupId,
    this.projectId,
    this.markerId,
    this.markerName,
    this.month,
    this.value = 0,
    this.isNew = false,
    this.isUpdated = false,
    this.isDirty = false,
  });

  HiveOutput.from(Output output) {
    this.groupId = output.groupId;
    this.projectId = output.projectId;
    this.markerId = output.markerId;
    this.markerName = output.markerName;
    this.month = HiveDate.from(output.month);
    this.value = output.value.toInt();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutput &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          projectId == other.projectId &&
          markerId == other.markerId &&
          month == other.month;

  @override
  int get hashCode =>
      groupId.hashCode ^
      projectId.hashCode ^
      markerId.hashCode ^
      month.hashCode;

  String toString() {
    return '''{ groupId: ${this.groupId}, projectId: ${this.projectId}, 
            markerId: ${this.markerId}, markerName: ${this.markerName}, 
            month: ${this.month}, value: ${this.value} }''';
  }
}
