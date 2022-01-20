import 'package:flutter/material.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:starfish/config/app_config.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';
import 'package:starfish/utils/services/local_storage_service.dart';

class Singleton {
  static Singleton? _instance;
  StarfishClient? client;
  FileTransferClient? fileTransferClient;

  Singleton._();

  static Singleton get instance => _instance ??= Singleton._();

  final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: FlavorConfig.instance!.values.baseUrl,
      port: 443,
      transportSecure: true);

  Future<Map<String, String>> initMetaData() async {
    String token = await StarfishSharedPreference().getAccessToken();

    Map<String, String>? metadata;
    if (token.isEmpty) {
      metadata = {
        'authorization': '',
        'x-api-key': FlavorConfig.instance!.values.apiKey
      };
    } else {
      metadata = {
        'authorization': token,
        'x-api-key': FlavorConfig.instance!.values.apiKey
      };
    }
    return metadata;
  }

  Future initGprcClient() async {
    /* 
      debugPrint("FlavorConfig.instance!.values.baseUrl ==>>");
      debugPrint(FlavorConfig.instance!.values.baseUrl);
      debugPrint(FlavorConfig.instance!.values.apiKey);
     */

    client = StarfishClient(
      channel,
      options: CallOptions(metadata: await initMetaData()),
    );
  }

  Future initFileTransferClient() async {
    fileTransferClient = FileTransferClient(
      channel,
      options: CallOptions(metadata: await initMetaData()),
    );
  }
}
