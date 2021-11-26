// ignore: import_of_legacy_library_into_null_safe
import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'grpc_client.dart';

class ApiProvider {
  StarfishClient? client;

  // ApiProvider() {
  //   client = GrpcClient().client!;
  // }

  Future getGrpcClient() async {
    // print("getting client ==>>");
    await Singleton.instance
        .initGprcClient()
        .then((value) => {client = Singleton.instance.client});
    /*
    var grpc = GrpcClient();
    await grpc.init().then((value) => {client = grpc.client});
    */
    // print("received client ==>> $client");
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
    ActionTab actionTab = ActionTab.ACTIONS_UNSPECIFIED;
    ResultsTab resultsTab = ResultsTab.RESULTS_UNSPECIFIED;

    /*User user = User(
        id: id,
        name: name ?? '',
        phone: phone ?? '',
        countryIds: List.from(countryIds!),
        languageIds: List.from(languageIds!),
        //linkGroups: linkGroups ?? false,
        selectedActionsTab: actionTab,
        selectedResultsTab: resultsTab,
        phoneCountryId: '',
        diallingCode: '');*/

    var request = UpdateCurrentUserRequest.create();
    request.user = user;

    // var paths = ['name', 'phone', 'countryIds', 'languageIds', 'linkGroups'];
    FieldMask mask = FieldMask(paths: fieldMaskPaths);

    request.updateMask = mask;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.updateCurrentUser(request);
  }

  Future<ResponseStream<Material>> getMateials() async {
    var request = ListMaterialsRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    request.updatedSince = date;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listMaterials(request);
  }

  Future<ResponseStream<MaterialTopic>> getMateialTopics() async {
    var request = ListMaterialTopicsRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    request.updatedSince = date;
    if (client == null) {
      await getGrpcClient();
    }
    return client!.listMaterialTopics(request);
  }

  Future<ResponseStream<MaterialType>> getMateialTypes() async {
    var request = ListMaterialTypesRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    request.updatedSince = date;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listMaterialTypes(request);
  }

  Future<ResponseStream<CreateUpdateMaterialsResponse>> createUpdateMaterial(
    Material material,
    List<String> fieldMaskPaths,
  ) async {
    var request = CreateUpdateMaterialsRequest.create();
    request.material = material;

    FieldMask mask = FieldMask(paths: fieldMaskPaths);
    request.updateMask = mask;

    Stream<CreateUpdateMaterialsRequest> streamRequest = Stream.value(request);

    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateMaterials(streamRequest);
  }

  Future<ResponseStream<Group>> getGroups() async {
    var request = ListGroupsRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    //request.updatedSince = date;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listGroups(request);
  }

  Future<ResponseStream<Action>> getActions() async {
    var request = ListActionsRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    //request.updatedSince = date;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listActions(request);
  }

  Future<ResponseStream<EvaluationCategory>> getEvaluationCategories() async {
    var request = ListEvaluationCategoriesRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    //request.updatedSince = date;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listEvaluationCategories(request);
  }

  Future<CreateUpdateGroupsResponse> createUpdateGroup(
    Group group,
    List<String> fieldMaskPaths,
  ) async {
    var request = CreateUpdateGroupsRequest.create();
    request.group = group;

    FieldMask mask = FieldMask(paths: fieldMaskPaths);
    request.updateMask = mask;

    Stream<CreateUpdateGroupsRequest> streamRequest = Stream.value(request);

    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateGroups(streamRequest).first;
  }

  Future<CreateUpdateGroupUsersResponse> createUpdateGroupUser(
      GroupUser groupUser, List<String> fieldMaskPaths) async {
    var request = CreateUpdateGroupUsersRequest();
    request.groupUser = groupUser;

    FieldMask mask = FieldMask(paths: fieldMaskPaths);
    request.updateMask = mask;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateGroupUsers(Stream.value(request)).first;
  }

  Future<ResponseStream<DeleteGroupUsersResponse>> deleteGroupUsers(
      GroupUser groupUser) async {
    if (client == null) {
      await getGrpcClient();
    }
    return client!.deleteGroupUsers(Stream.value(groupUser));
  }

  Future<ResponseStream<User>> getUsers() async {
    var request = ListUsersRequest();

    if (client == null) {
      await getGrpcClient();
    }
    return client!.listUsers(request);
  }

  Future<CreateUpdateUserResponse> createUpdateUsers(
      User user, List<String> fieldMaskPaths) async {
    var request = CreateUpdateUserRequest.create();
    request.user = user;

    FieldMask mask = FieldMask(paths: fieldMaskPaths);
    request.updateMask = mask;

    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateUsers(Stream.value(request)).first;
  }

  Future<ResponseStream<CreateUpdateActionsResponse>> createUpdateAction(
    Action action,
    List<String> fieldMaskPaths,
  ) async {
    var request = CreateUpdateActionsRequest.create();
    request.action = action;

    FieldMask mask = FieldMask(paths: fieldMaskPaths);
    request.updateMask = mask;

    Stream<CreateUpdateActionsRequest> streamRequest = Stream.value(request);

    if (client == null) {
      await getGrpcClient();
    }
    return client!.createUpdateActions(streamRequest);
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
}
