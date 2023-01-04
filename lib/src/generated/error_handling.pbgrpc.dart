///
//  Generated code. Do not modify.
//  source: error_handling.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'error_handling.pb.dart' as $0;
export 'error_handling.pb.dart';

class ErrorHandlingClient extends $grpc.Client {
  static final _$reportError =
      $grpc.ClientMethod<$0.Error, $0.ReportErrorResponse>(
          '/sil.starfish.ErrorHandling/ReportError',
          ($0.Error value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ReportErrorResponse.fromBuffer(value));

  ErrorHandlingClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.ReportErrorResponse> reportError($0.Error request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$reportError, request, options: options);
  }
}

abstract class ErrorHandlingServiceBase extends $grpc.Service {
  $core.String get $name => 'sil.starfish.ErrorHandling';

  ErrorHandlingServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Error, $0.ReportErrorResponse>(
        'ReportError',
        reportError_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Error.fromBuffer(value),
        ($0.ReportErrorResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ReportErrorResponse> reportError_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Error> request) async {
    return reportError(call, await request);
  }

  $async.Future<$0.ReportErrorResponse> reportError(
      $grpc.ServiceCall call, $0.Error request);
}
