import 'package:hive/hive.dart';
import 'package:starfish/apis/hive_api.dart';
import 'package:starfish/db/hive_action.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/enums/action_status.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

extension AsList<T> on Box<T> {
  List<T> asList() => values.toList();
}

class DataRepository {
  DataRepository({
    HiveApiInterface hiveApi = globalHiveApi,
  }) : _hiveApi = hiveApi;

  final HiveApiInterface _hiveApi;

  Stream<List<T>> _streamBox<T>(Box<T> box) =>
      box.watch().map((_) => box.asList());

  // ------------------- Materials -------------------

  Stream<List<HiveMaterial>> get materials => _streamBox(_hiveApi.material);
  List<HiveMaterial> get currentMaterials => _hiveApi.material.asList();

  Stream<List<HiveMaterialTopic>> get materialTopics =>
      _streamBox(_hiveApi.materialTopic);
  List<HiveMaterialTopic> get currentMaterialTopics =>
      _hiveApi.materialTopic.asList();

  Stream<List<HiveMaterialType>> get materialTypes =>
      _streamBox(_hiveApi.materialType);
  List<HiveMaterialType> get currentMaterialTypes =>
      _hiveApi.materialType.asList();

  void updateMaterial(HiveMaterial material, {required List<HiveFile> files}) {
    throw UnimplementedError();
  }

  void deleteMaterial(HiveMaterial material) {
    throw UnimplementedError();
  }

  List<HiveAction> getAllActiveActions() {
    return _hiveApi.action.values.where((action) {
      // Exclude deleted actions
      if (action.isDirty) {
        return false;
      }
      return action.group?.status != Group_Status.INACTIVE.value;
    }).toList();
  }

  List<HiveAction> getMyActions() {
    // final actionIdsAssignedToMyGroups = <String>{};
    // for (final group in _hiveApi.group.values) {
    //   group.actions?.forEach((groupAction) {
    //     final actionId = groupAction.actionId;
    //     if (actionId != null) {
    //       actionIdsAssignedToMyGroups.add(actionId);
    //     }
    //   });
    // }
    final myGroups = _hiveApi.group.values.map((group) => group.id).toSet();
    return _hiveApi.action.values.where((action) {
      return action.isIndividualAction || myGroups.contains(action.id);
    }).toList();
  }

  // List<HiveAction> get

  RelatedMaterials getMaterialsRelatedToMe() {
    final materialsAssignedToMe = <String, ActionStatus>{};
    final materialsAssignedToGroupWithLeaderRole = <String>{};
    for (final action in getMyActions()) {
      final materialId = action.materialId;
      if (materialId.isNotEmpty) {
        if (action.isIndividualAction) {
          materialsAssignedToMe[materialId] = action.actionStatus;
        } else {
          materialsAssignedToGroupWithLeaderRole.add(materialId);
        }
      }
    }
    return RelatedMaterials(
        materialsAssignedToMe, materialsAssignedToGroupWithLeaderRole);
  }

  // bool isMaterialAssignedToMe(HiveMaterial material) =>
  //   getAllActiveActions().any(
  //     (action) => action.isIndividualAction && action.materialId == material.id,
  //   );

  // bool isMaterialAssignedToGroupWithLeaderRole(HiveMaterial material) =>
  //   getAllActiveActions().any(
  //     (action) => !action.isIndividualAction &&
  //         (action)
  //   );

  // ------------------- Actions -------------------

  Stream<List<HiveAction>> getActionsByGroup(HiveGroup group) {
    throw UnimplementedError();
  }

  // ------------------- Countries -------------------

  Stream<List<HiveCountry>> get countries => _streamBox(_hiveApi.country);
  List<HiveCountry> get currentCountries => _hiveApi.country.asList();

  // ------------------- Languages -------------------

  Stream<List<HiveLanguage>> get languages => _streamBox(_hiveApi.language);
  List<HiveLanguage> get currentLanguages => _hiveApi.language.asList();

  void addUserLanguages(Set<String> languageIds) {
    throw UnimplementedError();
  }

  void updateUserLanguages(List<String> languageIds) {
    throw UnimplementedError();
  }
}

class RelatedMaterials {
  RelatedMaterials(
      this.materialsAssignedToMe, this.materialsAssignedToGroupWithLeaderRole);

  final Map<String, ActionStatus> materialsAssignedToMe;
  final Set<String> materialsAssignedToGroupWithLeaderRole;
}
