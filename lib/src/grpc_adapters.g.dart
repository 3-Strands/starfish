// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grpc_adapters.dart';

class CountryAdapter extends _GrpcAdapter<Country> {
  @override
  int get typeId => 0;

  @override
  Country create() => Country.create();
}

class LanguageAdapter extends _GrpcAdapter<Language> {
  @override
  int get typeId => 1;

  @override
  Language create() => Language.create();
}

class GroupUserAdapter extends _GrpcAdapter<GroupUser> {
  @override
  int get typeId => 3;

  @override
  GroupUser create() => GroupUser.create();
}

class ActionAdapter extends _GrpcAdapter<Action> {
  @override
  int get typeId => 4;

  @override
  Action create() => Action.create();
}

class MaterialAdapter extends _GrpcAdapter<Material> {
  @override
  int get typeId => 5;

  @override
  Material create() => Material.create();
}

class MaterialFeedbackAdapter extends _GrpcAdapter<MaterialFeedback> {
  @override
  int get typeId => 6;

  @override
  MaterialFeedback create() => MaterialFeedback.create();
}

class MaterialTopicAdapter extends _GrpcAdapter<MaterialTopic> {
  @override
  int get typeId => 9;

  @override
  MaterialTopic create() => MaterialTopic.create();
}

class MaterialTypeAdapter extends _GrpcAdapter<MaterialType> {
  @override
  int get typeId => 10;

  @override
  MaterialType create() => MaterialType.create();
}

class GroupAdapter extends _GrpcAdapter<Group> {
  @override
  int get typeId => 12;

  @override
  Group create() => Group.create();
}

class ActionUserAdapter extends _GrpcAdapter<ActionUser> {
  @override
  int get typeId => 15;

  @override
  ActionUser create() => ActionUser.create();
}

class UserAdapter extends _GrpcAdapter<User> {
  @override
  int get typeId => 16;

  @override
  User create() => User.create();
}

class CreateMaterialFeedbacksRequestAdapter
    extends _GrpcAdapter<CreateMaterialFeedbacksRequest> {
  @override
  int get typeId => 102;

  @override
  CreateMaterialFeedbacksRequest create() =>
      CreateMaterialFeedbacksRequest.create();
}

class CreateUpdateActionsRequestAdapter
    extends _GrpcAdapter<CreateUpdateActionsRequest> {
  @override
  int get typeId => 103;

  @override
  CreateUpdateActionsRequest create() => CreateUpdateActionsRequest.create();
}

class CreateUpdateActionUserRequestAdapter
    extends _GrpcAdapter<CreateUpdateActionUserRequest> {
  @override
  int get typeId => 104;

  @override
  CreateUpdateActionUserRequest create() =>
      CreateUpdateActionUserRequest.create();
}

class CreateUpdateGroupEvaluationRequestAdapter
    extends _GrpcAdapter<CreateUpdateGroupEvaluationRequest> {
  @override
  int get typeId => 105;

  @override
  CreateUpdateGroupEvaluationRequest create() =>
      CreateUpdateGroupEvaluationRequest.create();
}

class CreateUpdateGroupsRequestAdapter
    extends _GrpcAdapter<CreateUpdateGroupsRequest> {
  @override
  int get typeId => 106;

  @override
  CreateUpdateGroupsRequest create() => CreateUpdateGroupsRequest.create();
}

class CreateUpdateGroupUsersRequestAdapter
    extends _GrpcAdapter<CreateUpdateGroupUsersRequest> {
  @override
  int get typeId => 107;

  @override
  CreateUpdateGroupUsersRequest create() =>
      CreateUpdateGroupUsersRequest.create();
}

class CreateUpdateLearnerEvaluationRequestAdapter
    extends _GrpcAdapter<CreateUpdateLearnerEvaluationRequest> {
  @override
  int get typeId => 108;

  @override
  CreateUpdateLearnerEvaluationRequest create() =>
      CreateUpdateLearnerEvaluationRequest.create();
}

class CreateUpdateMaterialsRequestAdapter
    extends _GrpcAdapter<CreateUpdateMaterialsRequest> {
  @override
  int get typeId => 109;

  @override
  CreateUpdateMaterialsRequest create() =>
      CreateUpdateMaterialsRequest.create();
}

class CreateUpdateOutputRequestAdapter
    extends _GrpcAdapter<CreateUpdateOutputRequest> {
  @override
  int get typeId => 110;

  @override
  CreateUpdateOutputRequest create() => CreateUpdateOutputRequest.create();
}

class CreateUpdateTeacherResponseRequestAdapter
    extends _GrpcAdapter<CreateUpdateTeacherResponseRequest> {
  @override
  int get typeId => 111;

  @override
  CreateUpdateTeacherResponseRequest create() =>
      CreateUpdateTeacherResponseRequest.create();
}

class CreateUpdateTransformationRequestAdapter
    extends _GrpcAdapter<CreateUpdateTransformationRequest> {
  @override
  int get typeId => 112;

  @override
  CreateUpdateTransformationRequest create() =>
      CreateUpdateTransformationRequest.create();
}

class CreateUpdateUserRequestAdapter
    extends _GrpcAdapter<CreateUpdateUserRequest> {
  @override
  int get typeId => 113;

  @override
  CreateUpdateUserRequest create() => CreateUpdateUserRequest.create();
}

class DeleteActionRequestAdapter extends _GrpcAdapter<DeleteActionRequest> {
  @override
  int get typeId => 114;

  @override
  DeleteActionRequest create() => DeleteActionRequest.create();
}

class DeleteMaterialRequestAdapter extends _GrpcAdapter<DeleteMaterialRequest> {
  @override
  int get typeId => 116;

  @override
  DeleteMaterialRequest create() => DeleteMaterialRequest.create();
}

class UpdateCurrentUserRequestAdapter
    extends _GrpcAdapter<UpdateCurrentUserRequest> {
  @override
  int get typeId => 117;

  @override
  UpdateCurrentUserRequest create() => UpdateCurrentUserRequest.create();
}

void registerAllAdapters() {
  Hive.registerAdapter(CountryAdapter());
  Hive.registerAdapter(LanguageAdapter());
  Hive.registerAdapter(GroupUserAdapter());
  Hive.registerAdapter(ActionAdapter());
  Hive.registerAdapter(MaterialAdapter());
  Hive.registerAdapter(MaterialFeedbackAdapter());
  Hive.registerAdapter(MaterialTopicAdapter());
  Hive.registerAdapter(MaterialTypeAdapter());
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(ActionUserAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CreateMaterialFeedbacksRequestAdapter());
  Hive.registerAdapter(CreateUpdateActionsRequestAdapter());
  Hive.registerAdapter(CreateUpdateActionUserRequestAdapter());
  Hive.registerAdapter(CreateUpdateGroupEvaluationRequestAdapter());
  Hive.registerAdapter(CreateUpdateGroupsRequestAdapter());
  Hive.registerAdapter(CreateUpdateGroupUsersRequestAdapter());
  Hive.registerAdapter(CreateUpdateLearnerEvaluationRequestAdapter());
  Hive.registerAdapter(CreateUpdateMaterialsRequestAdapter());
  Hive.registerAdapter(CreateUpdateOutputRequestAdapter());
  Hive.registerAdapter(CreateUpdateTeacherResponseRequestAdapter());
  Hive.registerAdapter(CreateUpdateTransformationRequestAdapter());
  Hive.registerAdapter(CreateUpdateUserRequestAdapter());
  Hive.registerAdapter(DeleteActionRequestAdapter());
  Hive.registerAdapter(DeleteMaterialRequestAdapter());
  Hive.registerAdapter(UpdateCurrentUserRequestAdapter());
}
