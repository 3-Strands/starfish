import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/wrappers/file_system.dart';

part 'add_edit_transformation_state.dart';

class AddEditTransformaitonCubit extends Cubit<AddEditTransformationState> {
  AddEditTransformaitonCubit({
    required DataRepository dataRepository,
    required Date month,
    required GroupUser groupUser,
    Transformation? transformation,
  })  : _transformation = transformation,
        _dataRepository = dataRepository,
        super(AddEditTransformationState(
          groupUser: groupUser,
          month: month,
          impactStory: transformation?.impactStory ?? '',
          previouslySelectedFiles: transformation?.fileReferences ?? const [],
          newlySelectedFiles: const [],
        )) {
    _subscription = dataRepository.groups.listen((groups) {});
  }

  late StreamSubscription<List<Group>> _subscription;

  final DataRepository _dataRepository;
  final Transformation? _transformation;

  void addFile(File file) => emit(
      state.copyWith(newlySelectedFiles: [...state.newlySelectedFiles, file]));

  void removeFile(File file) {
    state.newlySelectedFiles.removeWhere((f) => f == file);
    emit(state.copyWith(newlySelectedFiles: state.newlySelectedFiles));
  }

  void updateImpactStory(String impactStory) {
    emit(state.copyWith(impactStory: impactStory));
  }

  void saveImpactStory() {
    _dataRepository.addDelta(TransformationCreateDelta(
      userId: state.groupUser.userId,
      groupId: state.groupUser.groupId,
      month: state.month,
      impactStory: state.impactStory,
    ));
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
