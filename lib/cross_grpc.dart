library cross_grpc;

import 'cross_grpc_stub.dart'
    if (dart.library.io) 'mobile_grpc.dart'
    if (dart.library.html) 'web_grpc.dart';

abstract class CrossGrpc {
  Future<String> doRemoteCall();

  factory CrossGrpc() => getGrpc();
}
