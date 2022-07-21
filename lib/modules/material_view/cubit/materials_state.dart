part of 'materials_cubit.dart';

@immutable
class MaterialsState {
  MaterialsState({
    required List<HiveMaterial> materials,
    required RelatedMaterials relatedMaterials,
    int pagesToShow = 1,
    Set<String>? selectedLanguages,
    Set<String>? selectedTopics,
    MaterialFilter actions = MaterialFilter.NO_FILTER_APPLIED,
    String query = "",
  })
  : _materials = materials,
    _relatedMaterials = relatedMaterials,
    _pagesToShow = pagesToShow,
    _selectedLanguages = selectedLanguages ?? Set(),
    _selectedTopics = selectedTopics ?? Set(),
    _actions = actions,
    _query = query;

  static const itemsPerPage = 20;

  final List<HiveMaterial> _materials;
  final RelatedMaterials _relatedMaterials;
  final int _pagesToShow;
  final Set<String> _selectedLanguages;
  final Set<String> _selectedTopics;
  final MaterialFilter _actions;
  final String _query;

  int get pagesToShow => _pagesToShow;
  MaterialFilter get actions => _actions;
  String get query => _query;

  MaterialsPageView get materialsToShow {
    var materials = _materials;

    if (_selectedLanguages.isNotEmpty) {
      materials = materials.where((material) =>
        material.languageIds.toSet().intersection(_selectedLanguages).length > 0
      ).toList();
    }

    if (_selectedTopics.isNotEmpty) {
      materials = materials.where((material) =>
        material.topicIds.toSet().intersection(_selectedTopics).length > 0
      ).toList();
    }

    if (_query.isNotEmpty) {
      final lowerCaseQuery = _query.toLowerCase();
      materials = materials.where((material) =>
        material.title.toLowerCase().contains(lowerCaseQuery)
        || material.description.toLowerCase().contains(lowerCaseQuery)
      ).toList();
    }

    var materialWithStatus = materials.map((material) => MaterialWithAssignedStatus(
      material: material,
      status: _assignedMaterialStatus(material),
      isAssignedToGroupWithLeaderRole: _materialIsAssignedToGroupWithLeaderRole(material),
    )).toList();

    if (_actions != MaterialFilter.NO_FILTER_APPLIED) {
      materialWithStatus = materialWithStatus.where(_materialPassesActionFilter).toList();
    }

    final numberToTake = _pagesToShow * itemsPerPage;
    if (numberToTake < materialWithStatus.length) {
      return MaterialsPageView(materialWithStatus.take(numberToTake).toList(), true);
    }

    return MaterialsPageView(materialWithStatus, false);
  }

  MaterialsState copyWith({
    List<HiveMaterial>? materials,
    RelatedMaterials? relatedMaterials,
    int? pagesToShow,
    Set<String>? selectedLanguages,
    Set<String>? selectedTopics,
    MaterialFilter? actions,
    String? query,
  }) => MaterialsState(
    materials: materials ?? this._materials,
    relatedMaterials: relatedMaterials ?? this._relatedMaterials,
    pagesToShow: pagesToShow ?? this._pagesToShow,
    selectedLanguages: selectedLanguages ?? this._selectedLanguages,
    selectedTopics: selectedTopics ?? this._selectedTopics,
    actions: actions ?? this._actions,
    query: query ?? this._query,
  );

  bool _materialPassesActionFilter(MaterialWithAssignedStatus material) {
    switch (_actions) {
      case MaterialFilter.ASSIGNED_AND_COMPLETED:
        return material.status == ActionStatus.DONE;
      case MaterialFilter.ASSIGNED_AND_INCOMPLETED:
        return material.status == ActionStatus.NOT_DONE || material.status == ActionStatus.OVERDUE;
      case MaterialFilter.ASSIGNED_TO_GROUP_I_LEAD:
        return material.isAssignedToGroupWithLeaderRole;
      default:
        return true;
    }
  }

  ActionStatus? _assignedMaterialStatus(HiveMaterial material) {
    return _relatedMaterials.materialsAssignedToMe[material.id];
  }

  bool _materialIsAssignedToGroupWithLeaderRole(HiveMaterial material) {
    return _relatedMaterials.materialsAssignedToGroupWithLeaderRole.contains(material.id);
  }
}

class MaterialsPageView {
  const MaterialsPageView(this.materials, this.hasMore);

  final List<MaterialWithAssignedStatus> materials;
  final bool hasMore;
}
