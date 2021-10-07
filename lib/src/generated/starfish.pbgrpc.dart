///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'starfish.pb.dart' as $0;
import 'google/protobuf/empty.pb.dart' as $1;
export 'starfish.pb.dart';

class StarfishClient extends $grpc.Client {
  static final _$createMaterialFeedbacks = $grpc.ClientMethod<
          $0.CreateMaterialFeedbacksRequest,
          $0.CreateMaterialFeedbacksResponse>(
      '/sil.starfish.Starfish/CreateMaterialFeedbacks',
      ($0.CreateMaterialFeedbacksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateMaterialFeedbacksResponse.fromBuffer(value));
  static final _$createUpdateGroups = $grpc.ClientMethod<
          $0.CreateUpdateGroupsRequest, $0.CreateUpdateGroupsResponse>(
      '/sil.starfish.Starfish/CreateUpdateGroups',
      ($0.CreateUpdateGroupsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateGroupsResponse.fromBuffer(value));
  static final _$createUpdateGroupUsers = $grpc.ClientMethod<
          $0.CreateUpdateGroupUsersRequest, $0.CreateUpdateGroupUsersResponse>(
      '/sil.starfish.Starfish/CreateUpdateGroupUsers',
      ($0.CreateUpdateGroupUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateGroupUsersResponse.fromBuffer(value));
  static final _$createUpdateMaterials = $grpc.ClientMethod<
          $0.CreateUpdateMaterialsRequest, $0.CreateUpdateMaterialsResponse>(
      '/sil.starfish.Starfish/CreateUpdateMaterials',
      ($0.CreateUpdateMaterialsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateMaterialsResponse.fromBuffer(value));
  static final _$createUsers =
      $grpc.ClientMethod<$0.User, $0.CreateUsersResponse>(
          '/sil.starfish.Starfish/CreateUsers',
          ($0.User value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CreateUsersResponse.fromBuffer(value));
  static final _$deleteGroupUsers =
      $grpc.ClientMethod<$0.GroupUser, $0.DeleteGroupUsersResponse>(
          '/sil.starfish.Starfish/DeleteGroupUsers',
          ($0.GroupUser value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteGroupUsersResponse.fromBuffer(value));
  static final _$getCurrentUser = $grpc.ClientMethod<$1.Empty, $0.User>(
      '/sil.starfish.Starfish/GetCurrentUser',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$listAllCountries =
      $grpc.ClientMethod<$0.ListAllCountriesRequest, $0.Country>(
          '/sil.starfish.Starfish/ListAllCountries',
          ($0.ListAllCountriesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Country.fromBuffer(value));
  static final _$listEvaluationCategories = $grpc.ClientMethod<
          $0.ListEvaluationCategoriesRequest, $0.EvaluationCategory>(
      '/sil.starfish.Starfish/ListEvaluationCategories',
      ($0.ListEvaluationCategoriesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.EvaluationCategory.fromBuffer(value));
  static final _$listGroups =
      $grpc.ClientMethod<$0.ListGroupsRequest, $0.Group>(
          '/sil.starfish.Starfish/ListGroups',
          ($0.ListGroupsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Group.fromBuffer(value));
  static final _$listLanguages =
      $grpc.ClientMethod<$0.ListLanguagesRequest, $0.Language>(
          '/sil.starfish.Starfish/ListLanguages',
          ($0.ListLanguagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Language.fromBuffer(value));
  static final _$listMaterials =
      $grpc.ClientMethod<$0.ListMaterialsRequest, $0.Material>(
          '/sil.starfish.Starfish/ListMaterials',
          ($0.ListMaterialsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Material.fromBuffer(value));
  static final _$listMaterialTopics =
      $grpc.ClientMethod<$0.ListMaterialTopicsRequest, $0.MaterialTopic>(
          '/sil.starfish.Starfish/ListMaterialTopics',
          ($0.ListMaterialTopicsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.MaterialTopic.fromBuffer(value));
  static final _$listMaterialTypes =
      $grpc.ClientMethod<$0.ListMaterialTypesRequest, $0.MaterialType>(
          '/sil.starfish.Starfish/ListMaterialTypes',
          ($0.ListMaterialTypesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.MaterialType.fromBuffer(value));
  static final _$listUsers = $grpc.ClientMethod<$0.ListUsersRequest, $0.User>(
      '/sil.starfish.Starfish/ListUsers',
      ($0.ListUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$updateCurrentUser =
      $grpc.ClientMethod<$0.UpdateCurrentUserRequest, $0.User>(
          '/sil.starfish.Starfish/UpdateCurrentUser',
          ($0.UpdateCurrentUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.User.fromBuffer(value));

  StarfishClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.CreateMaterialFeedbacksResponse>
      createMaterialFeedbacks(
          $async.Stream<$0.CreateMaterialFeedbacksRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createMaterialFeedbacks, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateGroupsResponse> createUpdateGroups(
      $async.Stream<$0.CreateUpdateGroupsRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateGroups, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateGroupUsersResponse>
      createUpdateGroupUsers(
          $async.Stream<$0.CreateUpdateGroupUsersRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateGroupUsers, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateMaterialsResponse> createUpdateMaterials(
      $async.Stream<$0.CreateUpdateMaterialsRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateMaterials, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUsersResponse> createUsers(
      $async.Stream<$0.User> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUsers, request, options: options);
  }

  $grpc.ResponseStream<$0.DeleteGroupUsersResponse> deleteGroupUsers(
      $async.Stream<$0.GroupUser> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$deleteGroupUsers, request, options: options);
  }

  $grpc.ResponseFuture<$0.User> getCurrentUser($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentUser, request, options: options);
  }

  $grpc.ResponseStream<$0.Country> listAllCountries(
      $0.ListAllCountriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listAllCountries, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.EvaluationCategory> listEvaluationCategories(
      $0.ListEvaluationCategoriesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listEvaluationCategories, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.Group> listGroups($0.ListGroupsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listGroups, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.Language> listLanguages(
      $0.ListLanguagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listLanguages, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.Material> listMaterials(
      $0.ListMaterialsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listMaterials, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.MaterialTopic> listMaterialTopics(
      $0.ListMaterialTopicsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listMaterialTopics, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.MaterialType> listMaterialTypes(
      $0.ListMaterialTypesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listMaterialTypes, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.User> listUsers($0.ListUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listUsers, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.User> updateCurrentUser(
      $0.UpdateCurrentUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateCurrentUser, request, options: options);
  }
}

abstract class StarfishServiceBase extends $grpc.Service {
  $core.String get $name => 'sil.starfish.Starfish';

  StarfishServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.CreateMaterialFeedbacksRequest,
            $0.CreateMaterialFeedbacksResponse>(
        'CreateMaterialFeedbacks',
        createMaterialFeedbacks,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateMaterialFeedbacksRequest.fromBuffer(value),
        ($0.CreateMaterialFeedbacksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateGroupsRequest,
            $0.CreateUpdateGroupsResponse>(
        'CreateUpdateGroups',
        createUpdateGroups,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateGroupsRequest.fromBuffer(value),
        ($0.CreateUpdateGroupsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateGroupUsersRequest,
            $0.CreateUpdateGroupUsersResponse>(
        'CreateUpdateGroupUsers',
        createUpdateGroupUsers,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateGroupUsersRequest.fromBuffer(value),
        ($0.CreateUpdateGroupUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateMaterialsRequest,
            $0.CreateUpdateMaterialsResponse>(
        'CreateUpdateMaterials',
        createUpdateMaterials,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateMaterialsRequest.fromBuffer(value),
        ($0.CreateUpdateMaterialsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.CreateUsersResponse>(
        'CreateUsers',
        createUsers,
        true,
        true,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.CreateUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GroupUser, $0.DeleteGroupUsersResponse>(
        'DeleteGroupUsers',
        deleteGroupUsers,
        true,
        true,
        ($core.List<$core.int> value) => $0.GroupUser.fromBuffer(value),
        ($0.DeleteGroupUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.User>(
        'GetCurrentUser',
        getCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListAllCountriesRequest, $0.Country>(
        'ListAllCountries',
        listAllCountries_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListAllCountriesRequest.fromBuffer(value),
        ($0.Country value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListEvaluationCategoriesRequest,
            $0.EvaluationCategory>(
        'ListEvaluationCategories',
        listEvaluationCategories_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListEvaluationCategoriesRequest.fromBuffer(value),
        ($0.EvaluationCategory value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListGroupsRequest, $0.Group>(
        'ListGroups',
        listGroups_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.ListGroupsRequest.fromBuffer(value),
        ($0.Group value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListLanguagesRequest, $0.Language>(
        'ListLanguages',
        listLanguages_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListLanguagesRequest.fromBuffer(value),
        ($0.Language value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListMaterialsRequest, $0.Material>(
        'ListMaterials',
        listMaterials_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListMaterialsRequest.fromBuffer(value),
        ($0.Material value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListMaterialTopicsRequest, $0.MaterialTopic>(
            'ListMaterialTopics',
            listMaterialTopics_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.ListMaterialTopicsRequest.fromBuffer(value),
            ($0.MaterialTopic value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListMaterialTypesRequest, $0.MaterialType>(
            'ListMaterialTypes',
            listMaterialTypes_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.ListMaterialTypesRequest.fromBuffer(value),
            ($0.MaterialType value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUsersRequest, $0.User>(
        'ListUsers',
        listUsers_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.ListUsersRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCurrentUserRequest, $0.User>(
        'UpdateCurrentUser',
        updateCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCurrentUserRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
  }

  $async.Future<$0.User> getCurrentUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getCurrentUser(call, await request);
  }

  $async.Stream<$0.Country> listAllCountries_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListAllCountriesRequest> request) async* {
    yield* listAllCountries(call, await request);
  }

  $async.Stream<$0.EvaluationCategory> listEvaluationCategories_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListEvaluationCategoriesRequest> request) async* {
    yield* listEvaluationCategories(call, await request);
  }

  $async.Stream<$0.Group> listGroups_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListGroupsRequest> request) async* {
    yield* listGroups(call, await request);
  }

  $async.Stream<$0.Language> listLanguages_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListLanguagesRequest> request) async* {
    yield* listLanguages(call, await request);
  }

  $async.Stream<$0.Material> listMaterials_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListMaterialsRequest> request) async* {
    yield* listMaterials(call, await request);
  }

  $async.Stream<$0.MaterialTopic> listMaterialTopics_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListMaterialTopicsRequest> request) async* {
    yield* listMaterialTopics(call, await request);
  }

  $async.Stream<$0.MaterialType> listMaterialTypes_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListMaterialTypesRequest> request) async* {
    yield* listMaterialTypes(call, await request);
  }

  $async.Stream<$0.User> listUsers_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListUsersRequest> request) async* {
    yield* listUsers(call, await request);
  }

  $async.Future<$0.User> updateCurrentUser_Pre($grpc.ServiceCall call,
      $async.Future<$0.UpdateCurrentUserRequest> request) async {
    return updateCurrentUser(call, await request);
  }

  $async.Stream<$0.CreateMaterialFeedbacksResponse> createMaterialFeedbacks(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateMaterialFeedbacksRequest> request);
  $async.Stream<$0.CreateUpdateGroupsResponse> createUpdateGroups(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateGroupsRequest> request);
  $async.Stream<$0.CreateUpdateGroupUsersResponse> createUpdateGroupUsers(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateGroupUsersRequest> request);
  $async.Stream<$0.CreateUpdateMaterialsResponse> createUpdateMaterials(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateMaterialsRequest> request);
  $async.Stream<$0.CreateUsersResponse> createUsers(
      $grpc.ServiceCall call, $async.Stream<$0.User> request);
  $async.Stream<$0.DeleteGroupUsersResponse> deleteGroupUsers(
      $grpc.ServiceCall call, $async.Stream<$0.GroupUser> request);
  $async.Future<$0.User> getCurrentUser(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Stream<$0.Country> listAllCountries(
      $grpc.ServiceCall call, $0.ListAllCountriesRequest request);
  $async.Stream<$0.EvaluationCategory> listEvaluationCategories(
      $grpc.ServiceCall call, $0.ListEvaluationCategoriesRequest request);
  $async.Stream<$0.Group> listGroups(
      $grpc.ServiceCall call, $0.ListGroupsRequest request);
  $async.Stream<$0.Language> listLanguages(
      $grpc.ServiceCall call, $0.ListLanguagesRequest request);
  $async.Stream<$0.Material> listMaterials(
      $grpc.ServiceCall call, $0.ListMaterialsRequest request);
  $async.Stream<$0.MaterialTopic> listMaterialTopics(
      $grpc.ServiceCall call, $0.ListMaterialTopicsRequest request);
  $async.Stream<$0.MaterialType> listMaterialTypes(
      $grpc.ServiceCall call, $0.ListMaterialTypesRequest request);
  $async.Stream<$0.User> listUsers(
      $grpc.ServiceCall call, $0.ListUsersRequest request);
  $async.Future<$0.User> updateCurrentUser(
      $grpc.ServiceCall call, $0.UpdateCurrentUserRequest request);
}
