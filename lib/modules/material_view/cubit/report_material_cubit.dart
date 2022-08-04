import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

part 'report_material_state.dart';

class ReportMaterialCubit extends Cubit<ReportMaterialState> {
  ReportMaterialCubit({
    required AuthenticationRepository authenticationRepository,
    required DataRepository dataRepository,
    required Material material,
  })  : _authenticationRepository = authenticationRepository,
        _dataRepository = dataRepository,
        _material = material,
        super(const ReportMaterialState());

  final AuthenticationRepository _authenticationRepository;
  final DataRepository _dataRepository;
  final Material _material;

  void textChanged(String text) => emit(ReportMaterialState(text: text));

  void reportSubmitted() {
    _dataRepository.addDelta(MaterialFeedbackCreateDelta(
      type: MaterialFeedback_Type.INAPPROPRIATE,
      materialId: _material.id,
      reporterId: _authenticationRepository.currentSession!.user.id,
      report: state.text,
    ));
    emit(state.asSubmitted());
  }
}
