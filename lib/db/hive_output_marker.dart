import 'package:hive_flutter/hive_flutter.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

part 'hive_output_marker.g.dart';

@HiveType(typeId: 23)
class HiveOutputMarker extends HiveObject {
  @HiveField(0)
  String? projectId;
  @HiveField(1)
  String? markerId;
  @HiveField(2)
  String? markerName;

  HiveOutputMarker({
    this.projectId,
    this.markerId,
    this.markerName,
  });

  HiveOutputMarker.from(OutputMarker outputMarker) {
    this.projectId = outputMarker.projectId;
    this.markerId = outputMarker.markerId;
    this.markerName = outputMarker.markerName;
  }

  OutputMarker toOutputMarker() {
    return OutputMarker(
        projectId: this.projectId,
        markerId: this.projectId,
        markerName: this.markerName);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveOutputMarker &&
          runtimeType == other.runtimeType &&
          projectId == other.projectId &&
          markerId == other.markerId;

  @override
  int get hashCode => projectId.hashCode ^ markerId.hashCode;

  String toString() {
    return '''{ projectId: ${this.projectId},  markerId: ${this.markerId}, markerName: ${this.markerName} }''';
  }
}
