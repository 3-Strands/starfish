// GENERATED CODE - DO NOT MODIFY BY HAND

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
      id: id,
      groupId: groupId,
      userId: userId,
      role: role,
      profile: profile,
    )..freeze();
    globalHiveApi.group.applyEdit(12, model.groupId, (other) {
      other.users.add(model);
    });
    globalHiveApi.user.applyEdit(16, model.userId, (other) {
      other.groups.add(model);
    });
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync
        .put(model.id, CreateUpdateGroupUsersRequest(groupUser: model));
    return true;
  }
}

class GroupUserUpdateDelta extends DeltaBase {
  GroupUserUpdateDelta(
    this._model, {
    this.role,
    this.profile,
  });

  final GroupUser _model;
  final GroupUser_Role? role;
  final String? profile;

  @override
  bool apply() {
    Set<String>? updateMask = <String>{};
    final newModel = _model.rebuild((other) {
      if (role != null && role != other.role) {
        other.role = role!;
        updateMask!.add('role');
      }

      if (profile != null && profile != other.profile) {
        other.profile = profile!;
        updateMask!.add('profile');
      }
    });

    if (updateMask.isNotEmpty) {
      final id = newModel.id;
      globalHiveApi.group.applyEdit(12, newModel.groupId, (other) {
        final index = other.users.indexWhere((item) => item.id == id);
        other.users[index] = newModel;
      });

      globalHiveApi.user.applyEdit(16, newModel.userId, (other) {
        final index = other.groups.indexWhere((item) => item.id == id);
        other.groups[index] = newModel;
      });
      final CreateUpdateGroupUsersRequest? request =
          globalHiveApi.sync.get(newModel.id);
      if (request != null) {
        if (!request.hasUpdateMask()) {
          // This edit follows a create. Stays as a create.
          updateMask = null;
        } else {
          // This edit follows a previous edit. Merge the edits.
          updateMask = {...updateMask, ...request.updateMask.paths};
        }
      }
      globalHiveApi.sync.put(
          newModel.id,
          CreateUpdateGroupUsersRequest(
              groupUser: newModel,
              updateMask:
                  updateMask == null ? null : FieldMask(paths: updateMask)));
      return true;
    }
    return false;
  }
}

class GroupUserDeleteDelta extends DeltaBase {
  GroupUserDeleteDelta(this._model);

  final GroupUser _model;

  @override
  bool apply() {
    globalHiveApi.group.applyEdit(12, _model.groupId,
        (other) => other.users.removeWhere((item) => item.id == _model.id));
    globalHiveApi.user.applyEdit(16, _model.userId,
        (other) => other.groups.removeWhere((item) => item.id == _model.id));
    final CreateUpdateGroupUsersRequest? request =
        globalHiveApi.sync.get(_model.id);
    if (request != null && !request.hasUpdateMask()) {
      // This delete follows a create. Reverts to nothing.
      globalHiveApi.sync.delete(_model.id);
    } else {
      globalHiveApi.sync
          .put(_model.id, DeleteGroupUserRequest(groupUserId: _model.id));
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
      id: id,
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
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(model.id, CreateUpdateActionsRequest(action: model));
    return true;
  }
}

class ActionUpdateDelta extends DeltaBase {
  ActionUpdateDelta(
    this._model, {
    this.type,
    this.name,
    this.groupId,
    this.instructions,
    this.materialId,
    this.question,
    this.dateDue,
  });

  final Action _model;
  final Action_Type? type;
  final String? name;
  final String? groupId;
  final String? instructions;
  final String? materialId;
  final String? question;
  final Date? dateDue;

  @override
  bool apply() {
    Set<String>? updateMask = <String>{};
    final newModel = _model.rebuild((other) {
      if (type != null && type != other.type) {
        other.type = type!;
        updateMask!.add('type');
      }

      if (name != null && name != other.name) {
        other.name = name!;
        updateMask!.add('name');
      }

      if (groupId != null && groupId != other.groupId) {
        other.groupId = groupId!;
        updateMask!.add('group_id');
      }

      if (instructions != null && instructions != other.instructions) {
        other.instructions = instructions!;
        updateMask!.add('instructions');
      }

      if (materialId != null && materialId != other.materialId) {
        other.materialId = materialId!;
        updateMask!.add('material_id');
      }

      if (question != null && question != other.question) {
        other.question = question!;
        updateMask!.add('question');
      }

      if (dateDue != null && dateDue != other.dateDue) {
        other.dateDue = dateDue!;
        updateMask!.add('date_due');
      }
    });

    if (updateMask.isNotEmpty) {
      globalHiveApi.action.put(newModel.id, newModel);
      ensureRevert(4, _model.id, _model);
      final CreateUpdateActionsRequest? request =
          globalHiveApi.sync.get(newModel.id);
      if (request != null) {
        if (!request.hasUpdateMask()) {
          // This edit follows a create. Stays as a create.
          updateMask = null;
        } else {
          // This edit follows a previous edit. Merge the edits.
          updateMask = {...updateMask, ...request.updateMask.paths};
        }
      }
      globalHiveApi.sync.put(
          newModel.id,
          CreateUpdateActionsRequest(
              action: newModel,
              updateMask:
                  updateMask == null ? null : FieldMask(paths: updateMask)));
      return true;
    }
    return false;
  }
}

class ActionDeleteDelta extends DeltaBase {
  ActionDeleteDelta(this._model);

  final Action _model;

  @override
  bool apply() {
    globalHiveApi.action.delete(_model.id);
    ensureRevert(4, _model.id, _model);
    final CreateUpdateActionsRequest? request =
        globalHiveApi.sync.get(_model.id);
    if (request != null && !request.hasUpdateMask()) {
      // This delete follows a create. Reverts to nothing.
      globalHiveApi.sync.delete(_model.id);
    } else {
      globalHiveApi.sync
          .put(_model.id, DeleteActionRequest(actionId: _model.id));
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
      id: id,
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
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync
        .put(model.id, CreateUpdateMaterialsRequest(material: model));
    return true;
  }
}

class MaterialUpdateDelta extends DeltaBase {
  MaterialUpdateDelta(
    this._model, {
    this.visibility,
    this.editability,
    this.title,
    this.description,
    this.url,
    this.files,
    this.languageIds,
    this.typeIds,
    this.topics,
  });

  final Material _model;
  final Material_Visibility? visibility;
  final Material_Editability? editability;
  final String? title;
  final String? description;
  final String? url;
  final List<String>? files;
  final List<String>? languageIds;
  final List<String>? typeIds;
  final List<String>? topics;

  @override
  bool apply() {
    Set<String>? updateMask = <String>{};
    final newModel = _model.rebuild((other) {
      if (visibility != null && visibility != other.visibility) {
        other.visibility = visibility!;
        updateMask!.add('visibility');
      }

      if (editability != null && editability != other.editability) {
        other.editability = editability!;
        updateMask!.add('editability');
      }

      if (title != null && title != other.title) {
        other.title = title!;
        updateMask!.add('title');
      }

      if (description != null && description != other.description) {
        other.description = description!;
        updateMask!.add('description');
      }

      if (url != null && url != other.url) {
        other.url = url!;
        updateMask!.add('url');
      }

      if (files != null && !listsAreSame(files!, other.files)) {
        other.files
          ..clear()
          ..addAll(files!);
        updateMask!.add('files');
      }

      if (languageIds != null &&
          !listsAreSame(languageIds!, other.languageIds)) {
        other.languageIds
          ..clear()
          ..addAll(languageIds!);
        updateMask!.add('language_ids');
      }

      if (typeIds != null && !listsAreSame(typeIds!, other.typeIds)) {
        other.typeIds
          ..clear()
          ..addAll(typeIds!);
        updateMask!.add('type_ids');
      }

      if (topics != null && !listsAreSame(topics!, other.topics)) {
        other.topics
          ..clear()
          ..addAll(topics!);
        updateMask!.add('topics');
      }
    });

    if (updateMask.isNotEmpty) {
      globalHiveApi.material.put(newModel.id, newModel);
      ensureRevert(5, _model.id, _model);
      final CreateUpdateMaterialsRequest? request =
          globalHiveApi.sync.get(newModel.id);
      if (request != null) {
        if (!request.hasUpdateMask()) {
          // This edit follows a create. Stays as a create.
          updateMask = null;
        } else {
          // This edit follows a previous edit. Merge the edits.
          updateMask = {...updateMask, ...request.updateMask.paths};
        }
      }
      globalHiveApi.sync.put(
          newModel.id,
          CreateUpdateMaterialsRequest(
              material: newModel,
              updateMask:
                  updateMask == null ? null : FieldMask(paths: updateMask)));
      return true;
    }
    return false;
  }
}

class MaterialDeleteDelta extends DeltaBase {
  MaterialDeleteDelta(this._model);

  final Material _model;

  @override
  bool apply() {
    globalHiveApi.material.delete(_model.id);
    ensureRevert(5, _model.id, _model);
    final CreateUpdateMaterialsRequest? request =
        globalHiveApi.sync.get(_model.id);
    if (request != null && !request.hasUpdateMask()) {
      // This delete follows a create. Reverts to nothing.
      globalHiveApi.sync.delete(_model.id);
    } else {
      globalHiveApi.sync
          .put(_model.id, DeleteMaterialRequest(materialId: _model.id));
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
      id: id,
      type: type,
      reporterId: reporterId,
      report: report,
      response: response,
      materialId: materialId,
    )..freeze();
    globalHiveApi.material.applyEdit(5, model.materialId, (other) {
      other.feedbacks.add(model);
    });
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync
        .put(model.id, CreateMaterialFeedbacksRequest(feedback: model));
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
      id: id,
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
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(model.id, CreateUpdateGroupsRequest(group: model));
    return true;
  }
}

class GroupUpdateDelta extends DeltaBase {
  GroupUpdateDelta(
    this._model, {
    this.name,
    this.languageIds,
    this.evaluationCategoryIds,
    this.description,
    this.linkEmail,
    this.status,
  });

  final Group _model;
  final String? name;
  final List<String>? languageIds;
  final List<String>? evaluationCategoryIds;
  final String? description;
  final String? linkEmail;
  final Group_Status? status;

  @override
  bool apply() {
    Set<String>? updateMask = <String>{};
    final newModel = _model.rebuild((other) {
      if (name != null && name != other.name) {
        other.name = name!;
        updateMask!.add('name');
      }

      if (languageIds != null &&
          !listsAreSame(languageIds!, other.languageIds)) {
        other.languageIds
          ..clear()
          ..addAll(languageIds!);
        updateMask!.add('language_ids');
      }

      if (evaluationCategoryIds != null &&
          !listsAreSame(evaluationCategoryIds!, other.evaluationCategoryIds)) {
        other.evaluationCategoryIds
          ..clear()
          ..addAll(evaluationCategoryIds!);
        updateMask!.add('evaluation_category_ids');
      }

      if (description != null && description != other.description) {
        other.description = description!;
        updateMask!.add('description');
      }

      if (linkEmail != null && linkEmail != other.linkEmail) {
        other.linkEmail = linkEmail!;
        updateMask!.add('link_email');
      }

      if (status != null && status != other.status) {
        other.status = status!;
        updateMask!.add('status');
      }
    });

    if (updateMask.isNotEmpty) {
      globalHiveApi.group.put(newModel.id, newModel);
      ensureRevert(12, _model.id, _model);
      final CreateUpdateGroupsRequest? request =
          globalHiveApi.sync.get(newModel.id);
      if (request != null) {
        if (!request.hasUpdateMask()) {
          // This edit follows a create. Stays as a create.
          updateMask = null;
        } else {
          // This edit follows a previous edit. Merge the edits.
          updateMask = {...updateMask, ...request.updateMask.paths};
        }
      }
      globalHiveApi.sync.put(
          newModel.id,
          CreateUpdateGroupsRequest(
              group: newModel,
              updateMask:
                  updateMask == null ? null : FieldMask(paths: updateMask)));
      return true;
    }
    return false;
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
      id: id,
      actionId: actionId,
      userId: userId,
      status: status,
      teacherResponse: teacherResponse,
      userResponse: userResponse,
      evaluation: evaluation,
    )..freeze();
    globalHiveApi.user.applyEdit(16, model.userId, (other) {
      other.actions.add(model);
    });
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync
        .put(model.id, CreateUpdateActionUserRequest(actionUser: model));
    return true;
  }
}

class ActionUserUpdateDelta extends DeltaBase {
  ActionUserUpdateDelta(
    this._model, {
    this.status,
    this.teacherResponse,
    this.userResponse,
    this.evaluation,
  });

  final ActionUser _model;
  final ActionUser_Status? status;
  final String? teacherResponse;
  final String? userResponse;
  final ActionUser_Evaluation? evaluation;

  @override
  bool apply() {
    Set<String>? updateMask = <String>{};
    final newModel = _model.rebuild((other) {
      if (status != null && status != other.status) {
        other.status = status!;
        updateMask!.add('status');
      }

      if (teacherResponse != null && teacherResponse != other.teacherResponse) {
        other.teacherResponse = teacherResponse!;
        updateMask!.add('teacher_response');
      }

      if (userResponse != null && userResponse != other.userResponse) {
        other.userResponse = userResponse!;
        updateMask!.add('user_response');
      }

      if (evaluation != null && evaluation != other.evaluation) {
        other.evaluation = evaluation!;
        updateMask!.add('evaluation');
      }
    });

    if (updateMask.isNotEmpty) {
      final id = newModel.id;
      globalHiveApi.user.applyEdit(16, newModel.userId, (other) {
        final index = other.actions.indexWhere((item) => item.id == id);
        other.actions[index] = newModel;
      });
      final CreateUpdateActionUserRequest? request =
          globalHiveApi.sync.get(newModel.id);
      if (request != null) {
        if (!request.hasUpdateMask()) {
          // This edit follows a create. Stays as a create.
          updateMask = null;
        } else {
          // This edit follows a previous edit. Merge the edits.
          updateMask = {...updateMask, ...request.updateMask.paths};
        }
      }
      globalHiveApi.sync.put(
          newModel.id,
          CreateUpdateActionUserRequest(
              actionUser: newModel,
              updateMask:
                  updateMask == null ? null : FieldMask(paths: updateMask)));
      return true;
    }
    return false;
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
      id: id,
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
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(model.id, CreateUpdateUserRequest(user: model));
    return true;
  }
}

class UserUpdateDelta extends DeltaBase {
  UserUpdateDelta(
    this._model, {
    this.name,
    this.phone,
    this.phoneCountryId,
    this.diallingCode,
  });

  final User _model;
  final String? name;
  final String? phone;
  final String? phoneCountryId;
  final String? diallingCode;

  @override
  bool apply() {
    Set<String>? updateMask = <String>{};
    final newModel = _model.rebuild((other) {
      if (name != null && name != other.name) {
        other.name = name!;
        updateMask!.add('name');
      }

      if (phone != null && phone != other.phone) {
        other.phone = phone!;
        updateMask!.add('phone');
      }

      if (phoneCountryId != null && phoneCountryId != other.phoneCountryId) {
        other.phoneCountryId = phoneCountryId!;
        updateMask!.add('phone_country_id');
      }

      if (diallingCode != null && diallingCode != other.diallingCode) {
        other.diallingCode = diallingCode!;
        updateMask!.add('dialling_code');
      }
    });

    if (updateMask.isNotEmpty) {
      globalHiveApi.user.put(newModel.id, newModel);
      ensureRevert(16, _model.id, _model);
      final CreateUpdateUserRequest? request =
          globalHiveApi.sync.get(newModel.id);
      if (request != null) {
        if (!request.hasUpdateMask()) {
          // This edit follows a create. Stays as a create.
          updateMask = null;
        } else {
          // This edit follows a previous edit. Merge the edits.
          updateMask = {...updateMask, ...request.updateMask.paths};
        }
      }
      globalHiveApi.sync.put(
          newModel.id,
          CreateUpdateUserRequest(
              user: newModel,
              updateMask:
                  updateMask == null ? null : FieldMask(paths: updateMask)));
      return true;
    }
    return false;
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
      id: id,
      learnerId: learnerId,
      evaluatorId: evaluatorId,
      groupId: groupId,
      month: month,
      categoryId: categoryId,
      evaluation: evaluation,
    )..freeze();
    globalHiveApi.learnerEvaluation.put(model.id, model);
    ensureRevert(18, model.id, null);
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(model.id,
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
      id: id,
      learnerId: learnerId,
      teacherId: teacherId,
      groupId: groupId,
      month: month,
      response: response,
    )..freeze();
    globalHiveApi.teacherResponse.put(model.id, model);
    ensureRevert(19, model.id, null);
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(
        model.id, CreateUpdateTeacherResponseRequest(teacherResponse: model));
    return true;
  }
}

// Users cannot update the TeacherResponse type

// Users cannot delete the TeacherResponse type

void saveGroupEvaluationLocally(GroupEvaluation model) {
  globalHiveApi.groupEvaluation.put(model.id, model);
}

void removeGroupEvaluationLocally(String id) {
  globalHiveApi.groupEvaluation.delete(id);
}

// Users cannot create the GroupEvaluation type

// Users cannot update the GroupEvaluation type

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
      id: id,
      userId: userId,
      groupId: groupId,
      month: month,
      impactStory: impactStory,
      files: files,
    )..freeze();
    globalHiveApi.transformation.put(model.id, model);
    ensureRevert(21, model.id, null);
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(
        model.id, CreateUpdateTransformationRequest(transformation: model));
    return true;
  }
}

// Users cannot update the Transformation type

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
      id: id,
      month: month,
      value: value,
      outputMarker: outputMarker,
    )..freeze();
    globalHiveApi.output.put(model.id, model);
    ensureRevert(22, model.id, null);
    assert(!globalHiveApi.sync.containsKey(model.id));
    globalHiveApi.sync.put(model.id, CreateUpdateOutputRequest(output: model));
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
