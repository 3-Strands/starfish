import 'package:grpc/grpc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:starfish/src/generated/google/protobuf/empty.pb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'cross_grpc.dart';
import 'src/generated/starfish.pbgrpc.dart';

class MobileGrpc implements CrossGrpc {
  @override
  Future<String> doRemoteCall() async {
    final channel = ClientChannel('https://sandbox-api.everylanguage.app');
    final client = StarfishClient(channel,
        options: CallOptions(metadata: {
          'authorization': '4952564404',
          'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
        }));

    return (await client.getCurrentUser(Empty())).name;
  }
}

CrossGrpc getGrpc() => MobileGrpc();
