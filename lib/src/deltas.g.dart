/// GENERATED CODE - DO NOT MODIFY BY HAND
///
/// This file contains delta models. The trickiest part of deltas is making sure they apply
/// correctly, in the correct order. In general, the algorithm is as follows:
///
/// 1. Check to see if this delta actually "applies". For example, an update or delete delta
/// can only apply if the record already exists.
/// 2. Assuming the delta actually *does* apply, go ahead and apply it to the local data.
/// 3. Then, make sure that there is sufficient information to roll back to the version
/// as it stood after the last sync.
/// 4. Finally, save the request associated with this delta to be sent to the server later,
/// merging it with any pre-existing requests if they exist.
///
/// This gets even more complicated if the delta is applied while the sync is taking place.
/// In this case, we have to update the local information immediately for the sake of the
/// UI, but the final state of the data depends on whether the sync will eventually succeed
/// or fail.
///
/// So we apply 1-3 above as is, but we have to modify number 4. If a sync is currently in
/// progress, we don't save the request to the sync box. We store the merged request in a
/// backup sync box, as well as saving the delta to possibly reapply later. Then, we branch
/// on success/failure of the current sync.
///
/// If the current sync *fails*, we have to pretend that the deltas applied mid-sync were
/// applied to the data as normal. That means we take the backup sync items and write them
/// back to the sync box. The data is then in a consistent state.
///
/// If the current sync *succeeds*, then we have to pretend that the deltas weren't applied
/// until after the sync was finished. In that case, the data would have been rolled back
/// to its previous state in preparation for the server changes, and we simply have to reapply
/// the mid-sync deltas once again.

part of 'deltas.dart';

void saveCountryLocally(Country model) {
  globalHiveApi.country.put(model.id, model);
}

void removeCountryLocally(String id) {
  globalHiveApi.country.delete(id);
}

// Users cannot create the Country type

// Users cannot update the Country type

// Users cannot delete the Country type

void saveLanguageLocally(Language model) {
  globalHiveApi.language.put(model.id, model);
}

void removeLanguageLocally(String id) {
  globalHiveApi.language.delete(id);
}

// Users cannot create the Language type

// Users cannot update the Language type

// Users cannot delete the Language type

void saveGroupUserLocally(GroupUser model) {
  globalHiveApi.group.applyUpdate(model.groupId, (other) {
    other.users.add(model);
  });
  globalHiveApi.user.applyUpdate(model.userId, (other) {
    other.groups.add(model);
  });
}

class GroupUserCreateDelta extends DeltaBase {
  GroupUserCreateDelta({
    this.id,
    this.groupId,
    this.userId,
    this.role,
    this.profile,
  });

  final String? id;
  final String? groupId;
  final String? userId;
  final GroupUser_Role? role;
  final String? profile;

  @override
  bool apply() {
    final model = GroupUser(
      id: id ?? UuidGenerator.uuid(),
      groupId: groupId,
      userId: userId,
      role: role,
      profile: profile,
    )..freeze();
    bool createApplies = false;
    final groupModelContainer = globalHiveApi.group.get(model.groupId);
    if (groupModelContainer != null) {
      createApplies = true;
      globalHiveApi.group.put(
        groupModelContainer.id,
        groupModelContainer.rebuild((other) {
          other.users.add(model);
        }),
      );
      ensureRevert(12, groupModelContainer.id, groupModelContainer);
    }
    final userModelContainer = globalHiveApi.user.get(model.userId);
    if (userModelContainer != null) {
      createApplies = true;
      globalHiveApi.user.put(
        userModelContainer.id,
        userModelContainer.rebuild((other) {
          other.groups.add(model);
        }),
      );
      ensureRevert(16, userModelContainer.id, userModelContainer);
    }
    if (!createApplies) {
      return false;
    }
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateGroupUsersRequest(groupUser: model));
    return true;
  }
}

class GroupUserUpdateDelta extends DeltaBase {
  GroupUserUpdateDelta(
    this._model, {
    GroupUser_Role? role,
    String? profile,
  }) {
    final updateMask = <String>{};
    if (role != null && role != _model.role) {
      this.role = role;
      updateMask.add('role');
    } else {
      this.role = null;
    }
    if (profile != null && profile != _model.profile) {
      this.profile = profile;
      updateMask.add('profile');
    } else {
      this.profile = null;
    }
    _updateMask = updateMask;
  }

  final GroupUser _model;
  late final Set<String> _updateMask;
  late final GroupUser_Role? role;
  late final String? profile;

  GroupUser applyUpdateToModel(GroupUser originalModel) {
    return originalModel.rebuild((other) {
      if (role != null) {
        other.role = role!;
      }

      if (profile != null) {
        other.profile = profile!;
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final id = _model.id;
    GroupUser? tempUpdatedModel;
    final groupModelContainer = globalHiveApi.group.get(_model.groupId);
    if (groupModelContainer != null) {
      final groupIndex =
          groupModelContainer.users.indexWhere((item) => item.id == id);
      if (groupIndex >= 0) {
        tempUpdatedModel ??=
            applyUpdateToModel(groupModelContainer.users[groupIndex]);
        globalHiveApi.group.put(
          groupModelContainer.id,
          groupModelContainer.rebuild((other) {
            other.users[groupIndex] = tempUpdatedModel!;
          }),
        );
        ensureRevert(12, groupModelContainer.id, groupModelContainer);
      }
    }
    final userModelContainer = globalHiveApi.user.get(_model.userId);
    if (userModelContainer != null) {
      final userIndex =
          userModelContainer.groups.indexWhere((item) => item.id == id);
      if (userIndex >= 0) {
        tempUpdatedModel ??=
            applyUpdateToModel(userModelContainer.groups[userIndex]);
        globalHiveApi.user.put(
          userModelContainer.id,
          userModelContainer.rebuild((other) {
            other.groups[userIndex] = tempUpdatedModel!;
          }),
        );
        ensureRevert(16, userModelContainer.id, userModelContainer);
      }
    }
    if (tempUpdatedModel == null) {
      // No changes were applied.
      return false;
    }
    final updatedModel = tempUpdatedModel;
    Set<String>? updateMask = _updateMask;
    final CreateUpdateGroupUsersRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateGroupUsersRequest(
            groupUser: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

class GroupUserDeleteDelta extends DeltaBase {
  GroupUserDeleteDelta(this._model);

  final GroupUser _model;

  @override
  bool apply() {
    final id = _model.id;
    final matches = (GroupUser item) => item.id == id;
    bool deleteApplies = false;
    final groupModelContainer = globalHiveApi.group.get(_model.groupId);
    if (groupModelContainer != null) {
      if (groupModelContainer.users.any(matches)) {
        deleteApplies = true;
        globalHiveApi.group.put(
          groupModelContainer.id,
          groupModelContainer.rebuild((other) {
            other.users.removeWhere(matches);
          }),
        );
        ensureRevert(12, groupModelContainer.id, groupModelContainer);
      }
    }
    final userModelContainer = globalHiveApi.user.get(_model.userId);
    if (userModelContainer != null) {
      if (userModelContainer.groups.any(matches)) {
        deleteApplies = true;
        globalHiveApi.user.put(
          userModelContainer.id,
          userModelContainer.rebuild((other) {
            other.groups.removeWhere(matches);
          }),
        );
        ensureRevert(16, userModelContainer.id, userModelContainer);
      }
    }
    if (!deleteApplies) {
      return false;
    }
    final CreateUpdateGroupUsersRequest? request =
        globalHiveApi.getSyncRequest(_model.id);
    if (request != null && !request.hasUpdateMask()) {
      // This delete follows a create. Reverts to nothing.
      globalHiveApi.deleteSyncRequest(_model.id);
    } else {
      globalHiveApi.putSyncRequest(
          _model.id, DeleteGroupUserRequest(groupUserId: _model.id));
    }
    return true;
  }
}

void saveActionLocally(Action model) {
  globalHiveApi.action.put(model.id, model);
}

void removeActionLocally(String id) {
  globalHiveApi.action.delete(id);
}

class ActionCreateDelta extends DeltaBase {
  ActionCreateDelta({
    this.id,
    this.type,
    this.name,
    this.groupId,
    this.instructions,
    this.materialId,
    this.question,
    this.dateDue,
  });

  final String? id;
  final Action_Type? type;
  final String? name;
  final String? groupId;
  final String? instructions;
  final String? materialId;
  final String? question;
  final Date? dateDue;

  @override
  bool apply() {
    final model = Action(
      id: id ?? UuidGenerator.uuid(),
      type: type,
      name: name,
      groupId: groupId,
      instructions: instructions,
      materialId: materialId,
      question: question,
      dateDue: dateDue,
    )..freeze();
    globalHiveApi.action.put(model.id, model);
    ensureRevert(4, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateActionsRequest(action: model));
    return true;
  }
}

class ActionUpdateDelta extends DeltaBase {
  ActionUpdateDelta(
    this._model, {
    Action_Type? type,
    String? name,
    String? groupId,
    String? instructions,
    String? materialId,
    String? question,
    Date? dateDue,
  }) {
    final updateMask = <String>{};
    if (type != null && type != _model.type) {
      this.type = type;
      updateMask.add('type');
    } else {
      this.type = null;
    }
    if (name != null && name != _model.name) {
      this.name = name;
      updateMask.add('name');
    } else {
      this.name = null;
    }
    if (groupId != null && groupId != _model.groupId) {
      this.groupId = groupId;
      updateMask.add('group_id');
    } else {
      this.groupId = null;
    }
    if (instructions != null && instructions != _model.instructions) {
      this.instructions = instructions;
      updateMask.add('instructions');
    } else {
      this.instructions = null;
    }
    if (materialId != null && materialId != _model.materialId) {
      this.materialId = materialId;
      updateMask.add('material_id');
    } else {
      this.materialId = null;
    }
    if (question != null && question != _model.question) {
      this.question = question;
      updateMask.add('question');
    } else {
      this.question = null;
    }
    if (dateDue != null && dateDue != _model.dateDue) {
      this.dateDue = dateDue;
      updateMask.add('date_due');
    } else {
      this.dateDue = null;
    }
    _updateMask = updateMask;
  }

  final Action _model;
  late final Set<String> _updateMask;
  late final Action_Type? type;
  late final String? name;
  late final String? groupId;
  late final String? instructions;
  late final String? materialId;
  late final String? question;
  late final Date? dateDue;

  Action applyUpdateToModel(Action originalModel) {
    return originalModel.rebuild((other) {
      if (type != null) {
        other.type = type!;
      }

      if (name != null) {
        other.name = name!;
      }

      if (groupId != null) {
        other.groupId = groupId!;
      }

      if (instructions != null) {
        other.instructions = instructions!;
      }

      if (materialId != null) {
        other.materialId = materialId!;
      }

      if (question != null) {
        other.question = question!;
      }

      if (dateDue != null) {
        other.dateDue = dateDue!;
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final originalModel = globalHiveApi.action.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.action.put(updatedModel.id, updatedModel);
    ensureRevert(4, originalModel.id, originalModel);
    Set<String>? updateMask = _updateMask;
    final CreateUpdateActionsRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateActionsRequest(
            action: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

class ActionDeleteDelta extends DeltaBase {
  ActionDeleteDelta(this._model);

  final Action _model;

  @override
  bool apply() {
    if (!globalHiveApi.action.containsKey(_model.id)) {
      return false;
    }
    globalHiveApi.action.delete(_model.id);
    ensureRevert(4, _model.id, _model);
    final CreateUpdateActionsRequest? request =
        globalHiveApi.getSyncRequest(_model.id);
    if (request != null && !request.hasUpdateMask()) {
      // This delete follows a create. Reverts to nothing.
      globalHiveApi.deleteSyncRequest(_model.id);
    } else {
      globalHiveApi.putSyncRequest(
          _model.id, DeleteActionRequest(actionId: _model.id));
    }
    return true;
  }
}

void saveMaterialLocally(Material model) {
  globalHiveApi.material.put(model.id, model);
}

void removeMaterialLocally(String id) {
  globalHiveApi.material.delete(id);
}

class MaterialCreateDelta extends DeltaBase {
  MaterialCreateDelta({
    this.id,
    this.status,
    this.visibility,
    this.editability,
    this.title,
    this.description,
    this.targetAudience,
    this.url,
    this.files,
    this.languageIds,
    this.typeIds,
    this.topics,
  });

  final String? id;
  final Material_Status? status;
  final Material_Visibility? visibility;
  final Material_Editability? editability;
  final String? title;
  final String? description;
  final String? targetAudience;
  final String? url;
  final List<String>? files;
  final List<String>? languageIds;
  final List<String>? typeIds;
  final List<String>? topics;

  @override
  bool apply() {
    final model = Material(
      id: id ?? UuidGenerator.uuid(),
      status: status,
      visibility: visibility,
      editability: editability,
      title: title,
      description: description,
      targetAudience: targetAudience,
      url: url,
      files: files,
      languageIds: languageIds,
      typeIds: typeIds,
      topics: topics,
    )..freeze();
    globalHiveApi.material.put(model.id, model);
    ensureRevert(5, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateMaterialsRequest(material: model));
    return true;
  }
}

class MaterialUpdateDelta extends DeltaBase {
  MaterialUpdateDelta(
    this._model, {
    Material_Visibility? visibility,
    Material_Editability? editability,
    String? title,
    String? description,
    String? url,
    List<String>? files,
    List<String>? languageIds,
    List<String>? typeIds,
    List<String>? topics,
  }) {
    final updateMask = <String>{};
    if (visibility != null && visibility != _model.visibility) {
      this.visibility = visibility;
      updateMask.add('visibility');
    } else {
      this.visibility = null;
    }
    if (editability != null && editability != _model.editability) {
      this.editability = editability;
      updateMask.add('editability');
    } else {
      this.editability = null;
    }
    if (title != null && title != _model.title) {
      this.title = title;
      updateMask.add('title');
    } else {
      this.title = null;
    }
    if (description != null && description != _model.description) {
      this.description = description;
      updateMask.add('description');
    } else {
      this.description = null;
    }
    if (url != null && url != _model.url) {
      this.url = url;
      updateMask.add('url');
    } else {
      this.url = null;
    }
    if (files != null && !listsAreSame(files, _model.files)) {
      this.files = files;
      updateMask.add('files');
    } else {
      this.files = null;
    }
    if (languageIds != null && !listsAreSame(languageIds, _model.languageIds)) {
      this.languageIds = languageIds;
      updateMask.add('language_ids');
    } else {
      this.languageIds = null;
    }
    if (typeIds != null && !listsAreSame(typeIds, _model.typeIds)) {
      this.typeIds = typeIds;
      updateMask.add('type_ids');
    } else {
      this.typeIds = null;
    }
    if (topics != null && !listsAreSame(topics, _model.topics)) {
      this.topics = topics;
      updateMask.add('topics');
    } else {
      this.topics = null;
    }
    _updateMask = updateMask;
  }

  final Material _model;
  late final Set<String> _updateMask;
  late final Material_Visibility? visibility;
  late final Material_Editability? editability;
  late final String? title;
  late final String? description;
  late final String? url;
  late final List<String>? files;
  late final List<String>? languageIds;
  late final List<String>? typeIds;
  late final List<String>? topics;

  Material applyUpdateToModel(Material originalModel) {
    return originalModel.rebuild((other) {
      if (visibility != null) {
        other.visibility = visibility!;
      }

      if (editability != null) {
        other.editability = editability!;
      }

      if (title != null) {
        other.title = title!;
      }

      if (description != null) {
        other.description = description!;
      }

      if (url != null) {
        other.url = url!;
      }

      if (files != null) {
        other.files
          ..clear()
          ..addAll(files!);
      }

      if (languageIds != null) {
        other.languageIds
          ..clear()
          ..addAll(languageIds!);
      }

      if (typeIds != null) {
        other.typeIds
          ..clear()
          ..addAll(typeIds!);
      }

      if (topics != null) {
        other.topics
          ..clear()
          ..addAll(topics!);
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final originalModel = globalHiveApi.material.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.material.put(updatedModel.id, updatedModel);
    ensureRevert(5, originalModel.id, originalModel);
    Set<String>? updateMask = _updateMask;
    final CreateUpdateMaterialsRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateMaterialsRequest(
            material: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

class MaterialDeleteDelta extends DeltaBase {
  MaterialDeleteDelta(this._model);

  final Material _model;

  @override
  bool apply() {
    if (!globalHiveApi.material.containsKey(_model.id)) {
      return false;
    }
    globalHiveApi.material.delete(_model.id);
    ensureRevert(5, _model.id, _model);
    final CreateUpdateMaterialsRequest? request =
        globalHiveApi.getSyncRequest(_model.id);
    if (request != null && !request.hasUpdateMask()) {
      // This delete follows a create. Reverts to nothing.
      globalHiveApi.deleteSyncRequest(_model.id);
    } else {
      globalHiveApi.putSyncRequest(
          _model.id, DeleteMaterialRequest(materialId: _model.id));
    }
    return true;
  }
}

void saveMaterialFeedbackLocally(MaterialFeedback model) {
  globalHiveApi.material.applyUpdate(model.materialId, (other) {
    other.feedbacks.add(model);
  });
}

class MaterialFeedbackCreateDelta extends DeltaBase {
  MaterialFeedbackCreateDelta({
    this.id,
    this.type,
    this.reporterId,
    this.report,
    this.response,
    this.materialId,
  });

  final String? id;
  final MaterialFeedback_Type? type;
  final String? reporterId;
  final String? report;
  final String? response;
  final String? materialId;

  @override
  bool apply() {
    final model = MaterialFeedback(
      id: id ?? UuidGenerator.uuid(),
      type: type,
      reporterId: reporterId,
      report: report,
      response: response,
      materialId: materialId,
    )..freeze();
    bool createApplies = false;
    final materialModelContainer = globalHiveApi.material.get(model.materialId);
    if (materialModelContainer != null) {
      createApplies = true;
      globalHiveApi.material.put(
        materialModelContainer.id,
        materialModelContainer.rebuild((other) {
          other.feedbacks.add(model);
        }),
      );
      ensureRevert(5, materialModelContainer.id, materialModelContainer);
    }
    if (!createApplies) {
      return false;
    }
    globalHiveApi.putSyncRequest(
        model.id, CreateMaterialFeedbacksRequest(feedback: model));
    return true;
  }
}

// Users cannot update the MaterialFeedback type

// Users cannot delete the MaterialFeedback type

void saveMaterialTopicLocally(MaterialTopic model) {
  globalHiveApi.materialTopic.put(model.id, model);
}

void removeMaterialTopicLocally(String id) {
  globalHiveApi.materialTopic.delete(id);
}

// Users cannot create the MaterialTopic type

// Users cannot update the MaterialTopic type

// Users cannot delete the MaterialTopic type

void saveMaterialTypeLocally(MaterialType model) {
  globalHiveApi.materialType.put(model.id, model);
}

void removeMaterialTypeLocally(String id) {
  globalHiveApi.materialType.delete(id);
}

// Users cannot create the MaterialType type

// Users cannot update the MaterialType type

// Users cannot delete the MaterialType type

void saveGroupLocally(Group model) {
  globalHiveApi.group.put(model.id, model);
}

void removeGroupLocally(String id) {
  globalHiveApi.group.delete(id);
}

class GroupCreateDelta extends DeltaBase {
  GroupCreateDelta({
    this.id,
    this.name,
    this.languageIds,
    this.users,
    this.evaluationCategoryIds,
    this.description,
    this.linkEmail,
    this.status,
    this.outputMarkers,
  });

  final String? id;
  final String? name;
  final List<String>? languageIds;
  final List<GroupUser>? users;
  final List<String>? evaluationCategoryIds;
  final String? description;
  final String? linkEmail;
  final Group_Status? status;
  final List<OutputMarker>? outputMarkers;

  @override
  bool apply() {
    final model = Group(
      id: id ?? UuidGenerator.uuid(),
      name: name,
      languageIds: languageIds,
      users: users,
      evaluationCategoryIds: evaluationCategoryIds,
      description: description,
      linkEmail: linkEmail,
      status: status,
      outputMarkers: outputMarkers,
    )..freeze();
    globalHiveApi.group.put(model.id, model);
    ensureRevert(12, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateGroupsRequest(group: model));
    return true;
  }
}

class GroupUpdateDelta extends DeltaBase {
  GroupUpdateDelta(
    this._model, {
    String? name,
    List<String>? languageIds,
    List<String>? evaluationCategoryIds,
    String? description,
    String? linkEmail,
    Group_Status? status,
  }) {
    final updateMask = <String>{};
    if (name != null && name != _model.name) {
      this.name = name;
      updateMask.add('name');
    } else {
      this.name = null;
    }
    if (languageIds != null && !listsAreSame(languageIds, _model.languageIds)) {
      this.languageIds = languageIds;
      updateMask.add('language_ids');
    } else {
      this.languageIds = null;
    }
    if (evaluationCategoryIds != null &&
        !listsAreSame(evaluationCategoryIds, _model.evaluationCategoryIds)) {
      this.evaluationCategoryIds = evaluationCategoryIds;
      updateMask.add('evaluation_category_ids');
    } else {
      this.evaluationCategoryIds = null;
    }
    if (description != null && description != _model.description) {
      this.description = description;
      updateMask.add('description');
    } else {
      this.description = null;
    }
    if (linkEmail != null && linkEmail != _model.linkEmail) {
      this.linkEmail = linkEmail;
      updateMask.add('link_email');
    } else {
      this.linkEmail = null;
    }
    if (status != null && status != _model.status) {
      this.status = status;
      updateMask.add('status');
    } else {
      this.status = null;
    }
    _updateMask = updateMask;
  }

  final Group _model;
  late final Set<String> _updateMask;
  late final String? name;
  late final List<String>? languageIds;
  late final List<String>? evaluationCategoryIds;
  late final String? description;
  late final String? linkEmail;
  late final Group_Status? status;

  Group applyUpdateToModel(Group originalModel) {
    return originalModel.rebuild((other) {
      if (name != null) {
        other.name = name!;
      }

      if (languageIds != null) {
        other.languageIds
          ..clear()
          ..addAll(languageIds!);
      }

      if (evaluationCategoryIds != null) {
        other.evaluationCategoryIds
          ..clear()
          ..addAll(evaluationCategoryIds!);
      }

      if (description != null) {
        other.description = description!;
      }

      if (linkEmail != null) {
        other.linkEmail = linkEmail!;
      }

      if (status != null) {
        other.status = status!;
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final originalModel = globalHiveApi.group.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.group.put(updatedModel.id, updatedModel);
    ensureRevert(12, originalModel.id, originalModel);
    Set<String>? updateMask = _updateMask;
    final CreateUpdateGroupsRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateGroupsRequest(
            group: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

// Users cannot delete the Group type

void saveEvaluationCategoryLocally(EvaluationCategory model) {
  globalHiveApi.evaluationCategory.put(model.id, model);
}

void removeEvaluationCategoryLocally(String id) {
  globalHiveApi.evaluationCategory.delete(id);
}

// Users cannot create the EvaluationCategory type

// Users cannot update the EvaluationCategory type

// Users cannot delete the EvaluationCategory type

void saveActionUserLocally(ActionUser model) {
  globalHiveApi.user.applyUpdate(model.userId, (other) {
    other.actions.add(model);
  });
}

class ActionUserCreateDelta extends DeltaBase {
  ActionUserCreateDelta({
    this.id,
    this.actionId,
    this.userId,
    this.status,
    this.teacherResponse,
    this.userResponse,
    this.evaluation,
  });

  final String? id;
  final String? actionId;
  final String? userId;
  final ActionUser_Status? status;
  final String? teacherResponse;
  final String? userResponse;
  final ActionUser_Evaluation? evaluation;

  @override
  bool apply() {
    final model = ActionUser(
      id: id ?? UuidGenerator.uuid(),
      actionId: actionId,
      userId: userId,
      status: status,
      teacherResponse: teacherResponse,
      userResponse: userResponse,
      evaluation: evaluation,
    )..freeze();
    bool createApplies = false;
    final userModelContainer = globalHiveApi.user.get(model.userId);
    if (userModelContainer != null) {
      createApplies = true;
      globalHiveApi.user.put(
        userModelContainer.id,
        userModelContainer.rebuild((other) {
          other.actions.add(model);
        }),
      );
      ensureRevert(16, userModelContainer.id, userModelContainer);
    }
    if (!createApplies) {
      return false;
    }
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateActionUserRequest(actionUser: model));
    return true;
  }
}

class ActionUserUpdateDelta extends DeltaBase {
  ActionUserUpdateDelta(
    this._model, {
    ActionUser_Status? status,
    String? teacherResponse,
    String? userResponse,
    ActionUser_Evaluation? evaluation,
  }) {
    final updateMask = <String>{};
    if (status != null && status != _model.status) {
      this.status = status;
      updateMask.add('status');
    } else {
      this.status = null;
    }
    if (teacherResponse != null && teacherResponse != _model.teacherResponse) {
      this.teacherResponse = teacherResponse;
      updateMask.add('teacher_response');
    } else {
      this.teacherResponse = null;
    }
    if (userResponse != null && userResponse != _model.userResponse) {
      this.userResponse = userResponse;
      updateMask.add('user_response');
    } else {
      this.userResponse = null;
    }
    if (evaluation != null && evaluation != _model.evaluation) {
      this.evaluation = evaluation;
      updateMask.add('evaluation');
    } else {
      this.evaluation = null;
    }
    _updateMask = updateMask;
  }

  final ActionUser _model;
  late final Set<String> _updateMask;
  late final ActionUser_Status? status;
  late final String? teacherResponse;
  late final String? userResponse;
  late final ActionUser_Evaluation? evaluation;

  ActionUser applyUpdateToModel(ActionUser originalModel) {
    return originalModel.rebuild((other) {
      if (status != null) {
        other.status = status!;
      }

      if (teacherResponse != null) {
        other.teacherResponse = teacherResponse!;
      }

      if (userResponse != null) {
        other.userResponse = userResponse!;
      }

      if (evaluation != null) {
        other.evaluation = evaluation!;
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final id = _model.id;
    ActionUser? tempUpdatedModel;
    final userModelContainer = globalHiveApi.user.get(_model.userId);
    if (userModelContainer != null) {
      final userIndex =
          userModelContainer.actions.indexWhere((item) => item.id == id);
      if (userIndex >= 0) {
        tempUpdatedModel ??=
            applyUpdateToModel(userModelContainer.actions[userIndex]);
        globalHiveApi.user.put(
          userModelContainer.id,
          userModelContainer.rebuild((other) {
            other.actions[userIndex] = tempUpdatedModel!;
          }),
        );
        ensureRevert(16, userModelContainer.id, userModelContainer);
      }
    }
    if (tempUpdatedModel == null) {
      // No changes were applied.
      return false;
    }
    final updatedModel = tempUpdatedModel;
    Set<String>? updateMask = _updateMask;
    final CreateUpdateActionUserRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateActionUserRequest(
            actionUser: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

// Users cannot delete the ActionUser type

void saveUserLocally(User model) {
  globalHiveApi.user.put(model.id, model);
}

void removeUserLocally(String id) {
  globalHiveApi.user.delete(id);
}

class UserCreateDelta extends DeltaBase {
  UserCreateDelta({
    this.id,
    this.name,
    this.phone,
    this.countryIds,
    this.languageIds,
    this.linkGroups,
    this.groups,
    this.actions,
    this.selectedActionsTab,
    this.selectedResultsTab,
    this.phoneCountryId,
    this.diallingCode,
    this.status,
  });

  final String? id;
  final String? name;
  final String? phone;
  final List<String>? countryIds;
  final List<String>? languageIds;
  final bool? linkGroups;
  final List<GroupUser>? groups;
  final List<ActionUser>? actions;
  final ActionTab? selectedActionsTab;
  final ResultsTab? selectedResultsTab;
  final String? phoneCountryId;
  final String? diallingCode;
  final User_Status? status;

  @override
  bool apply() {
    final model = User(
      id: id ?? UuidGenerator.uuid(),
      name: name,
      phone: phone,
      countryIds: countryIds,
      languageIds: languageIds,
      linkGroups: linkGroups,
      groups: groups,
      actions: actions,
      selectedActionsTab: selectedActionsTab,
      selectedResultsTab: selectedResultsTab,
      phoneCountryId: phoneCountryId,
      diallingCode: diallingCode,
      status: status,
    )..freeze();
    globalHiveApi.user.put(model.id, model);
    ensureRevert(16, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateUserRequest(user: model));
    return true;
  }
}

class UserUpdateDelta extends DeltaBase {
  UserUpdateDelta(
    this._model, {
    String? name,
    String? phone,
    String? phoneCountryId,
    String? diallingCode,
  }) {
    final updateMask = <String>{};
    if (name != null && name != _model.name) {
      this.name = name;
      updateMask.add('name');
    } else {
      this.name = null;
    }
    if (phone != null && phone != _model.phone) {
      this.phone = phone;
      updateMask.add('phone');
    } else {
      this.phone = null;
    }
    if (phoneCountryId != null && phoneCountryId != _model.phoneCountryId) {
      this.phoneCountryId = phoneCountryId;
      updateMask.add('phone_country_id');
    } else {
      this.phoneCountryId = null;
    }
    if (diallingCode != null && diallingCode != _model.diallingCode) {
      this.diallingCode = diallingCode;
      updateMask.add('dialling_code');
    } else {
      this.diallingCode = null;
    }
    _updateMask = updateMask;
  }

  final User _model;
  late final Set<String> _updateMask;
  late final String? name;
  late final String? phone;
  late final String? phoneCountryId;
  late final String? diallingCode;

  User applyUpdateToModel(User originalModel) {
    return originalModel.rebuild((other) {
      if (name != null) {
        other.name = name!;
      }

      if (phone != null) {
        other.phone = phone!;
      }

      if (phoneCountryId != null) {
        other.phoneCountryId = phoneCountryId!;
      }

      if (diallingCode != null) {
        other.diallingCode = diallingCode!;
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final originalModel = globalHiveApi.user.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.user.put(updatedModel.id, updatedModel);
    ensureRevert(16, originalModel.id, originalModel);
    Set<String>? updateMask = _updateMask;
    final CreateUpdateUserRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateUserRequest(
            user: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

// Users cannot delete the User type

void saveLearnerEvaluationLocally(LearnerEvaluation model) {
  globalHiveApi.learnerEvaluation.put(model.id, model);
}

void removeLearnerEvaluationLocally(String id) {
  globalHiveApi.learnerEvaluation.delete(id);
}

class LearnerEvaluationCreateDelta extends DeltaBase {
  LearnerEvaluationCreateDelta({
    this.id,
    this.learnerId,
    this.evaluatorId,
    this.groupId,
    this.month,
    this.categoryId,
    this.evaluation,
  });

  final String? id;
  final String? learnerId;
  final String? evaluatorId;
  final String? groupId;
  final Date? month;
  final String? categoryId;
  final int? evaluation;

  @override
  bool apply() {
    final model = LearnerEvaluation(
      id: id ?? UuidGenerator.uuid(),
      learnerId: learnerId,
      evaluatorId: evaluatorId,
      groupId: groupId,
      month: month,
      categoryId: categoryId,
      evaluation: evaluation,
    )..freeze();
    globalHiveApi.learnerEvaluation.put(model.id, model);
    ensureRevert(18, model.id, null);
    globalHiveApi.putSyncRequest(model.id,
        CreateUpdateLearnerEvaluationRequest(learnerEvaluation: model));
    return true;
  }
}

// Users cannot update the LearnerEvaluation type

// Users cannot delete the LearnerEvaluation type

void saveTeacherResponseLocally(TeacherResponse model) {
  globalHiveApi.teacherResponse.put(model.id, model);
}

void removeTeacherResponseLocally(String id) {
  globalHiveApi.teacherResponse.delete(id);
}

class TeacherResponseCreateDelta extends DeltaBase {
  TeacherResponseCreateDelta({
    this.id,
    this.learnerId,
    this.teacherId,
    this.groupId,
    this.month,
    this.response,
  });

  final String? id;
  final String? learnerId;
  final String? teacherId;
  final String? groupId;
  final Date? month;
  final String? response;

  @override
  bool apply() {
    final model = TeacherResponse(
      id: id ?? UuidGenerator.uuid(),
      learnerId: learnerId,
      teacherId: teacherId,
      groupId: groupId,
      month: month,
      response: response,
    )..freeze();
    globalHiveApi.teacherResponse.put(model.id, model);
    ensureRevert(19, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateTeacherResponseRequest(teacherResponse: model));
    return true;
  }
}

class TeacherResponseUpdateDelta extends DeltaBase {
  TeacherResponseUpdateDelta(
    this._model, {
    String? response,
  }) {
    var numUpdatedFields = 0;
    if (response != null && response != _model.response) {
      this.response = response;
      numUpdatedFields += 1;
    } else {
      this.response = null;
    }
    _hasChangedFields = numUpdatedFields > 0;
  }

  final TeacherResponse _model;
  late final bool _hasChangedFields;
  late final String? response;

  TeacherResponse applyUpdateToModel(TeacherResponse originalModel) {
    return originalModel.rebuild((other) {
      if (response != null) {
        other.response = response!;
      }
    });
  }

  @override
  bool apply() {
    if (!_hasChangedFields) {
      return false;
    }

    final originalModel = globalHiveApi.teacherResponse.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.teacherResponse.put(updatedModel.id, updatedModel);
    ensureRevert(19, originalModel.id, originalModel);

    globalHiveApi.putSyncRequest(updatedModel.id,
        CreateUpdateTeacherResponseRequest(teacherResponse: updatedModel));
    return true;
  }
}

// Users cannot delete the TeacherResponse type

void saveGroupEvaluationLocally(GroupEvaluation model) {
  globalHiveApi.groupEvaluation.put(model.id, model);
}

void removeGroupEvaluationLocally(String id) {
  globalHiveApi.groupEvaluation.delete(id);
}

class GroupEvaluationCreateDelta extends DeltaBase {
  GroupEvaluationCreateDelta({
    this.id,
    this.userId,
    this.groupId,
    this.month,
    this.evaluation,
  });

  final String? id;
  final String? userId;
  final String? groupId;
  final Date? month;
  final GroupEvaluation_Evaluation? evaluation;

  @override
  bool apply() {
    final model = GroupEvaluation(
      id: id ?? UuidGenerator.uuid(),
      userId: userId,
      groupId: groupId,
      month: month,
      evaluation: evaluation,
    )..freeze();
    globalHiveApi.groupEvaluation.put(model.id, model);
    ensureRevert(20, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateGroupEvaluationRequest(groupEvaluation: model));
    return true;
  }
}

class GroupEvaluationUpdateDelta extends DeltaBase {
  GroupEvaluationUpdateDelta(
    this._model, {
    GroupEvaluation_Evaluation? evaluation,
  }) {
    var numUpdatedFields = 0;
    if (evaluation != null && evaluation != _model.evaluation) {
      this.evaluation = evaluation;
      numUpdatedFields += 1;
    } else {
      this.evaluation = null;
    }
    _hasChangedFields = numUpdatedFields > 0;
  }

  final GroupEvaluation _model;
  late final bool _hasChangedFields;
  late final GroupEvaluation_Evaluation? evaluation;

  GroupEvaluation applyUpdateToModel(GroupEvaluation originalModel) {
    return originalModel.rebuild((other) {
      if (evaluation != null) {
        other.evaluation = evaluation!;
      }
    });
  }

  @override
  bool apply() {
    if (!_hasChangedFields) {
      return false;
    }

    final originalModel = globalHiveApi.groupEvaluation.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.groupEvaluation.put(updatedModel.id, updatedModel);
    ensureRevert(20, originalModel.id, originalModel);

    globalHiveApi.putSyncRequest(updatedModel.id,
        CreateUpdateGroupEvaluationRequest(groupEvaluation: updatedModel));
    return true;
  }
}

// Users cannot delete the GroupEvaluation type

void saveTransformationLocally(Transformation model) {
  globalHiveApi.transformation.put(model.id, model);
}

void removeTransformationLocally(String id) {
  globalHiveApi.transformation.delete(id);
}

class TransformationCreateDelta extends DeltaBase {
  TransformationCreateDelta({
    this.id,
    this.userId,
    this.groupId,
    this.month,
    this.impactStory,
    this.files,
  });

  final String? id;
  final String? userId;
  final String? groupId;
  final Date? month;
  final String? impactStory;
  final List<String>? files;

  @override
  bool apply() {
    final model = Transformation(
      id: id ?? UuidGenerator.uuid(),
      userId: userId,
      groupId: groupId,
      month: month,
      impactStory: impactStory,
      files: files,
    )..freeze();
    globalHiveApi.transformation.put(model.id, model);
    ensureRevert(21, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateTransformationRequest(transformation: model));
    return true;
  }
}

class TransformationUpdateDelta extends DeltaBase {
  TransformationUpdateDelta(
    this._model, {
    String? impactStory,
  }) {
    final updateMask = <String>{};
    if (impactStory != null && impactStory != _model.impactStory) {
      this.impactStory = impactStory;
      updateMask.add('impact_story');
    } else {
      this.impactStory = null;
    }
    _updateMask = updateMask;
  }

  final Transformation _model;
  late final Set<String> _updateMask;
  late final String? impactStory;

  Transformation applyUpdateToModel(Transformation originalModel) {
    return originalModel.rebuild((other) {
      if (impactStory != null) {
        other.impactStory = impactStory!;
      }
    });
  }

  @override
  bool apply() {
    if (_updateMask.isEmpty) {
      return false;
    }

    final originalModel = globalHiveApi.transformation.get(_model.id);
    if (originalModel == null) {
      return false;
    }
    final updatedModel = applyUpdateToModel(originalModel);
    globalHiveApi.transformation.put(updatedModel.id, updatedModel);
    ensureRevert(21, originalModel.id, originalModel);
    Set<String>? updateMask = _updateMask;
    final CreateUpdateTransformationRequest? request =
        globalHiveApi.getSyncRequest(updatedModel.id);
    if (request != null) {
      if (!request.hasUpdateMask()) {
        // This edit follows a create. Stays as a create.
        updateMask = null;
      } else {
        // This edit follows a previous edit. Merge the edits.
        updateMask = {...updateMask, ...request.updateMask.paths};
      }
    }
    globalHiveApi.putSyncRequest(
        updatedModel.id,
        CreateUpdateTransformationRequest(
            transformation: updatedModel,
            updateMask:
                updateMask == null ? null : FieldMask(paths: updateMask)));
    return true;
  }
}

// Users cannot delete the Transformation type

void saveOutputLocally(Output model) {
  globalHiveApi.output.put(model.id, model);
}

void removeOutputLocally(String id) {
  globalHiveApi.output.delete(id);
}

class OutputCreateDelta extends DeltaBase {
  OutputCreateDelta({
    this.groupId,
    this.id,
    this.month,
    this.value,
    this.outputMarker,
  });

  final String? groupId;
  final String? id;
  final Date? month;
  final Int64? value;
  final OutputMarker? outputMarker;

  @override
  bool apply() {
    final model = Output(
      groupId: groupId,
      id: id ?? UuidGenerator.uuid(),
      month: month,
      value: value,
      outputMarker: outputMarker,
    )..freeze();
    globalHiveApi.output.put(model.id, model);
    ensureRevert(22, model.id, null);
    globalHiveApi.putSyncRequest(
        model.id, CreateUpdateOutputRequest(output: model));
    return true;
  }
}

// Users cannot update the Output type

// Users cannot delete the Output type

void saveOutputMarkerLocally(OutputMarker model) {
  // noop
}

// Users cannot create the OutputMarker type

// Users cannot update the OutputMarker type

// Users cannot delete the OutputMarker type

void saveEvaluationValueNameLocally(EvaluationValueName model) {
  // noop
}

// Users cannot create the EvaluationValueName type

// Users cannot update the EvaluationValueName type

// Users cannot delete the EvaluationValueName type

void revertAll() {
  _revertValuesInBox(globalHiveApi.action, globalHiveApi.revert.get(4));
  _revertValuesInBox(globalHiveApi.material, globalHiveApi.revert.get(5));
  _revertValuesInBox(globalHiveApi.group, globalHiveApi.revert.get(12));
  _revertValuesInBox(globalHiveApi.user, globalHiveApi.revert.get(16));
  _revertValuesInBox(
      globalHiveApi.learnerEvaluation, globalHiveApi.revert.get(18));
  _revertValuesInBox(
      globalHiveApi.teacherResponse, globalHiveApi.revert.get(19));
  _revertValuesInBox(
      globalHiveApi.groupEvaluation, globalHiveApi.revert.get(20));
  _revertValuesInBox(
      globalHiveApi.transformation, globalHiveApi.revert.get(21));
  _revertValuesInBox(globalHiveApi.output, globalHiveApi.revert.get(22));
}

Box _resolveBox(int typeId) {
  switch (typeId) {
    case 0:
      return globalHiveApi.country;
    case 1:
      return globalHiveApi.language;
    case 4:
      return globalHiveApi.action;
    case 5:
      return globalHiveApi.material;
    case 9:
      return globalHiveApi.materialTopic;
    case 10:
      return globalHiveApi.materialType;
    case 12:
      return globalHiveApi.group;
    case 14:
      return globalHiveApi.evaluationCategory;
    case 16:
      return globalHiveApi.user;
    case 18:
      return globalHiveApi.learnerEvaluation;
    case 19:
      return globalHiveApi.teacherResponse;
    case 20:
      return globalHiveApi.groupEvaluation;
    case 21:
      return globalHiveApi.transformation;
    case 22:
      return globalHiveApi.output;
    default:
      throw Exception('Unknown type id $typeId');
  }
}

const _messageToTypeIdMap = <Type, int>{
  CreateUpdateMaterialsRequest: 102,
  CreateUpdateGroupsRequest: 103,
  CreateUpdateUserRequest: 104,
  UpdateCurrentUserRequest: 105,
  CreateUpdateActionsRequest: 106,
  CreateUpdateTransformationRequest: 107,
  CreateUpdateTeacherResponseRequest: 108,
  CreateMaterialFeedbacksRequest: 109,
  CreateUpdateActionUserRequest: 110,
  CreateUpdateGroupEvaluationRequest: 111,
  CreateUpdateGroupUsersRequest: 112,
  CreateUpdateLearnerEvaluationRequest: 113,
  CreateUpdateOutputRequest: 114,
  DeleteActionRequest: 115,
  DeleteMaterialRequest: 116,
  DeleteGroupUserRequest: 117,
};
