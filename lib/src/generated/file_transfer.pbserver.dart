///
//  Generated code. Do not modify.
//  source: file_transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'file_transfer.pb.dart' as $0;
import 'file_transfer.pbjson.dart';

export 'file_transfer.pb.dart';

abstract class FileTransferServiceBase extends $pb.GeneratedService {
  $async.Future<$0.UploadStatus> upload($pb.ServerContext ctx, $0.FileData request);
  $async.Future<$0.DownloadResponse> download($pb.ServerContext ctx, $0.DownloadRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'Upload': return $0.FileData();
      case 'Download': return $0.DownloadRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'Upload': return this.upload(ctx, request as $0.FileData);
      case 'Download': return this.download(ctx, request as $0.DownloadRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => FileTransferServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => FileTransferServiceBase$messageJson;
}

