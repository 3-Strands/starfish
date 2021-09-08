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
  static final _$listAllCountries =
      $grpc.ClientMethod<$1.ListAllCountriesRequest, $1.Country>(
          '/sil.starfish.Starfish/ListAllCountries',
          ($1.ListAllCountriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Country.fromBuffer(value));
  static final _$listLanguages =
      $grpc.ClientMethod<$1.ListLanguagesRequest, $1.Language>(
          '/sil.starfish.Starfish/ListLanguages',
          ($1.ListLanguagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Language.fromBuffer(value));
  static final _$listMaterials =
      $grpc.ClientMethod<$1.ListMaterialsRequest, $1.Material>(
          '/sil.starfish.Starfish/ListMaterials',
          ($1.ListMaterialsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Material.fromBuffer(value));
  static final _$createUpdateMaterials = $grpc.ClientMethod<
          $1.CreateUpdateMaterialsRequest, $1.CreateUpdateMaterialsResponse>(
      '/sil.starfish.Starfish/CreateUpdateMaterials',
      ($1.CreateUpdateMaterialsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateUpdateMaterialsResponse.fromBuffer(value));
  static final _$listMaterialTypes =
      $grpc.ClientMethod<$1.ListMaterialTypesRequest, $1.MaterialType>(
          '/sil.starfish.Starfish/ListMaterialTypes',
          ($1.ListMaterialTypesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.MaterialType.fromBuffer(value));
  static final _$listMaterialTopics =
      $grpc.ClientMethod<$1.ListMaterialTopicsRequest, $1.MaterialTopic>(
          '/sil.starfish.Starfish/ListMaterialTopics',
          ($1.ListMaterialTopicsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.MaterialTopic.fromBuffer(value));
  static final _$createMaterialFeedbacks = $grpc.ClientMethod<
          $1.CreateMaterialFeedbacksRequest,
          $1.CreateMaterialFeedbacksResponse>(
      '/sil.starfish.Starfish/CreateMaterialFeedbacks',
      ($1.CreateMaterialFeedbacksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $1.CreateMaterialFeedbacksResponse.fromBuffer(value));

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

  $grpc.ResponseStream<$1.Country> listAllCountries(
      $1.ListAllCountriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listAllCountries, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.Language> listLanguages(
      $1.ListLanguagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listLanguages, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.Material> listMaterials(
      $1.ListMaterialsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listMaterials, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.CreateUpdateMaterialsResponse> createUpdateMaterials(
      $async.Stream<$1.CreateUpdateMaterialsRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateMaterials, request,
        options: options);
  }

  $grpc.ResponseStream<$1.MaterialType> listMaterialTypes(
      $1.ListMaterialTypesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listMaterialTypes, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.MaterialTopic> listMaterialTopics(
      $1.ListMaterialTopicsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listMaterialTopics, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$1.CreateMaterialFeedbacksResponse>
      createMaterialFeedbacks(
          $async.Stream<$1.CreateMaterialFeedbacksRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createMaterialFeedbacks, request,
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
    $addMethod($grpc.ServiceMethod<$1.ListAllCountriesRequest, $1.Country>(
        'ListAllCountries',
        listAllCountries_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $1.ListAllCountriesRequest.fromBuffer(value),
        ($1.Country value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListLanguagesRequest, $1.Language>(
        'ListLanguages',
        listLanguages_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $1.ListLanguagesRequest.fromBuffer(value),
        ($1.Language value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListMaterialsRequest, $1.Material>(
        'ListMaterials',
        listMaterials_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $1.ListMaterialsRequest.fromBuffer(value),
        ($1.Material value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateUpdateMaterialsRequest,
            $1.CreateUpdateMaterialsResponse>(
        'CreateUpdateMaterials',
        createUpdateMaterials,
        true,
        true,
        ($core.List<$core.int> value) =>
            $1.CreateUpdateMaterialsRequest.fromBuffer(value),
        ($1.CreateUpdateMaterialsResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.ListMaterialTypesRequest, $1.MaterialType>(
            'ListMaterialTypes',
            listMaterialTypes_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $1.ListMaterialTypesRequest.fromBuffer(value),
            ($1.MaterialType value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$1.ListMaterialTopicsRequest, $1.MaterialTopic>(
            'ListMaterialTopics',
            listMaterialTopics_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $1.ListMaterialTopicsRequest.fromBuffer(value),
            ($1.MaterialTopic value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CreateMaterialFeedbacksRequest,
            $1.CreateMaterialFeedbacksResponse>(
        'CreateMaterialFeedbacks',
        createMaterialFeedbacks,
        true,
        true,
        ($core.List<$core.int> value) =>
            $1.CreateMaterialFeedbacksRequest.fromBuffer(value),
        ($1.CreateMaterialFeedbacksResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.User> getCurrentUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getCurrentUser(call, await request);
  }

  $async.Future<$1.User> updateCurrentUser_Pre($grpc.ServiceCall call,
      $async.Future<$1.UpdateCurrentUserRequest> request) async {
    return updateCurrentUser(call, await request);
  }

  $async.Stream<$1.Country> listAllCountries_Pre($grpc.ServiceCall call,
      $async.Future<$1.ListAllCountriesRequest> request) async* {
    yield* listAllCountries(call, await request);
  }

  $async.Stream<$1.Language> listLanguages_Pre($grpc.ServiceCall call,
      $async.Future<$1.ListLanguagesRequest> request) async* {
    yield* listLanguages(call, await request);
  }

  $async.Stream<$1.Material> listMaterials_Pre($grpc.ServiceCall call,
      $async.Future<$1.ListMaterialsRequest> request) async* {
    yield* listMaterials(call, await request);
  }

  $async.Stream<$1.MaterialType> listMaterialTypes_Pre($grpc.ServiceCall call,
      $async.Future<$1.ListMaterialTypesRequest> request) async* {
    yield* listMaterialTypes(call, await request);
  }

  $async.Stream<$1.MaterialTopic> listMaterialTopics_Pre($grpc.ServiceCall call,
      $async.Future<$1.ListMaterialTopicsRequest> request) async* {
    yield* listMaterialTopics(call, await request);
  }

  $async.Future<$1.User> getCurrentUser(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$1.User> updateCurrentUser(
      $grpc.ServiceCall call, $1.UpdateCurrentUserRequest request);
  $async.Stream<$1.Country> listAllCountries(
      $grpc.ServiceCall call, $1.ListAllCountriesRequest request);
  $async.Stream<$1.Language> listLanguages(
      $grpc.ServiceCall call, $1.ListLanguagesRequest request);
  $async.Stream<$1.Material> listMaterials(
      $grpc.ServiceCall call, $1.ListMaterialsRequest request);
  $async.Stream<$1.CreateUpdateMaterialsResponse> createUpdateMaterials(
      $grpc.ServiceCall call,
      $async.Stream<$1.CreateUpdateMaterialsRequest> request);
  $async.Stream<$1.MaterialType> listMaterialTypes(
      $grpc.ServiceCall call, $1.ListMaterialTypesRequest request);
  $async.Stream<$1.MaterialTopic> listMaterialTopics(
      $grpc.ServiceCall call, $1.ListMaterialTopicsRequest request);
  $async.Stream<$1.CreateMaterialFeedbacksResponse> createMaterialFeedbacks(
      $grpc.ServiceCall call,
      $async.Stream<$1.CreateMaterialFeedbacksRequest> request);
}
