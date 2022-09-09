import 'dart:async';

import 'package:collection/collection.dart';
import 'package:bloc/bloc.dart';
import 'package:fixnum/fixnum.dart';
import 'package:meta/meta.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';

part 'project_report_state.dart';

class ProjectReportCubit extends Cubit<ProjectReportState> {
  ProjectReportCubit({
    required DataRepository dataRepository,
    required Group group,
    required Date month,
  })  : _dataRepository = dataRepository,
        super(ProjectReportState(
          group: group,
          month: month,
          groupOutputs: dataRepository.groupOutputs,
        )) {
    _subscriptions = [
      dataRepository.groups.listen((groups) {
        state.copyWith(groupOutputs: _dataRepository.groupOutputs);
      }),
      dataRepository.outputs.listen((outputs) {
        state.copyWith(groupOutputs: _dataRepository.groupOutputs);
      }),
    ];
  }

  late List<StreamSubscription> _subscriptions;

  final DataRepository _dataRepository;

  void updateOuputMarkerValue(
      {required OutputMarker outputMarker,
      required Int64 value,
      Output? output}) {
    _dataRepository.addDelta(output == null
        ? OutputCreateDelta(
            groupId: state.group.id,
            month: state.month,
            outputMarker: outputMarker,
            value: value,
          )
        : OutputUpdateDelta(
            output,
            value: value,
          ));
  }

  @override
  Future<void> close() {
    _subscriptions.forEach((subscription) => subscription.cancel());
    return super.close();
  }
}
