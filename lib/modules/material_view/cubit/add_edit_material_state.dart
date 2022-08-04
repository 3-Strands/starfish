part of 'add_edit_material_cubit.dart';

enum MaterialError {
  noTitle,
  noDescription,
  noWebLinkOrFile,
  noLanguage,
}

@immutable
class AddEditMaterialState {
  const AddEditMaterialState({
    required this.languages,
    required this.types,
    required this.topics,
    required this.selectedLanguages,
    required this.selectedTypes,
    required this.selectedTopics,
    required this.previouslySelectedFiles,
    required this.newlySelectedFiles,
    required this.title,
    required this.description,
    required this.url,
    required this.visibility,
    required this.editability,
    required this.history,
    this.error,
  });

  final List<Language> languages;
  final List<MaterialType> types;
  final List<MaterialTopic> topics;
  final Set<String> selectedLanguages;
  final Set<String> selectedTypes;
  final Set<String> selectedTopics;
  final List<FileReference> previouslySelectedFiles;
  final List<File> newlySelectedFiles;
  final String title;
  final String description;
  final String url;
  final Material_Visibility visibility;
  final Material_Editability editability;
  final List<Edit> history;

  final MaterialError? error;

  int get totalFiles =>
      previouslySelectedFiles.length + newlySelectedFiles.length;

  bool get hasAnyFilesSelected => totalFiles > 0;

  bool get hasMaxFilesSelected => totalFiles >= 5;

  AddEditMaterialState copyWith({
    List<Language>? languages,
    List<MaterialType>? types,
    List<MaterialTopic>? topics,
    Set<String>? selectedLanguages,
    Set<String>? selectedTypes,
    Set<String>? selectedTopics,
    List<FileReference>? previouslySelectedFiles,
    List<File>? newlySelectedFiles,
    String? title,
    String? description,
    String? url,
    Material_Visibility? visibility,
    Material_Editability? editability,
    List<Edit>? history,
    MaterialError? error,
  }) =>
      AddEditMaterialState(
        languages: languages ?? this.languages,
        types: types ?? this.types,
        topics: topics ?? this.topics,
        selectedLanguages: selectedLanguages ?? this.selectedLanguages,
        selectedTypes: selectedTypes ?? this.selectedTypes,
        selectedTopics: selectedTopics ?? this.selectedTopics,
        previouslySelectedFiles:
            previouslySelectedFiles ?? this.previouslySelectedFiles,
        newlySelectedFiles: newlySelectedFiles ?? this.newlySelectedFiles,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        visibility: visibility ?? this.visibility,
        editability: editability ?? this.editability,
        history: history ?? this.history,
        // We reset this to null every time unless explicitly passed.
        error: error,
      );
}
