// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deltas.dart';

// Country is not creatable

// Country is not updatable

// Country is not deletable

// Language is not creatable

// Language is not updatable

// Language is not deletable

class GroupUserCreateDelta extends DeltaBase {
  GroupUserCreateDelta({
    this.groupId,
    this.userId,
    this.role,
    this.profile,
  });

  final String? groupId;
  final String? userId;
  final GroupUser_Role? role;
  final String? profile;

  @override
  bool apply() {
    final model = GroupUser(
      groupId: groupId,
      userId: userId,
      role: role,
      profile: profile,
    );
    globalHiveApi.group.get(model.groupId)!.users.add(model);
    globalHiveApi.user.get(model.userId)!.groups.add(model);
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
    final updateMask = <String>[];

    if (role != null && role != _model.role) {
      _model.role = role!;
      updateMask.add('role');
    }

    if (profile != null && profile != _model.profile) {
      _model.profile = profile!;
      updateMask.add('profile');
    }

    if (updateMask.isNotEmpty) {
      globalHiveApi.group.resave(_model.groupId);
      globalHiveApi.user.resave(_model.userId);
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
    globalHiveApi.group
        .edit(_model.groupId, (item) => item.users.remove(_model));
    globalHiveApi.user
        .edit(_model.userId, (item) => item.groups.remove(_model));
    return true;
  }
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
    );
    globalHiveApi.action.put(model.id, model);
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
    final updateMask = <String>[];

    if (type != null && type != _model.type) {
      _model.type = type!;
      updateMask.add('type');
    }

    if (name != null && name != _model.name) {
      _model.name = name!;
      updateMask.add('name');
    }

    if (groupId != null && groupId != _model.groupId) {
      _model.groupId = groupId!;
      updateMask.add('group_id');
    }

    if (instructions != null && instructions != _model.instructions) {
      _model.instructions = instructions!;
      updateMask.add('instructions');
    }

    if (materialId != null && materialId != _model.materialId) {
      _model.materialId = materialId!;
      updateMask.add('material_id');
    }

    if (question != null && question != _model.question) {
      _model.question = question!;
      updateMask.add('question');
    }

    if (dateDue != null && dateDue != _model.dateDue) {
      _model.dateDue = dateDue!;
      updateMask.add('date_due');
    }

    if (updateMask.isNotEmpty) {
      globalHiveApi.action.put(_model.id, _model);
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
    return true;
  }
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
    );
    globalHiveApi.material.put(model.id, model);
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
    final updateMask = <String>[];

    if (visibility != null && visibility != _model.visibility) {
      _model.visibility = visibility!;
      updateMask.add('visibility');
    }

    if (editability != null && editability != _model.editability) {
      _model.editability = editability!;
      updateMask.add('editability');
    }

    if (title != null && title != _model.title) {
      _model.title = title!;
      updateMask.add('title');
    }

    if (description != null && description != _model.description) {
      _model.description = description!;
      updateMask.add('description');
    }

    if (url != null && url != _model.url) {
      _model.url = url!;
      updateMask.add('url');
    }

    if (files != null && !listsAreSame(files!, _model.files)) {
      _model.files
        ..clear()
        ..addAll(files!);
      updateMask.add('files');
    }

    if (languageIds != null &&
        !listsAreSame(languageIds!, _model.languageIds)) {
      _model.languageIds
        ..clear()
        ..addAll(languageIds!);
      updateMask.add('language_ids');
    }

    if (typeIds != null && !listsAreSame(typeIds!, _model.typeIds)) {
      _model.typeIds
        ..clear()
        ..addAll(typeIds!);
      updateMask.add('type_ids');
    }

    if (topics != null && !listsAreSame(topics!, _model.topics)) {
      _model.topics
        ..clear()
        ..addAll(topics!);
      updateMask.add('topics');
    }

    if (updateMask.isNotEmpty) {
      globalHiveApi.material.put(_model.id, _model);
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
    return true;
  }
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
    );
    globalHiveApi.material.get(model.materialId)!.feedbacks.add(model);
    return true;
  }
}

// MaterialFeedback is not updatable

// MaterialFeedback is not deletable

// MaterialTopic is not creatable

// MaterialTopic is not updatable

// MaterialTopic is not deletable

// MaterialType is not creatable

// MaterialType is not updatable

// MaterialType is not deletable

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
    );
    globalHiveApi.group.put(model.id, model);
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
    final updateMask = <String>[];

    if (name != null && name != _model.name) {
      _model.name = name!;
      updateMask.add('name');
    }

    if (languageIds != null &&
        !listsAreSame(languageIds!, _model.languageIds)) {
      _model.languageIds
        ..clear()
        ..addAll(languageIds!);
      updateMask.add('language_ids');
    }

    if (evaluationCategoryIds != null &&
        !listsAreSame(evaluationCategoryIds!, _model.evaluationCategoryIds)) {
      _model.evaluationCategoryIds
        ..clear()
        ..addAll(evaluationCategoryIds!);
      updateMask.add('evaluation_category_ids');
    }

    if (description != null && description != _model.description) {
      _model.description = description!;
      updateMask.add('description');
    }

    if (linkEmail != null && linkEmail != _model.linkEmail) {
      _model.linkEmail = linkEmail!;
      updateMask.add('link_email');
    }

    if (status != null && status != _model.status) {
      _model.status = status!;
      updateMask.add('status');
    }

    if (updateMask.isNotEmpty) {
      globalHiveApi.group.put(_model.id, _model);
      return true;
    }
    return false;
  }
}

// Group is not deletable

class ActionUserCreateDelta extends DeltaBase {
  ActionUserCreateDelta({
    this.actionId,
    this.userId,
    this.status,
    this.teacherResponse,
    this.userResponse,
    this.evaluation,
  });

  final String? actionId;
  final String? userId;
  final ActionUser_Status? status;
  final String? teacherResponse;
  final String? userResponse;
  final ActionUser_Evaluation? evaluation;

  @override
  bool apply() {
    final model = ActionUser(
      actionId: actionId,
      userId: userId,
      status: status,
      teacherResponse: teacherResponse,
      userResponse: userResponse,
      evaluation: evaluation,
    );
    globalHiveApi.user.get(model.userId)!.actions.add(model);
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
    final updateMask = <String>[];

    if (status != null && status != _model.status) {
      _model.status = status!;
      updateMask.add('status');
    }

    if (teacherResponse != null && teacherResponse != _model.teacherResponse) {
      _model.teacherResponse = teacherResponse!;
      updateMask.add('teacher_response');
    }

    if (userResponse != null && userResponse != _model.userResponse) {
      _model.userResponse = userResponse!;
      updateMask.add('user_response');
    }

    if (evaluation != null && evaluation != _model.evaluation) {
      _model.evaluation = evaluation!;
      updateMask.add('evaluation');
    }

    if (updateMask.isNotEmpty) {
      globalHiveApi.user.resave(_model.userId);
      return true;
    }
    return false;
  }
}

// ActionUser is not deletable

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
    );
    globalHiveApi.user.put(model.id, model);
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
    final updateMask = <String>[];

    if (name != null && name != _model.name) {
      _model.name = name!;
      updateMask.add('name');
    }

    if (phone != null && phone != _model.phone) {
      _model.phone = phone!;
      updateMask.add('phone');
    }

    if (phoneCountryId != null && phoneCountryId != _model.phoneCountryId) {
      _model.phoneCountryId = phoneCountryId!;
      updateMask.add('phone_country_id');
    }

    if (diallingCode != null && diallingCode != _model.diallingCode) {
      _model.diallingCode = diallingCode!;
      updateMask.add('dialling_code');
    }

    if (updateMask.isNotEmpty) {
      globalHiveApi.user.put(_model.id, _model);
      return true;
    }
    return false;
  }
}

// User is not deletable
