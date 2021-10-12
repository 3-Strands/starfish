import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/local_storage_service.dart';

class GrpcClient {
  StarfishClient? client;
  String? token;

  GrpcClient() {
    getAccessToken();

    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "sandbox-api.everylanguage.app",
        port: 443,
        transportSecure: true);
    client = StarfishClient(
      channel,
      options: CallOptions(
        metadata: {
          'authorization': token ?? '',
          'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
        },
      ),
    );
  }

  getAccessToken() async {
    await StarfishSharedPreference()
        .getAccessToken()
        .then((value) => token = value);
  }
}
