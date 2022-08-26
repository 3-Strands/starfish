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

class EvaluationCategoryAdapter extends _GrpcAdapter<EvaluationCategory> {
  @override
  int get typeId => 14;

  @override
  EvaluationCategory create() => EvaluationCategory.create();
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

class LearnerEvaluationAdapter extends _GrpcAdapter<LearnerEvaluation> {
  @override
  int get typeId => 18;

  @override
  LearnerEvaluation create() => LearnerEvaluation.create();
}

class TeacherResponseAdapter extends _GrpcAdapter<TeacherResponse> {
  @override
  int get typeId => 19;

  @override
  TeacherResponse create() => TeacherResponse.create();
}

class GroupEvaluationAdapter extends _GrpcAdapter<GroupEvaluation> {
  @override
  int get typeId => 20;

  @override
  GroupEvaluation create() => GroupEvaluation.create();
}

class TransformationAdapter extends _GrpcAdapter<Transformation> {
  @override
  int get typeId => 21;

  @override
  Transformation create() => Transformation.create();
}

class OutputAdapter extends _GrpcAdapter<Output> {
  @override
  int get typeId => 22;

  @override
  Output create() => Output.create();
}

class OutputMarkerAdapter extends _GrpcAdapter<OutputMarker> {
  @override
  int get typeId => 23;

  @override
  OutputMarker create() => OutputMarker.create();
}

class EvaluationValueNameAdapter extends _GrpcAdapter<EvaluationValueName> {
  @override
  int get typeId => 24;

  @override
  EvaluationValueName create() => EvaluationValueName.create();
}

class CreateUpdateMaterialsRequestAdapter
    extends _GrpcAdapter<CreateUpdateMaterialsRequest> {
  @override
  int get typeId => 102;

  @override
  CreateUpdateMaterialsRequest create() =>
      CreateUpdateMaterialsRequest.create();
}

class CreateUpdateGroupsRequestAdapter
    extends _GrpcAdapter<CreateUpdateGroupsRequest> {
  @override
  int get typeId => 103;

  @override
  CreateUpdateGroupsRequest create() => CreateUpdateGroupsRequest.create();
}

class CreateUpdateUserRequestAdapter
    extends _GrpcAdapter<CreateUpdateUserRequest> {
  @override
  int get typeId => 104;

  @override
  CreateUpdateUserRequest create() => CreateUpdateUserRequest.create();
}

class UpdateCurrentUserRequestAdapter
    extends _GrpcAdapter<UpdateCurrentUserRequest> {
  @override
  int get typeId => 105;

  @override
  UpdateCurrentUserRequest create() => UpdateCurrentUserRequest.create();
}

class CreateUpdateActionsRequestAdapter
    extends _GrpcAdapter<CreateUpdateActionsRequest> {
  @override
  int get typeId => 106;

  @override
  CreateUpdateActionsRequest create() => CreateUpdateActionsRequest.create();
}

class CreateUpdateTransformationRequestAdapter
    extends _GrpcAdapter<CreateUpdateTransformationRequest> {
  @override
  int get typeId => 107;

  @override
  CreateUpdateTransformationRequest create() =>
      CreateUpdateTransformationRequest.create();
}

class CreateUpdateTeacherResponseRequestAdapter
    extends _GrpcAdapter<CreateUpdateTeacherResponseRequest> {
  @override
  int get typeId => 108;

  @override
  CreateUpdateTeacherResponseRequest create() =>
      CreateUpdateTeacherResponseRequest.create();
}

class CreateMaterialFeedbacksRequestAdapter
    extends _GrpcAdapter<CreateMaterialFeedbacksRequest> {
  @override
  int get typeId => 109;

  @override
  CreateMaterialFeedbacksRequest create() =>
      CreateMaterialFeedbacksRequest.create();
}

class CreateUpdateActionUserRequestAdapter
    extends _GrpcAdapter<CreateUpdateActionUserRequest> {
  @override
  int get typeId => 110;

  @override
  CreateUpdateActionUserRequest create() =>
      CreateUpdateActionUserRequest.create();
}

class CreateUpdateGroupEvaluationRequestAdapter
    extends _GrpcAdapter<CreateUpdateGroupEvaluationRequest> {
  @override
  int get typeId => 111;

  @override
  CreateUpdateGroupEvaluationRequest create() =>
      CreateUpdateGroupEvaluationRequest.create();
}

class CreateUpdateGroupUsersRequestAdapter
    extends _GrpcAdapter<CreateUpdateGroupUsersRequest> {
  @override
  int get typeId => 112;

  @override
  CreateUpdateGroupUsersRequest create() =>
      CreateUpdateGroupUsersRequest.create();
}

class CreateUpdateLearnerEvaluationRequestAdapter
    extends _GrpcAdapter<CreateUpdateLearnerEvaluationRequest> {
  @override
  int get typeId => 113;

  @override
  CreateUpdateLearnerEvaluationRequest create() =>
      CreateUpdateLearnerEvaluationRequest.create();
}

class CreateUpdateOutputRequestAdapter
    extends _GrpcAdapter<CreateUpdateOutputRequest> {
  @override
  int get typeId => 114;

  @override
  CreateUpdateOutputRequest create() => CreateUpdateOutputRequest.create();
}

class DeleteActionRequestAdapter extends _GrpcAdapter<DeleteActionRequest> {
  @override
  int get typeId => 115;

  @override
  DeleteActionRequest create() => DeleteActionRequest.create();
}

class DeleteMaterialRequestAdapter extends _GrpcAdapter<DeleteMaterialRequest> {
  @override
  int get typeId => 116;

  @override
  DeleteMaterialRequest create() => DeleteMaterialRequest.create();
}

class DeleteGroupUserRequestAdapter
    extends _GrpcAdapter<DeleteGroupUserRequest> {
  @override
  int get typeId => 117;

  @override
  DeleteGroupUserRequest create() => DeleteGroupUserRequest.create();
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
  Hive.registerAdapter(EvaluationCategoryAdapter());
  Hive.registerAdapter(ActionUserAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LearnerEvaluationAdapter());
  Hive.registerAdapter(TeacherResponseAdapter());
  Hive.registerAdapter(GroupEvaluationAdapter());
  Hive.registerAdapter(TransformationAdapter());
  Hive.registerAdapter(OutputAdapter());
  Hive.registerAdapter(OutputMarkerAdapter());
  Hive.registerAdapter(EvaluationValueNameAdapter());
  Hive.registerAdapter(CreateUpdateMaterialsRequestAdapter());
  Hive.registerAdapter(CreateUpdateGroupsRequestAdapter());
  Hive.registerAdapter(CreateUpdateUserRequestAdapter());
  Hive.registerAdapter(UpdateCurrentUserRequestAdapter());
  Hive.registerAdapter(CreateUpdateActionsRequestAdapter());
  Hive.registerAdapter(CreateUpdateTransformationRequestAdapter());
  Hive.registerAdapter(CreateUpdateTeacherResponseRequestAdapter());
  Hive.registerAdapter(CreateMaterialFeedbacksRequestAdapter());
  Hive.registerAdapter(CreateUpdateActionUserRequestAdapter());
  Hive.registerAdapter(CreateUpdateGroupEvaluationRequestAdapter());
  Hive.registerAdapter(CreateUpdateGroupUsersRequestAdapter());
  Hive.registerAdapter(CreateUpdateLearnerEvaluationRequestAdapter());
  Hive.registerAdapter(CreateUpdateOutputRequestAdapter());
  Hive.registerAdapter(DeleteActionRequestAdapter());
  Hive.registerAdapter(DeleteMaterialRequestAdapter());
  Hive.registerAdapter(DeleteGroupUserRequestAdapter());
}
