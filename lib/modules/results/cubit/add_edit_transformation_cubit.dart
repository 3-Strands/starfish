import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/repositories/data_repository.dart';
import 'package:starfish/src/deltas.dart';
import 'package:starfish/src/generated/file_transfer.pbenum.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/file_system.dart';

part 'add_edit_transformation_state.dart';

class AddEditTransformationCubit extends Cubit<AddEditTransformationState> {
  AddEditTransformationCubit({
    required DataRepository dataRepository,
    required Date month,
    required String groupId,
    required String userId,
    Transformation? transformation,
  })  : _transformation = transformation,
        _dataRepository = dataRepository,
        _id = transformation?.id ?? UuidGenerator.uuid(),
        _groupId = groupId,
        _userId = userId,
        super(AddEditTransformationState(
          month: month,
          previouslySelectedFiles: transformation?.fileReferences ?? const [],
          newlySelectedFiles: const [],
        ));

  final DataRepository _dataRepository;
  Transformation? _transformation;
  final String _id;
  final String _groupId;
  final String _userId;

  void fileAdded(File file) {
    emit(state.copyWith(
      newlySelectedFiles: [
        ...state.newlySelectedFiles,
        file,
      ],
    ));

    final files = <String>[
      ...state.previouslySelectedFiles
          .map((fileReference) => fileReference.filename),
      ...state.newlySelectedFiles.map((file) => file.path.split("/").last),
    ];

    _addTransformationDelta(files: files);

    _dataRepository.addDelta(FileReferenceCreateDelta(
      entityId: _id,
      entityType: EntityType.TRANSFORMATION,
      filename: file.path.split("/").last,
      filepath: file.path,
    ));
  }

  void fileRemoved(File file) {
    emit(state.copyWith(
      newlySelectedFiles:
          state.newlySelectedFiles.where((f) => f != file).toList(),
    ));
  }

  void impactStoryChanged(String impactStory) {
    impactStory = impactStory.trim();
    if (_transformation == null && impactStory.isEmpty) {
      // Don't save if they didn't actually do anything
      return;
    }
    _addTransformationDelta(impactStory: impactStory);
  }

  void _addTransformationDelta({String? impactStory, List<String>? files}) {
    final transformation = _transformation;
    _dataRepository.addDelta(
      transformation == null
          ? TransformationCreateDelta(
              id: _id,
              userId: _userId,
              groupId: _groupId,
              month: state.month,
              impactStory: impactStory,
              files: files,
            )
          : TransformationUpdateDelta(
              transformation,
              impactStory: impactStory,
              files: files,
            ),
    );
    _transformation = globalHiveApi.transformation.get(_id);
  }
}
