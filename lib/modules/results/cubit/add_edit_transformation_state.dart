part of 'add_edit_transformation_cubit.dart';

@immutable
class AddEditTransformationState {
  const AddEditTransformationState({
    required this.month,
    required this.previouslySelectedFiles,
    required this.newlySelectedFiles,
  });

  final Date month;
  final List<FileReference> previouslySelectedFiles;
  final List<File> newlySelectedFiles;

  AddEditTransformationState copyWith({
    Date? month,
    String? impactStory,
    List<FileReference>? previouslySelectedFiles,
    List<File>? newlySelectedFiles,
  }) =>
      AddEditTransformationState(
        month: month ?? this.month,
        previouslySelectedFiles:
            previouslySelectedFiles ?? this.previouslySelectedFiles,
        newlySelectedFiles: newlySelectedFiles ?? this.newlySelectedFiles,
      );
}
