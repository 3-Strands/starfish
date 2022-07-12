import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/google/protobuf/field_mask.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

class GrpcCurrentUserApi {
  final StarfishClient client;

  GrpcCurrentUserApi({
    required this.client,
  });

  Future<User> getCurrentUser() {
    return client.getCurrentUser(Empty());
  }

  Future<User> updateCurrentUser(User user, List<String> fieldMaskPaths) {
    var request = UpdateCurrentUserRequest.create();
    request.user = user;

    request.updateMask = FieldMask(paths: fieldMaskPaths);

    return client.updateCurrentUser(request);
  }
}
