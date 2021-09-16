// ignore: import_of_legacy_library_into_null_safe
import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/google/type/date.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'grpc_client.dart';

class ApiProvider {
  StarfishClient? client;

  ApiProvider() {
    client = GrpcClient().client!;
  }

  Future<ResponseStream<Country>> listAllCountries() async {
    var request = ListAllCountriesRequest();
    return client!.listAllCountries(request);
  }

  Future<ResponseStream<Language>> listAllLanguages() async {
    var request = ListLanguagesRequest();
    return client!.listLanguages(request);
  }

  Future<User> getCurrentUser() async {
    return client!.getCurrentUser(Empty());
  }

  Future<User> updateCurrentUser(
      String id,
      String? name,
      String? phone,
      Iterable<String>? countryIds,
      Iterable<String>? languageIds,
      bool? linkGroups,
      List<String> fieldMaskPaths) async {
    ActionTab actionTab = ActionTab.ACTIONS_UNSPECIFIED;
    ResultsTab resultsTab = ResultsTab.RESULTS_UNSPECIFIED;

    User user = User(
        id: id,
        name: name ?? '',
        phone: phone ?? '',
        countryIds: countryIds ?? [],
        languageIds: languageIds ?? [],
        linkGroups: linkGroups ?? false,
        selectedActionsTab: actionTab,
        selectedResultsTab: resultsTab,
        phoneCountryId: '',
        diallingCode: '');

    var request = UpdateCurrentUserRequest.create();
    request.user = user;

    // var paths = ['name', 'phone', 'countryIds', 'languageIds', 'linkGroups'];
    FieldMask mask = FieldMask(paths: fieldMaskPaths);

    request.updateMask = mask;

    return client!.updateCurrentUser(request);
  }

  Future<ResponseStream<Material>> getMateials() async {
    var request = ListMaterialsRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    request.updatedSince = date;
    return client!.listMaterials(request);
  }

  Future<ResponseStream<MaterialTopic>> getMateialTopics() async {
    var request = ListMaterialTopicsRequest.create();
    Date date = Date(year: 2020, month: 1, day: 1);
    request.updatedSince = date;
    return client!.listMaterialTopics(request);
  }
}
