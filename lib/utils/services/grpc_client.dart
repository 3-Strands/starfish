import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/local_storage_service.dart';

/*
class GrpcClient {
  StarfishClient? client;

  Future init() async {
    String token = await StarfishSharedPreference().getAccessToken();
    print("token ==>> $token");

    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "sandbox-api.everylanguage.app",
        port: 443,
        transportSecure: true);
    client = StarfishClient(
      channel,
      options: CallOptions(
        metadata: {
          'authorization': '$token',
          'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
        },
      ),
    );
  }

  // GrpcClient() {
  //   final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
  //       host: "sandbox-api.everylanguage.app",
  //       port: 443,
  //       transportSecure: true);
  //   client = StarfishClient(
  //     channel,
  //     options: CallOptions(
  //       metadata: {
  //         'authorization': '8638302141',
  //         'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
  //       },
  //     ),
  //   );
  // }
}
*/

class Singleton {
  static Singleton? _instance;
  StarfishClient? client;

  Singleton._();

  static Singleton get instance => _instance ??= Singleton._();

  Future initGprcClient() async {
    String token = await StarfishSharedPreference().getAccessToken();

    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "sandbox-api.everylanguage.app",
        port: 443,
        transportSecure: true);
    client = StarfishClient(
      channel,
      options: CallOptions(
        metadata: {
          'authorization': '$token',
          'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
        },
      ),
    );
  }
}
