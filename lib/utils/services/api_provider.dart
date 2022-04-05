// ignore: import_of_legacy_library_into_null_safe
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/src/generated/file_transfer.pb.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/sync_time.dart';
import 'grpc_client.dart';

class ApiProvider {
  StarfishClient? client;
  FileTransferClient? fileTransferClient;

  Future getGrpcClient() async {
    await Singleton.instance
        .initGprcClient()
        .then((value) => {client = Singleton.instance.client});
  }

  Future getFileTransferClient() async {
    await Singleton.instance.initFileTransferClient().then((value) =>
        {fileTransferClient = Singleton.instance.fileTransferClient});
  }

  Future<AuthenticateResponse> authenticate(
      String jwtToken, String userName) async {
    var request =
        AuthenticateRequest(firebaseJwt: jwtToken, userName: userName);
    if (client == null) {
      await getGrpcClient();
    }
    return client!.authenticate(request);
  }

  Future<AuthenticateResponse> refreshSession(
      String refreshToken, String userId) async {
    var request =
        RefreshSessionRequest(userId: userId, refreshToken: refreshToken);
    if (client == null) {
      await getGrpcClient();
    }
    return client!.refreshSession(request);
  }

  Future<ResponseStream<Country>> listAllCountries() async {
    var request = ListAllCountriesRequest();
    if (client == null) {
      await getGrpcClient();
    }
    return client!.listAllCountries(request);
  }

  Future<ResponseStream<Language>> listAllLanguages() async {
    var request = ListLanguagesRequest();
    if (client == null) {
      await getGrpcClient();
    }
    return client!.listLanguages(request);
  }

  Future<User> getCurrentUser() async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.getCurrentUser(Empty());
  }

  Future<User> updateCurrentUser(User user, List<String> fieldMaskPaths) async {
    var request = UpdateCurrentUserRequest.create();
    request.user = user;

    FieldMask mask = FieldMask(paths: fieldMaskPaths);

    request.updateMask = mask;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.updateCurrentUser(request);
  }

  Future<ResponseStream<Material>> getMateials() async {
    var request = ListMaterialsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listMaterials(request);
  }

  Future<ResponseStream<MaterialTopic>> getMateialTopics() async {
    var request = ListMaterialTopicsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }
    if (client == null) {
      await getGrpcClient();
    }
    return client!.listMaterialTopics(request);
  }

  Future<ResponseStream<MaterialType>> getMateialTypes() async {
    var request = ListMaterialTypesRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listMaterialTypes(request);
  }

  Future<ResponseStream<CreateUpdateMaterialsResponse>> createUpdateMaterial(
      Stream<CreateUpdateMaterialsRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateMaterials(request);
  }

  Future<ResponseStream<DeleteMaterialResponse>> deleteMaterials(
      Stream<DeleteMaterialRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.deleteMaterials(request);
  }

  Future<ResponseStream<Group>> getGroups() async {
    var request = ListGroupsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listGroups(request);
  }

  Future<ResponseStream<Action>> getActions() async {
    var request = ListActionsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listActions(request);
  }

  Future<ResponseStream<EvaluationCategory>> getEvaluationCategories() async {
    var request = ListEvaluationCategoriesRequest.create();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listEvaluationCategories(request);
  }

  Future<ResponseStream<CreateUpdateGroupsResponse>> createUpdateGroup(
      Stream<CreateUpdateGroupsRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateGroups(request);
  }

  Future<ResponseStream<CreateUpdateGroupUsersResponse>> createUpdateGroupUser(
      Stream<CreateUpdateGroupUsersRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateGroupUsers(request);
  }

  Future<ResponseStream<DeleteGroupUsersResponse>> deleteGroupUsers(
      Stream<GroupUser> groupUser) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.deleteGroupUsers(groupUser);
  }

  Future<ResponseStream<User>> getUsers() async {
    var request = ListUsersRequest();
    Date? date = SyncTime().lastSyncDateTime();
    if (date != null) {
      request.updatedSince = date;
    }

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listUsers(request);
  }

  Future<ResponseStream<CreateUpdateUserResponse>> createUpdateUsersWithStream(
      Stream<CreateUpdateUserRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateUsers(request);
  }

  Future<ResponseStream<CreateUpdateActionsResponse>>
      createUpdateActionWithStream(
          Stream<CreateUpdateActionsRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateActions(request);
  }

  Future<ResponseStream<DeleteActionResponse>> deleteAction(
      Action action) async {
    var request = DeleteActionRequest.create();
    request.actionId = action.id;

    Stream<DeleteActionRequest> streamRequest = Stream.value(request);
    if (client == null) {
      await getGrpcClient();
    }
    return client!.deleteActions(streamRequest);
  }

  Future<ResponseStream<CreateUpdateActionUserResponse>>
      createUpdateActionUsers(
          Stream<CreateUpdateActionUserRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateActionUsers(request);
  }

  Future<ResponseStream<UploadStatus>> uploadFile(
      Stream<FileData> request) async {
    if (fileTransferClient == null) {
      await getFileTransferClient();
    }

    return fileTransferClient!.upload(request);
  }

  Future<ResponseStream<FileData>> downloadFile(
      Stream<DownloadRequest> request) async {
    if (fileTransferClient == null) {
      await getFileTransferClient();
    }

    return fileTransferClient!.download(request);
  }

  Future<ResponseStream<CreateUpdateLearnerEvaluationResponse>>
      createUpdateLearnerEvaluations(
          Stream<CreateUpdateLearnerEvaluationRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateLearnerEvaluations(request);
  }

  Future<ResponseStream<CreateUpdateTeacherResponseResponse>>
      createUpdateTeacherResponses(
          Stream<CreateUpdateTeacherResponseRequest> request) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateTeacherResponses(request);
  }

  Future<ResponseStream<LearnerEvaluation>> listLearnerEvaluations() async {
    var request = ListLearnerEvaluationsRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    if (client == null) {
      await getGrpcClient();
    }
    return client!.listLearnerEvaluations(request);
  }

  Future<ResponseStream<TeacherResponse>> listTeacherResponses() async {
    var request = ListTeacherResponsesRequest.create();
    Date? date = SyncTime().lastSyncDateTime();

    if (date != null) {
      request.updatedSince = date;
    }
    if (client == null) {
      await getGrpcClient();
    }
    return client!.listTeacherResponses(request);
  }
}
