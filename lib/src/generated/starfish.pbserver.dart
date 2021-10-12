///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:async' as $async;

import 'package:protobuf/protobuf.dart' as $pb;

import 'dart:core' as $core;
import 'starfish.pb.dart' as $4;
import 'google/protobuf/empty.pb.dart' as $3;
import 'starfish.pbjson.dart';

export 'starfish.pb.dart';

abstract class StarfishServiceBase extends $pb.GeneratedService {
  $async.Future<$4.CreateMaterialFeedbacksResponse> createMaterialFeedbacks($pb.ServerContext ctx, $4.CreateMaterialFeedbacksRequest request);
  $async.Future<$4.CreateUpdateActionsResponse> createUpdateActions($pb.ServerContext ctx, $4.CreateUpdateActionsRequest request);
  $async.Future<$4.CreateUpdateGroupsResponse> createUpdateGroups($pb.ServerContext ctx, $4.CreateUpdateGroupsRequest request);
  $async.Future<$4.CreateUpdateGroupUsersResponse> createUpdateGroupUsers($pb.ServerContext ctx, $4.CreateUpdateGroupUsersRequest request);
  $async.Future<$4.CreateUpdateMaterialsResponse> createUpdateMaterials($pb.ServerContext ctx, $4.CreateUpdateMaterialsRequest request);
  $async.Future<$4.CreateUsersResponse> createUsers($pb.ServerContext ctx, $4.User request);
  $async.Future<$4.DeleteGroupUsersResponse> deleteGroupUsers($pb.ServerContext ctx, $4.GroupUser request);
  $async.Future<$4.User> getCurrentUser($pb.ServerContext ctx, $3.Empty request);
  $async.Future<$4.Action> listActions($pb.ServerContext ctx, $4.ListActionsRequest request);
  $async.Future<$4.Country> listAllCountries($pb.ServerContext ctx, $4.ListAllCountriesRequest request);
  $async.Future<$4.EvaluationCategory> listEvaluationCategories($pb.ServerContext ctx, $4.ListEvaluationCategoriesRequest request);
  $async.Future<$4.Group> listGroups($pb.ServerContext ctx, $4.ListGroupsRequest request);
  $async.Future<$4.Language> listLanguages($pb.ServerContext ctx, $4.ListLanguagesRequest request);
  $async.Future<$4.Material> listMaterials($pb.ServerContext ctx, $4.ListMaterialsRequest request);
  $async.Future<$4.MaterialTopic> listMaterialTopics($pb.ServerContext ctx, $4.ListMaterialTopicsRequest request);
  $async.Future<$4.MaterialType> listMaterialTypes($pb.ServerContext ctx, $4.ListMaterialTypesRequest request);
  $async.Future<$4.User> listUsers($pb.ServerContext ctx, $4.ListUsersRequest request);
  $async.Future<$4.User> updateCurrentUser($pb.ServerContext ctx, $4.UpdateCurrentUserRequest request);

  $pb.GeneratedMessage createRequest($core.String method) {
    switch (method) {
      case 'CreateMaterialFeedbacks': return $4.CreateMaterialFeedbacksRequest();
      case 'CreateUpdateActions': return $4.CreateUpdateActionsRequest();
      case 'CreateUpdateGroups': return $4.CreateUpdateGroupsRequest();
      case 'CreateUpdateGroupUsers': return $4.CreateUpdateGroupUsersRequest();
      case 'CreateUpdateMaterials': return $4.CreateUpdateMaterialsRequest();
      case 'CreateUsers': return $4.User();
      case 'DeleteGroupUsers': return $4.GroupUser();
      case 'GetCurrentUser': return $3.Empty();
      case 'ListActions': return $4.ListActionsRequest();
      case 'ListAllCountries': return $4.ListAllCountriesRequest();
      case 'ListEvaluationCategories': return $4.ListEvaluationCategoriesRequest();
      case 'ListGroups': return $4.ListGroupsRequest();
      case 'ListLanguages': return $4.ListLanguagesRequest();
      case 'ListMaterials': return $4.ListMaterialsRequest();
      case 'ListMaterialTopics': return $4.ListMaterialTopicsRequest();
      case 'ListMaterialTypes': return $4.ListMaterialTypesRequest();
      case 'ListUsers': return $4.ListUsersRequest();
      case 'UpdateCurrentUser': return $4.UpdateCurrentUserRequest();
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String method, $pb.GeneratedMessage request) {
    switch (method) {
      case 'CreateMaterialFeedbacks': return this.createMaterialFeedbacks(ctx, request as $4.CreateMaterialFeedbacksRequest);
      case 'CreateUpdateActions': return this.createUpdateActions(ctx, request as $4.CreateUpdateActionsRequest);
      case 'CreateUpdateGroups': return this.createUpdateGroups(ctx, request as $4.CreateUpdateGroupsRequest);
      case 'CreateUpdateGroupUsers': return this.createUpdateGroupUsers(ctx, request as $4.CreateUpdateGroupUsersRequest);
      case 'CreateUpdateMaterials': return this.createUpdateMaterials(ctx, request as $4.CreateUpdateMaterialsRequest);
      case 'CreateUsers': return this.createUsers(ctx, request as $4.User);
      case 'DeleteGroupUsers': return this.deleteGroupUsers(ctx, request as $4.GroupUser);
      case 'GetCurrentUser': return this.getCurrentUser(ctx, request as $3.Empty);
      case 'ListActions': return this.listActions(ctx, request as $4.ListActionsRequest);
      case 'ListAllCountries': return this.listAllCountries(ctx, request as $4.ListAllCountriesRequest);
      case 'ListEvaluationCategories': return this.listEvaluationCategories(ctx, request as $4.ListEvaluationCategoriesRequest);
      case 'ListGroups': return this.listGroups(ctx, request as $4.ListGroupsRequest);
      case 'ListLanguages': return this.listLanguages(ctx, request as $4.ListLanguagesRequest);
      case 'ListMaterials': return this.listMaterials(ctx, request as $4.ListMaterialsRequest);
      case 'ListMaterialTopics': return this.listMaterialTopics(ctx, request as $4.ListMaterialTopicsRequest);
      case 'ListMaterialTypes': return this.listMaterialTypes(ctx, request as $4.ListMaterialTypesRequest);
      case 'ListUsers': return this.listUsers(ctx, request as $4.ListUsersRequest);
      case 'UpdateCurrentUser': return this.updateCurrentUser(ctx, request as $4.UpdateCurrentUserRequest);
      default: throw $core.ArgumentError('Unknown method: $method');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => StarfishServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => StarfishServiceBase$messageJson;
}

