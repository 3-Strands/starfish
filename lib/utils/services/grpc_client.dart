import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/config/app_config.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/local_storage_service.dart';

final _channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
    host: FlavorConfig.instance!.values.baseUrl,
    port: 443,
    transportSecure: true);

CallOptions _makeCallOptions([String? token]) =>
  CallOptions(
    metadata: {
      if (token != null) 'authentication': token,
      'x-api-key': FlavorConfig.instance!.values.apiKey
    },
  );

StarfishClient makeUnauthenticatedClient() =>
  StarfishClient(
    _channel,
    options: _makeCallOptions(),
  );

StarfishClient makeAuthenticatedClient(String token) =>
  StarfishClient(
    _channel,
    options: _makeCallOptions(token),
  );

FileTransferClient makeUnauthenticatedFileTransferClient() =>
  FileTransferClient(
    _channel,
    options: _makeCallOptions(),
  );

FileTransferClient makeAuthenticatedFileTransferClient(String token) =>
  FileTransferClient(
    _channel,
    options: _makeCallOptions(token),
  );
