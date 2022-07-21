import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_feedback.dart';
import 'package:starfish/repositories/authentication_repository.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

part 'report_material_state.dart';

class ReportMaterialCubit extends Cubit<ReportMaterialState> {
  ReportMaterialCubit({
    required AuthenticationRepository authenticationRepository,
    required HiveMaterial material,
  })  : _authenticationRepository = authenticationRepository,
        _material = material,
        super(const ReportMaterialState());

  final AuthenticationRepository _authenticationRepository;
  final HiveMaterial _material;

  void textChanged(String text) => emit(ReportMaterialState(text: text));

  void reportSubmitted() {
    _material.addFeedback(HiveMaterialFeedback(
      id: UuidGenerator.uuid(),
      type: 1,
      reporterId: _authenticationRepository.currentSession!.user.id,
      report: state.text,
      materialId: _material.id,
    ));
    emit(state.asSubmitted());
  }
}
