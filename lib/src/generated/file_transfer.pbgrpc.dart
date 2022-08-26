///
//  Generated code. Do not modify.
//  source: file_transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'file_transfer.pb.dart' as $0;
export 'file_transfer.pb.dart';

class FileTransferClient extends $grpc.Client {
  static final _$upload = $grpc.ClientMethod<$0.FileData, $0.UploadStatus>(
      '/sil.starfish.FileTransfer/Upload',
      ($0.FileData value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UploadStatus.fromBuffer(value));
  static final _$download =
      $grpc.ClientMethod<$0.DownloadRequest, $0.DownloadResponse>(
          '/sil.starfish.FileTransfer/Download',
          ($0.DownloadRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DownloadResponse.fromBuffer(value));

  FileTransferClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.UploadStatus> upload(
      $async.Stream<$0.FileData> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$upload, request, options: options);
  }

  $grpc.ResponseStream<$0.DownloadResponse> download(
      $async.Stream<$0.DownloadRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$download, request, options: options);
  }
}

abstract class FileTransferServiceBase extends $grpc.Service {
  $core.String get $name => 'sil.starfish.FileTransfer';

  FileTransferServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.FileData, $0.UploadStatus>(
        'Upload',
        upload,
        true,
        true,
        ($core.List<$core.int> value) => $0.FileData.fromBuffer(value),
        ($0.UploadStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadRequest, $0.DownloadResponse>(
        'Download',
        download,
        true,
        true,
        ($core.List<$core.int> value) => $0.DownloadRequest.fromBuffer(value),
        ($0.DownloadResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.UploadStatus> upload(
      $grpc.ServiceCall call, $async.Stream<$0.FileData> request);
  $async.Stream<$0.DownloadResponse> download(
      $grpc.ServiceCall call, $async.Stream<$0.DownloadRequest> request);
}
