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
  static final _$authenticate =
      $grpc.ClientMethod<$0.AuthenticateRequest, $0.AuthenticateResponse>(
          '/sil.starfish.Starfish/Authenticate',
          ($0.AuthenticateRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AuthenticateResponse.fromBuffer(value));
  static final _$createMaterialFeedbacks = $grpc.ClientMethod<
          $0.CreateMaterialFeedbacksRequest,
          $0.CreateMaterialFeedbacksResponse>(
      '/sil.starfish.Starfish/CreateMaterialFeedbacks',
      ($0.CreateMaterialFeedbacksRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateMaterialFeedbacksResponse.fromBuffer(value));
  static final _$createUpdateActions = $grpc.ClientMethod<
          $0.CreateUpdateActionsRequest, $0.CreateUpdateActionsResponse>(
      '/sil.starfish.Starfish/CreateUpdateActions',
      ($0.CreateUpdateActionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateActionsResponse.fromBuffer(value));
  static final _$createUpdateActionUsers = $grpc.ClientMethod<
          $0.CreateUpdateActionUserRequest, $0.CreateUpdateActionUserResponse>(
      '/sil.starfish.Starfish/CreateUpdateActionUsers',
      ($0.CreateUpdateActionUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateActionUserResponse.fromBuffer(value));
  static final _$createUpdateGroupEvaluations = $grpc.ClientMethod<
          $0.CreateUpdateGroupEvaluationRequest,
          $0.CreateUpdateGroupEvaluationResponse>(
      '/sil.starfish.Starfish/CreateUpdateGroupEvaluations',
      ($0.CreateUpdateGroupEvaluationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateGroupEvaluationResponse.fromBuffer(value));
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
  static final _$createUpdateLearnerEvaluations = $grpc.ClientMethod<
          $0.CreateUpdateLearnerEvaluationRequest,
          $0.CreateUpdateLearnerEvaluationResponse>(
      '/sil.starfish.Starfish/CreateUpdateLearnerEvaluations',
      ($0.CreateUpdateLearnerEvaluationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateLearnerEvaluationResponse.fromBuffer(value));
  static final _$createUpdateMaterials = $grpc.ClientMethod<
          $0.CreateUpdateMaterialsRequest, $0.CreateUpdateMaterialsResponse>(
      '/sil.starfish.Starfish/CreateUpdateMaterials',
      ($0.CreateUpdateMaterialsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateMaterialsResponse.fromBuffer(value));
  static final _$createUpdateTeacherResponses = $grpc.ClientMethod<
          $0.CreateUpdateTeacherResponseRequest,
          $0.CreateUpdateTeacherResponseResponse>(
      '/sil.starfish.Starfish/CreateUpdateTeacherResponses',
      ($0.CreateUpdateTeacherResponseRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateTeacherResponseResponse.fromBuffer(value));
  static final _$createUpdateTransformations = $grpc.ClientMethod<
          $0.CreateUpdateTransformationRequest,
          $0.CreateUpdateTransformationResponse>(
      '/sil.starfish.Starfish/CreateUpdateTransformations',
      ($0.CreateUpdateTransformationRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateTransformationResponse.fromBuffer(value));
  static final _$createUpdateUsers = $grpc.ClientMethod<
          $0.CreateUpdateUserRequest, $0.CreateUpdateUserResponse>(
      '/sil.starfish.Starfish/CreateUpdateUsers',
      ($0.CreateUpdateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) =>
          $0.CreateUpdateUserResponse.fromBuffer(value));
  static final _$deleteActions =
      $grpc.ClientMethod<$0.DeleteActionRequest, $0.DeleteActionResponse>(
          '/sil.starfish.Starfish/DeleteActions',
          ($0.DeleteActionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteActionResponse.fromBuffer(value));
  static final _$deleteGroupUsers =
      $grpc.ClientMethod<$0.GroupUser, $0.DeleteGroupUsersResponse>(
          '/sil.starfish.Starfish/DeleteGroupUsers',
          ($0.GroupUser value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteGroupUsersResponse.fromBuffer(value));
  static final _$deleteMaterials =
      $grpc.ClientMethod<$0.DeleteMaterialRequest, $0.DeleteMaterialResponse>(
          '/sil.starfish.Starfish/DeleteMaterials',
          ($0.DeleteMaterialRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.DeleteMaterialResponse.fromBuffer(value));
  static final _$getCurrentUser = $grpc.ClientMethod<$1.Empty, $0.User>(
      '/sil.starfish.Starfish/GetCurrentUser',
      ($1.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$listActions =
      $grpc.ClientMethod<$0.ListActionsRequest, $0.Action>(
          '/sil.starfish.Starfish/ListActions',
          ($0.ListActionsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Action.fromBuffer(value));
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
  static final _$listGroupEvaluations =
      $grpc.ClientMethod<$0.ListGroupEvaluationsRequest, $0.GroupEvaluation>(
          '/sil.starfish.Starfish/ListGroupEvaluations',
          ($0.ListGroupEvaluationsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.GroupEvaluation.fromBuffer(value));
  static final _$listLanguages =
      $grpc.ClientMethod<$0.ListLanguagesRequest, $0.Language>(
          '/sil.starfish.Starfish/ListLanguages',
          ($0.ListLanguagesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Language.fromBuffer(value));
  static final _$listLearnerEvaluations = $grpc.ClientMethod<
          $0.ListLearnerEvaluationsRequest, $0.LearnerEvaluation>(
      '/sil.starfish.Starfish/ListLearnerEvaluations',
      ($0.ListLearnerEvaluationsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.LearnerEvaluation.fromBuffer(value));
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
  static final _$listTeacherResponses =
      $grpc.ClientMethod<$0.ListTeacherResponsesRequest, $0.TeacherResponse>(
          '/sil.starfish.Starfish/ListTeacherResponses',
          ($0.ListTeacherResponsesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.TeacherResponse.fromBuffer(value));
  static final _$listTransformations =
      $grpc.ClientMethod<$0.ListTransformationsRequest, $0.Transformation>(
          '/sil.starfish.Starfish/ListTransformations',
          ($0.ListTransformationsRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Transformation.fromBuffer(value));
  static final _$listUsers = $grpc.ClientMethod<$0.ListUsersRequest, $0.User>(
      '/sil.starfish.Starfish/ListUsers',
      ($0.ListUsersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.User.fromBuffer(value));
  static final _$refreshSession =
      $grpc.ClientMethod<$0.RefreshSessionRequest, $0.AuthenticateResponse>(
          '/sil.starfish.Starfish/RefreshSession',
          ($0.RefreshSessionRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.AuthenticateResponse.fromBuffer(value));
  static final _$updateCurrentUser =
      $grpc.ClientMethod<$0.UpdateCurrentUserRequest, $0.User>(
          '/sil.starfish.Starfish/UpdateCurrentUser',
          ($0.UpdateCurrentUserRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.User.fromBuffer(value));

  StarfishClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.AuthenticateResponse> authenticate(
      $0.AuthenticateRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$authenticate, request, options: options);
  }

  $grpc.ResponseStream<$0.CreateMaterialFeedbacksResponse>
      createMaterialFeedbacks(
          $async.Stream<$0.CreateMaterialFeedbacksRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createMaterialFeedbacks, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateActionsResponse> createUpdateActions(
      $async.Stream<$0.CreateUpdateActionsRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateActions, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateActionUserResponse>
      createUpdateActionUsers(
          $async.Stream<$0.CreateUpdateActionUserRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateActionUsers, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateGroupEvaluationResponse>
      createUpdateGroupEvaluations(
          $async.Stream<$0.CreateUpdateGroupEvaluationRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateGroupEvaluations, request,
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

  $grpc.ResponseStream<$0.CreateUpdateLearnerEvaluationResponse>
      createUpdateLearnerEvaluations(
          $async.Stream<$0.CreateUpdateLearnerEvaluationRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateLearnerEvaluations, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateMaterialsResponse> createUpdateMaterials(
      $async.Stream<$0.CreateUpdateMaterialsRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateMaterials, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateTeacherResponseResponse>
      createUpdateTeacherResponses(
          $async.Stream<$0.CreateUpdateTeacherResponseRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateTeacherResponses, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateTransformationResponse>
      createUpdateTransformations(
          $async.Stream<$0.CreateUpdateTransformationRequest> request,
          {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateTransformations, request,
        options: options);
  }

  $grpc.ResponseStream<$0.CreateUpdateUserResponse> createUpdateUsers(
      $async.Stream<$0.CreateUpdateUserRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$createUpdateUsers, request, options: options);
  }

  $grpc.ResponseStream<$0.DeleteActionResponse> deleteActions(
      $async.Stream<$0.DeleteActionRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$deleteActions, request, options: options);
  }

  $grpc.ResponseStream<$0.DeleteGroupUsersResponse> deleteGroupUsers(
      $async.Stream<$0.GroupUser> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$deleteGroupUsers, request, options: options);
  }

  $grpc.ResponseStream<$0.DeleteMaterialResponse> deleteMaterials(
      $async.Stream<$0.DeleteMaterialRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$deleteMaterials, request, options: options);
  }

  $grpc.ResponseFuture<$0.User> getCurrentUser($1.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentUser, request, options: options);
  }

  $grpc.ResponseStream<$0.Action> listActions($0.ListActionsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listActions, $async.Stream.fromIterable([request]),
        options: options);
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

  $grpc.ResponseStream<$0.GroupEvaluation> listGroupEvaluations(
      $0.ListGroupEvaluationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listGroupEvaluations, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.Language> listLanguages(
      $0.ListLanguagesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listLanguages, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.LearnerEvaluation> listLearnerEvaluations(
      $0.ListLearnerEvaluationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listLearnerEvaluations, $async.Stream.fromIterable([request]),
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

  $grpc.ResponseStream<$0.TeacherResponse> listTeacherResponses(
      $0.ListTeacherResponsesRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listTeacherResponses, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.Transformation> listTransformations(
      $0.ListTransformationsRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listTransformations, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseStream<$0.User> listUsers($0.ListUsersRequest request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$listUsers, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.AuthenticateResponse> refreshSession(
      $0.RefreshSessionRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$refreshSession, request, options: options);
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
    $addMethod(
        $grpc.ServiceMethod<$0.AuthenticateRequest, $0.AuthenticateResponse>(
            'Authenticate',
            authenticate_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.AuthenticateRequest.fromBuffer(value),
            ($0.AuthenticateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateMaterialFeedbacksRequest,
            $0.CreateMaterialFeedbacksResponse>(
        'CreateMaterialFeedbacks',
        createMaterialFeedbacks,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateMaterialFeedbacksRequest.fromBuffer(value),
        ($0.CreateMaterialFeedbacksResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateActionsRequest,
            $0.CreateUpdateActionsResponse>(
        'CreateUpdateActions',
        createUpdateActions,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateActionsRequest.fromBuffer(value),
        ($0.CreateUpdateActionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateActionUserRequest,
            $0.CreateUpdateActionUserResponse>(
        'CreateUpdateActionUsers',
        createUpdateActionUsers,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateActionUserRequest.fromBuffer(value),
        ($0.CreateUpdateActionUserResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateGroupEvaluationRequest,
            $0.CreateUpdateGroupEvaluationResponse>(
        'CreateUpdateGroupEvaluations',
        createUpdateGroupEvaluations,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateGroupEvaluationRequest.fromBuffer(value),
        ($0.CreateUpdateGroupEvaluationResponse value) =>
            value.writeToBuffer()));
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
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateLearnerEvaluationRequest,
            $0.CreateUpdateLearnerEvaluationResponse>(
        'CreateUpdateLearnerEvaluations',
        createUpdateLearnerEvaluations,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateLearnerEvaluationRequest.fromBuffer(value),
        ($0.CreateUpdateLearnerEvaluationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateMaterialsRequest,
            $0.CreateUpdateMaterialsResponse>(
        'CreateUpdateMaterials',
        createUpdateMaterials,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateMaterialsRequest.fromBuffer(value),
        ($0.CreateUpdateMaterialsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateTeacherResponseRequest,
            $0.CreateUpdateTeacherResponseResponse>(
        'CreateUpdateTeacherResponses',
        createUpdateTeacherResponses,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateTeacherResponseRequest.fromBuffer(value),
        ($0.CreateUpdateTeacherResponseResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateTransformationRequest,
            $0.CreateUpdateTransformationResponse>(
        'CreateUpdateTransformations',
        createUpdateTransformations,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateTransformationRequest.fromBuffer(value),
        ($0.CreateUpdateTransformationResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateUpdateUserRequest,
            $0.CreateUpdateUserResponse>(
        'CreateUpdateUsers',
        createUpdateUsers,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.CreateUpdateUserRequest.fromBuffer(value),
        ($0.CreateUpdateUserResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.DeleteActionRequest, $0.DeleteActionResponse>(
            'DeleteActions',
            deleteActions,
            true,
            true,
            ($core.List<$core.int> value) =>
                $0.DeleteActionRequest.fromBuffer(value),
            ($0.DeleteActionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GroupUser, $0.DeleteGroupUsersResponse>(
        'DeleteGroupUsers',
        deleteGroupUsers,
        true,
        true,
        ($core.List<$core.int> value) => $0.GroupUser.fromBuffer(value),
        ($0.DeleteGroupUsersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DeleteMaterialRequest,
            $0.DeleteMaterialResponse>(
        'DeleteMaterials',
        deleteMaterials,
        true,
        true,
        ($core.List<$core.int> value) =>
            $0.DeleteMaterialRequest.fromBuffer(value),
        ($0.DeleteMaterialResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Empty, $0.User>(
        'GetCurrentUser',
        getCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Empty.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListActionsRequest, $0.Action>(
        'ListActions',
        listActions_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListActionsRequest.fromBuffer(value),
        ($0.Action value) => value.writeToBuffer()));
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
    $addMethod(
        $grpc.ServiceMethod<$0.ListGroupEvaluationsRequest, $0.GroupEvaluation>(
            'ListGroupEvaluations',
            listGroupEvaluations_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.ListGroupEvaluationsRequest.fromBuffer(value),
            ($0.GroupEvaluation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListLanguagesRequest, $0.Language>(
        'ListLanguages',
        listLanguages_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListLanguagesRequest.fromBuffer(value),
        ($0.Language value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListLearnerEvaluationsRequest,
            $0.LearnerEvaluation>(
        'ListLearnerEvaluations',
        listLearnerEvaluations_Pre,
        false,
        true,
        ($core.List<$core.int> value) =>
            $0.ListLearnerEvaluationsRequest.fromBuffer(value),
        ($0.LearnerEvaluation value) => value.writeToBuffer()));
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
    $addMethod(
        $grpc.ServiceMethod<$0.ListTeacherResponsesRequest, $0.TeacherResponse>(
            'ListTeacherResponses',
            listTeacherResponses_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.ListTeacherResponsesRequest.fromBuffer(value),
            ($0.TeacherResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.ListTransformationsRequest, $0.Transformation>(
            'ListTransformations',
            listTransformations_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.ListTransformationsRequest.fromBuffer(value),
            ($0.Transformation value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListUsersRequest, $0.User>(
        'ListUsers',
        listUsers_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.ListUsersRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.RefreshSessionRequest, $0.AuthenticateResponse>(
            'RefreshSession',
            refreshSession_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.RefreshSessionRequest.fromBuffer(value),
            ($0.AuthenticateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateCurrentUserRequest, $0.User>(
        'UpdateCurrentUser',
        updateCurrentUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateCurrentUserRequest.fromBuffer(value),
        ($0.User value) => value.writeToBuffer()));
  }

  $async.Future<$0.AuthenticateResponse> authenticate_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.AuthenticateRequest> request) async {
    return authenticate(call, await request);
  }

  $async.Future<$0.User> getCurrentUser_Pre(
      $grpc.ServiceCall call, $async.Future<$1.Empty> request) async {
    return getCurrentUser(call, await request);
  }

  $async.Stream<$0.Action> listActions_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListActionsRequest> request) async* {
    yield* listActions(call, await request);
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

  $async.Stream<$0.GroupEvaluation> listGroupEvaluations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListGroupEvaluationsRequest> request) async* {
    yield* listGroupEvaluations(call, await request);
  }

  $async.Stream<$0.Language> listLanguages_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListLanguagesRequest> request) async* {
    yield* listLanguages(call, await request);
  }

  $async.Stream<$0.LearnerEvaluation> listLearnerEvaluations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListLearnerEvaluationsRequest> request) async* {
    yield* listLearnerEvaluations(call, await request);
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

  $async.Stream<$0.TeacherResponse> listTeacherResponses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListTeacherResponsesRequest> request) async* {
    yield* listTeacherResponses(call, await request);
  }

  $async.Stream<$0.Transformation> listTransformations_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.ListTransformationsRequest> request) async* {
    yield* listTransformations(call, await request);
  }

  $async.Stream<$0.User> listUsers_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListUsersRequest> request) async* {
    yield* listUsers(call, await request);
  }

  $async.Future<$0.AuthenticateResponse> refreshSession_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.RefreshSessionRequest> request) async {
    return refreshSession(call, await request);
  }

  $async.Future<$0.User> updateCurrentUser_Pre($grpc.ServiceCall call,
      $async.Future<$0.UpdateCurrentUserRequest> request) async {
    return updateCurrentUser(call, await request);
  }

  $async.Future<$0.AuthenticateResponse> authenticate(
      $grpc.ServiceCall call, $0.AuthenticateRequest request);
  $async.Stream<$0.CreateMaterialFeedbacksResponse> createMaterialFeedbacks(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateMaterialFeedbacksRequest> request);
  $async.Stream<$0.CreateUpdateActionsResponse> createUpdateActions(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateActionsRequest> request);
  $async.Stream<$0.CreateUpdateActionUserResponse> createUpdateActionUsers(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateActionUserRequest> request);
  $async.Stream<$0.CreateUpdateGroupEvaluationResponse>
      createUpdateGroupEvaluations($grpc.ServiceCall call,
          $async.Stream<$0.CreateUpdateGroupEvaluationRequest> request);
  $async.Stream<$0.CreateUpdateGroupsResponse> createUpdateGroups(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateGroupsRequest> request);
  $async.Stream<$0.CreateUpdateGroupUsersResponse> createUpdateGroupUsers(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateGroupUsersRequest> request);
  $async.Stream<$0.CreateUpdateLearnerEvaluationResponse>
      createUpdateLearnerEvaluations($grpc.ServiceCall call,
          $async.Stream<$0.CreateUpdateLearnerEvaluationRequest> request);
  $async.Stream<$0.CreateUpdateMaterialsResponse> createUpdateMaterials(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateMaterialsRequest> request);
  $async.Stream<$0.CreateUpdateTeacherResponseResponse>
      createUpdateTeacherResponses($grpc.ServiceCall call,
          $async.Stream<$0.CreateUpdateTeacherResponseRequest> request);
  $async.Stream<$0.CreateUpdateTransformationResponse>
      createUpdateTransformations($grpc.ServiceCall call,
          $async.Stream<$0.CreateUpdateTransformationRequest> request);
  $async.Stream<$0.CreateUpdateUserResponse> createUpdateUsers(
      $grpc.ServiceCall call,
      $async.Stream<$0.CreateUpdateUserRequest> request);
  $async.Stream<$0.DeleteActionResponse> deleteActions(
      $grpc.ServiceCall call, $async.Stream<$0.DeleteActionRequest> request);
  $async.Stream<$0.DeleteGroupUsersResponse> deleteGroupUsers(
      $grpc.ServiceCall call, $async.Stream<$0.GroupUser> request);
  $async.Stream<$0.DeleteMaterialResponse> deleteMaterials(
      $grpc.ServiceCall call, $async.Stream<$0.DeleteMaterialRequest> request);
  $async.Future<$0.User> getCurrentUser(
      $grpc.ServiceCall call, $1.Empty request);
  $async.Stream<$0.Action> listActions(
      $grpc.ServiceCall call, $0.ListActionsRequest request);
  $async.Stream<$0.Country> listAllCountries(
      $grpc.ServiceCall call, $0.ListAllCountriesRequest request);
  $async.Stream<$0.EvaluationCategory> listEvaluationCategories(
      $grpc.ServiceCall call, $0.ListEvaluationCategoriesRequest request);
  $async.Stream<$0.Group> listGroups(
      $grpc.ServiceCall call, $0.ListGroupsRequest request);
  $async.Stream<$0.GroupEvaluation> listGroupEvaluations(
      $grpc.ServiceCall call, $0.ListGroupEvaluationsRequest request);
  $async.Stream<$0.Language> listLanguages(
      $grpc.ServiceCall call, $0.ListLanguagesRequest request);
  $async.Stream<$0.LearnerEvaluation> listLearnerEvaluations(
      $grpc.ServiceCall call, $0.ListLearnerEvaluationsRequest request);
  $async.Stream<$0.Material> listMaterials(
      $grpc.ServiceCall call, $0.ListMaterialsRequest request);
  $async.Stream<$0.MaterialTopic> listMaterialTopics(
      $grpc.ServiceCall call, $0.ListMaterialTopicsRequest request);
  $async.Stream<$0.MaterialType> listMaterialTypes(
      $grpc.ServiceCall call, $0.ListMaterialTypesRequest request);
  $async.Stream<$0.TeacherResponse> listTeacherResponses(
      $grpc.ServiceCall call, $0.ListTeacherResponsesRequest request);
  $async.Stream<$0.Transformation> listTransformations(
      $grpc.ServiceCall call, $0.ListTransformationsRequest request);
  $async.Stream<$0.User> listUsers(
      $grpc.ServiceCall call, $0.ListUsersRequest request);
  $async.Future<$0.AuthenticateResponse> refreshSession(
      $grpc.ServiceCall call, $0.RefreshSessionRequest request);
  $async.Future<$0.User> updateCurrentUser(
      $grpc.ServiceCall call, $0.UpdateCurrentUserRequest request);
}
