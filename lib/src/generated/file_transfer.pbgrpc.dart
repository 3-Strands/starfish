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
  static final _$uploadWeb =
      $grpc.ClientMethod<$0.FileDataWrapper, $0.UploadStatusWrapper>(
          '/sil.starfish.FileTransfer/UploadWeb',
          ($0.FileDataWrapper value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.UploadStatusWrapper.fromBuffer(value));
  static final _$download =
      $grpc.ClientMethod<$0.DownloadRequest, $0.DownloadResponse>(
          '/sil.starfish.FileTransfer/Download',
          ($0.DownloadRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DownloadResponse.fromBuffer(value));
  static final _$downloadWeb =
      $grpc.ClientMethod<$0.DownloadRequestWrapper, $0.DownloadResponseWrapper>(
          '/sil.starfish.FileTransfer/DownloadWeb',
          ($0.DownloadRequestWrapper value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DownloadResponseWrapper.fromBuffer(value));

  FileTransferClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.UploadStatus> upload(
      $async.Stream<$0.FileData> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$upload, request, options: options);
  }

  $grpc.ResponseFuture<$0.UploadStatusWrapper> uploadWeb(
      $0.FileDataWrapper request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$uploadWeb, request, options: options);
  }

  $grpc.ResponseStream<$0.DownloadResponse> download(
      $async.Stream<$0.DownloadRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$download, request, options: options);
  }

  $grpc.ResponseFuture<$0.DownloadResponseWrapper> downloadWeb(
      $0.DownloadRequestWrapper request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$downloadWeb, request, options: options);
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
    $addMethod($grpc.ServiceMethod<$0.FileDataWrapper, $0.UploadStatusWrapper>(
        'UploadWeb',
        uploadWeb_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.FileDataWrapper.fromBuffer(value),
        ($0.UploadStatusWrapper value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadRequest, $0.DownloadResponse>(
        'Download',
        download,
        true,
        true,
        ($core.List<$core.int> value) => $0.DownloadRequest.fromBuffer(value),
        ($0.DownloadResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadRequestWrapper,
            $0.DownloadResponseWrapper>(
        'DownloadWeb',
        downloadWeb_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.DownloadRequestWrapper.fromBuffer(value),
        ($0.DownloadResponseWrapper value) => value.writeToBuffer()));
  }

  $async.Future<$0.UploadStatusWrapper> uploadWeb_Pre(
      $grpc.ServiceCall call, $async.Future<$0.FileDataWrapper> request) async {
    return uploadWeb(call, await request);
  }

  $async.Future<$0.DownloadResponseWrapper> downloadWeb_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.DownloadRequestWrapper> request) async {
    return downloadWeb(call, await request);
  }

  $async.Stream<$0.UploadStatus> upload(
      $grpc.ServiceCall call, $async.Stream<$0.FileData> request);
  $async.Future<$0.UploadStatusWrapper> uploadWeb(
      $grpc.ServiceCall call, $0.FileDataWrapper request);
  $async.Stream<$0.DownloadResponse> download(
      $grpc.ServiceCall call, $async.Stream<$0.DownloadRequest> request);
  $async.Future<$0.DownloadResponseWrapper> downloadWeb(
      $grpc.ServiceCall call, $0.DownloadRequestWrapper request);
}
