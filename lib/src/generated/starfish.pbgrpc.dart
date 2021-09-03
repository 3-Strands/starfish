///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'google/protobuf/empty.pb.dart' as $0;
import 'starfish.pb.dart' as $1;
export 'starfish.pb.dart';

class StarfishClient extends $grpc.Client {
  static final _$getCurrentUser = $grpc.ClientMethod<$0.Empty, $1.User>(
      '/sil.starfish.Starfish/GetCurrentUser',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$updateCurrentUser =
      $grpc.ClientMethod<$1.UpdateCurrentUserRequest, $1.User>(
          '/sil.starfish.Starfish/UpdateCurrentUser',
          ($1.UpdateCurrentUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.User.fromBuffer(value));
  static final _$listAllCountries = $grpc.ClientMethod<$0.Empty, $1.Country>(
      '/sil.starfish.Starfish/ListAllCountries',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Country.fromBuffer(value));
  static final _$listLanguages = $grpc.ClientMethod<$0.Empty, $1.Language>(
      '/sil.starfish.Starfish/ListLanguages',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Language.fromBuffer(value));

  StarfishClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.User> getCurrentUser($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentUser, request, options: options);
  }

  $grpc.ResponseFuture<$1.User> updateCurrentUser(
      $1.UpdateCurrentUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCurrentUser, request, options: options);
  }

  $grpc.ResponseStream<$1.Country> listAllCountries($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listAllCountries, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.Language> listLanguages($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listLanguages, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class StarfishServiceBase extends $grpc.Service {
  $core.String get $name => 'sil.starfish.Starfish';

  StarfishServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.User>(
        'GetCurrentUser',
        getCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UpdateCurrentUserRequest, $1.User>(
        'UpdateCurrentUser',
        updateCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $1.UpdateCurrentUserRequest.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.Country>(
        'ListAllCountries',
        listAllCountries_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.Country value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $1.Language>(
        'ListLanguages',
        listLanguages_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($1.Language value) => value.writeToBuffer()));
  }

  $async.Future<$1.User> getCurrentUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getCurrentUser(call, await request);
  }

  $async.Future<$1.User> updateCurrentUser_Pre($grpc.ServiceCall call,
      $async.Future<$1.UpdateCurrentUserRequest> request) async {
    return updateCurrentUser(call, await request);
  }

  $async.Stream<$1.Country> listAllCountries_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* listAllCountries(call, await request);
  }

  $async.Stream<$1.Language> listLanguages_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* listLanguages(call, await request);
  }

  $async.Future<$1.User> getCurrentUser(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.User> updateCurrentUser(
      $grpc.ServiceCall call, $1.UpdateCurrentUserRequest request);
  $async.Stream<$1.Country> listAllCountries(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$1.Language> listLanguages(
      $grpc.ServiceCall call, $0.Empty request);
}
