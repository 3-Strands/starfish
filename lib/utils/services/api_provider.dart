// ignore: import_of_legacy_library_into_null_safe
import 'package:grpc/grpc.dart';
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'grpc_client.dart';

class ApiProvider {
  StarfishClient? client;

  ApiProvider() {
    client = GrpcClient().client!;
  }

  Future<User> getCurrentUser() async {
    return client!.getCurrentUser(Empty());
  }

  Future<User> updateCurrentUser() async {
    var request = UpdateCurrentUserRequest.create();
    request.user.id = 'db5ddb85-e2c5-4239-897d-5080a0ce513e';
    request.user.name = 'caleb';
    request.user.phone = '4952564404';

    request.updateMask = 'name' as FieldMask;
    return client!.updateCurrentUser(request);
  }

  Future<ResponseStream<Country>> listAllCountries() async {
    return client!.listAllCountries(Empty());
  }

  Future<ResponseStream<Language>> listAllLanguages() async {
    return client!.listLanguages(Empty());
  }
}
