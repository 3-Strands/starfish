part of 'project_report_cubit.dart';

@immutable
class ProjectReportState {
  const ProjectReportState({
    required this.group,
    required this.month,
    required this.groupOutputs,
  });

  final Group group;
  final Date month;
  final Map<String, List<Output>> groupOutputs;

  ProjectReportState copyWith({
    Group? group,
    Date? month,
    Map<String, List<Output>>? groupOutputs,
  }) =>
      ProjectReportState(
        group: group ?? this.group,
        month: month ?? this.month,
        groupOutputs: groupOutputs ?? this.groupOutputs,
      );

  List<OutputMarkerWithValue> get outputMarkers {
    return group.outputMarkers
        .map((outputMarker) => OutputMarkerWithValue(
              outputMarker: outputMarker,
              output: _getOutputMarkerValue(
                  groupId: group.id,
                  month: month,
                  markerId: outputMarker.markerId),
            ))
        .toList();
  }

  Output? _getOutputMarkerValue({
    required String groupId,
    required Date month,
    required String markerId,
  }) {
    return (groupOutputs[groupId] ?? []).firstWhereOrNull((output) =>
        output.outputMarker.markerId == markerId &&
        output.month.isSameMonth(month));
  }
}

class OutputMarkerWithValue {
  OutputMarkerWithValue({required this.outputMarker, this.output});

  final OutputMarker outputMarker;
  final Output? output;
}
