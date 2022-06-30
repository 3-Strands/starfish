import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/sync_time.dart';

class GrpcRepository {
  final StarfishClient client;
  final FileTransferClient fileTransferClient;

  GrpcRepository({
    required this.client,
    required this.fileTransferClient,
  });

  ResponseStream<Country> listAllCountries() {
    var request = ListAllCountriesRequest();
    return client.listAllCountries(request);
  }

  ResponseStream<Language> listAllLanguages() {
    var request = ListLanguagesRequest();
    return client.listLanguages(request);
  }

  Future<User> getCurrentUser() {
    return client.getCurrentUser(Empty());
  }

  Future<User> updateCurrentUser(User user, List<String> fieldMaskPaths) {
    var request = UpdateCurrentUserRequest.create();
    request.user = user;

    request.updateMask = FieldMask(paths: fieldMaskPaths);

    return client.updateCurrentUser(request);
  }

  ResponseStream<Material> getMaterials() {
    var request = ListMaterialsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listMaterials(request);
  }

  ResponseStream<MaterialTopic> getMaterialTopics() {
    var request = ListMaterialTopicsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listMaterialTopics(request);
  }

  ResponseStream<MaterialType> getMaterialTypes() {
    var request = ListMaterialTypesRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listMaterialTypes(request);
  }

  ResponseStream<CreateUpdateMaterialsResponse> createUpdateMaterial(
      Stream<CreateUpdateMaterialsRequest> request) {
    return client.createUpdateMaterials(request);
  }

  ResponseStream<DeleteMaterialResponse> deleteMaterials(
      Stream<DeleteMaterialRequest> request) {
    return client.deleteMaterials(request);
  }

  ResponseStream<Group> getGroups() {
    var request = ListGroupsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listGroups(request);
  }

  ResponseStream<Action> getActions() {
    var request = ListActionsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listActions(request);
  }

  ResponseStream<EvaluationCategory> getEvaluationCategories() {
    var request = ListEvaluationCategoriesRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listEvaluationCategories(request);
  }

  ResponseStream<CreateUpdateGroupsResponse> createUpdateGroup(
      Stream<CreateUpdateGroupsRequest> request) {
    return client.createUpdateGroups(request);
  }

  ResponseStream<CreateUpdateGroupUsersResponse> createUpdateGroupUser(
      Stream<CreateUpdateGroupUsersRequest> request) {
    return client.createUpdateGroupUsers(request);
  }

  ResponseStream<DeleteGroupUsersResponse> deleteGroupUsers(
      Stream<GroupUser> groupUser) {
    return client.deleteGroupUsers(groupUser);
  }

  ResponseStream<User> getUsers() {
    var request = ListUsersRequest();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    return client.listUsers(request);
  }

  ResponseStream<CreateUpdateUserResponse> createUpdateUsers(
      Stream<CreateUpdateUserRequest> request) {
    return client.createUpdateUsers(request);
  }

  ResponseStream<CreateUpdateActionsResponse>
      createUpdateActions(
          Stream<CreateUpdateActionsRequest> request) {
    return client.createUpdateActions(request);
  }

  ResponseStream<DeleteActionResponse> deleteAction(
      Action action) {
    var request = DeleteActionRequest.create();
    request.actionId = action.id;

    Stream<DeleteActionRequest> streamRequest = Stream.value(request);
    return client.deleteActions(streamRequest);
  }

  ResponseStream<CreateUpdateActionUserResponse>
      createUpdateActionUsers(
          Stream<CreateUpdateActionUserRequest> request) {
    return client.createUpdateActionUsers(request);
  }

  ResponseStream<UploadStatus> uploadFile(
      Stream<FileData> request) {
    return fileTransferClient.upload(request);
  }

  ResponseStream<DownloadResponse> downloadFile(
      Stream<DownloadRequest> request) {
    return fileTransferClient.download(request);
  }

  ResponseStream<CreateUpdateLearnerEvaluationResponse>
      createUpdateLearnerEvaluations(
          Stream<CreateUpdateLearnerEvaluationRequest> request) {
    return client.createUpdateLearnerEvaluations(request);
  }

  ResponseStream<CreateUpdateGroupEvaluationResponse>
      createUpdateGroupEvaluations(
          Stream<CreateUpdateGroupEvaluationRequest> request) {
    return client.createUpdateGroupEvaluations(request);
  }

  ResponseStream<CreateUpdateTransformationResponse>
      createUpdateTransformations(
          Stream<CreateUpdateTransformationRequest> request) {
    return client.createUpdateTransformations(request);
  }

  ResponseStream<CreateUpdateTeacherResponseResponse>
      createUpdateTeacherResponses(
          Stream<CreateUpdateTeacherResponseRequest> request) {
    return client.createUpdateTeacherResponses(request);
  }

  ResponseStream<CreateUpdateOutputResponse> createUpdateOutputs(
      Stream<CreateUpdateOutputRequest> request) {
    return client.createUpdateOutputs(request);
  }

  ResponseStream<LearnerEvaluation> listLearnerEvaluations() {
    var request = ListLearnerEvaluationsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    return client.listLearnerEvaluations(request);
  }

  ResponseStream<TeacherResponse> listTeacherResponses() {
    var request = ListTeacherResponsesRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    return client.listTeacherResponses(request);
  }

  ResponseStream<GroupEvaluation> listGroupEvaluations() {
    var request = ListGroupEvaluationsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    return client.listGroupEvaluations(request);
  }

  ResponseStream<Transformation> listTransformations() {
    var request = ListTransformationsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    return client.listTransformations(request);
  }

  ResponseStream<Output> listOutputs() {
    var request = ListOutputsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    return client.listOutputs(request);
  }
}