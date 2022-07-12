import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

class CurrentUserRepository {
  final StarfishClient client;

  CurrentUserRepository({
    required this.client,
  });

  Future<User> getCurrentUser() {
    return client.getCurrentUser(Empty());
  }
}
