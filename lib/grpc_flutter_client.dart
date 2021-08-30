import 'package:grpc/grpc.dart';

class GrpcFlutterClient {
  late ClientChannel client;
  static final GrpcFlutterClient _singleton = new GrpcFlutterClient._internal();
  factory GrpcFlutterClient() => _singleton;
  GrpcFlutterClient._internal() {
    client = ClientChannel(
      "",// i.e 192.168.31.74
      port: 443,
      options: ChannelOptions(
        //Change to secure with server certificates
        credentials: ChannelCredentials.insecure(),
        idleTimeout: Duration(minutes: 1),
      ),
    );
  }
}
