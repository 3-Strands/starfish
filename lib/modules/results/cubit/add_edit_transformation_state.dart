part of 'add_edit_transformation_cubit.dart';

@immutable
class AddEditTransformationState {
  const AddEditTransformationState({
    required this.groupUser,
    required this.month,
    required this.impactStory,
    required this.previouslySelectedFiles,
    required this.newlySelectedFiles,
  });

  final GroupUser groupUser;
  final Date month;
  final String impactStory;
  final List<FileReference> previouslySelectedFiles;
  final List<File> newlySelectedFiles;

  AddEditTransformationState copyWith({
    GroupUser? groupUser,
    Date? month,
    String? impactStory,
    List<FileReference>? previouslySelectedFiles,
    List<File>? newlySelectedFiles,
  }) =>
      AddEditTransformationState(
        groupUser: groupUser ?? this.groupUser,
        month: month ?? this.month,
        impactStory: impactStory ?? this.impactStory,
        previouslySelectedFiles:
            previouslySelectedFiles ?? this.previouslySelectedFiles,
        newlySelectedFiles: newlySelectedFiles ?? this.newlySelectedFiles,
      );
}
