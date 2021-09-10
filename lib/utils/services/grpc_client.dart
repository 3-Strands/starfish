import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

class GrpcClient {
  StarfishClient? client;

  GrpcClient() {
    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
        host: "sandbox-api.everylanguage.app",
        port: 443,
        transportSecure: true);
    client = StarfishClient(
      channel,
      options: CallOptions(
        metadata: {
          'authorization': '4952564404',
          'x-api-key': 'AIzaSyCRxikcHzD0PrDAqG797MQyctEwBSIf5t0'
        },
      ),
    );
  }
}
