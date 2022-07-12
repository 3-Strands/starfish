import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

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

  ResponseStream<Material> getMaterials({Date? updatedSince}) {
    var request = ListMaterialsRequest(updatedSince: updatedSince);
    return client.listMaterials(request);
  }

  ResponseStream<MaterialTopic> getMaterialTopics({Date? updatedSince}) {
    var request = ListMaterialTopicsRequest(updatedSince: updatedSince);
    return client.listMaterialTopics(request);
  }

  ResponseStream<MaterialType> getMaterialTypes({Date? updatedSince}) {
    var request = ListMaterialTypesRequest(updatedSince: updatedSince);
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

  ResponseStream<Group> getGroups({Date? updatedSince}) {
    var request = ListGroupsRequest(updatedSince: updatedSince);
    return client.listGroups(request);
  }

  ResponseStream<Action> getActions({Date? updatedSince}) {
    var request = ListActionsRequest(updatedSince: updatedSince);
    return client.listActions(request);
  }

  ResponseStream<EvaluationCategory> getEvaluationCategories({Date? updatedSince}) {
    var request = ListEvaluationCategoriesRequest(updatedSince: updatedSince);
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

  ResponseStream<User> getUsers({Date? updatedSince}) {
    var request = ListUsersRequest(updatedSince: updatedSince);
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

  ResponseStream<LearnerEvaluation> listLearnerEvaluations({Date? updatedSince}) {
    var request = ListLearnerEvaluationsRequest(updatedSince: updatedSince);
    return client.listLearnerEvaluations(request);
  }

  ResponseStream<TeacherResponse> listTeacherResponses({Date? updatedSince}) {
    var request = ListTeacherResponsesRequest(updatedSince: updatedSince);
    return client.listTeacherResponses(request);
  }

  ResponseStream<GroupEvaluation> listGroupEvaluations({Date? updatedSince}) {
    var request = ListGroupEvaluationsRequest(updatedSince: updatedSince);
    return client.listGroupEvaluations(request);
  }

  ResponseStream<Transformation> listTransformations({Date? updatedSince}) {
    var request = ListTransformationsRequest(updatedSince: updatedSince);
    return client.listTransformations(request);
  }

  ResponseStream<Output> listOutputs({Date? updatedSince}) {
    var request = ListOutputsRequest(updatedSince: updatedSince);
    return client.listOutputs(request);
  }
}