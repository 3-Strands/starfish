///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/type/date.pb.dart' as $2;
import 'google/protobuf/timestamp.pb.dart' as $3;
import 'google/protobuf/field_mask.pb.dart' as $4;

import 'starfish.pbenum.dart';

export 'starfish.pbenum.dart';

class Action extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Action', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<Action_Type>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Action_Type.TEXT_INSTRUCTION, valueOf: Action_Type.valueOf, enumValues: Action_Type.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instructions')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'materialId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'question')
    ..aOM<$2.Date>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateDue', subBuilder: $2.Date.create)
    ..pc<Edit>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'editHistory', $pb.PbFieldType.PM, subBuilder: Edit.create)
    ..hasRequiredFields = false
  ;

  Action._() : super();
  factory Action({
    $core.String? id,
    Action_Type? type,
    $core.String? name,
    $core.String? creatorId,
    $core.String? groupId,
    $core.String? instructions,
    $core.String? materialId,
    $core.String? question,
    $2.Date? dateDue,
    $core.Iterable<Edit>? editHistory,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (name != null) {
      _result.name = name;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (instructions != null) {
      _result.instructions = instructions;
    }
    if (materialId != null) {
      _result.materialId = materialId;
    }
    if (question != null) {
      _result.question = question;
    }
    if (dateDue != null) {
      _result.dateDue = dateDue;
    }
    if (editHistory != null) {
      _result.editHistory.addAll(editHistory);
    }
    return _result;
  }
  factory Action.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Action.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Action clone() => Action()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Action copyWith(void Function(Action) updates) => super.copyWith((message) => updates(message as Action)) as Action; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Action create() => Action._();
  Action createEmptyInstance() => create();
  static $pb.PbList<Action> createRepeated() => $pb.PbList<Action>();
  @$core.pragma('dart2js:noInline')
  static Action getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Action>(create);
  static Action? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  Action_Type get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Action_Type v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get name => $_getSZ(2);
  @$pb.TagNumber(3)
  set name($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasName() => $_has(2);
  @$pb.TagNumber(3)
  void clearName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get creatorId => $_getSZ(3);
  @$pb.TagNumber(4)
  set creatorId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreatorId() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatorId() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get groupId => $_getSZ(4);
  @$pb.TagNumber(5)
  set groupId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGroupId() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get instructions => $_getSZ(5);
  @$pb.TagNumber(6)
  set instructions($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInstructions() => $_has(5);
  @$pb.TagNumber(6)
  void clearInstructions() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get materialId => $_getSZ(6);
  @$pb.TagNumber(7)
  set materialId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaterialId() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaterialId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get question => $_getSZ(7);
  @$pb.TagNumber(8)
  set question($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasQuestion() => $_has(7);
  @$pb.TagNumber(8)
  void clearQuestion() => clearField(8);

  @$pb.TagNumber(9)
  $2.Date get dateDue => $_getN(8);
  @$pb.TagNumber(9)
  set dateDue($2.Date v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasDateDue() => $_has(8);
  @$pb.TagNumber(9)
  void clearDateDue() => clearField(9);
  @$pb.TagNumber(9)
  $2.Date ensureDateDue() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.List<Edit> get editHistory => $_getList(9);
}

class ActionUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActionUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<ActionUser_Status>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ActionUser_Status.UNSPECIFIED_STATUS, valueOf: ActionUser_Status.valueOf, enumValues: ActionUser_Status.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'teacherResponse')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userResponse')
    ..e<ActionUser_Evaluation>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evaluation', $pb.PbFieldType.OE, defaultOrMaker: ActionUser_Evaluation.UNSPECIFIED_EVALUATION, valueOf: ActionUser_Evaluation.valueOf, enumValues: ActionUser_Evaluation.values)
    ..hasRequiredFields = false
  ;

  ActionUser._() : super();
  factory ActionUser({
    $core.String? id,
    $core.String? actionId,
    $core.String? userId,
    ActionUser_Status? status,
    $core.String? teacherResponse,
    $core.String? userResponse,
    ActionUser_Evaluation? evaluation,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (actionId != null) {
      _result.actionId = actionId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (teacherResponse != null) {
      _result.teacherResponse = teacherResponse;
    }
    if (userResponse != null) {
      _result.userResponse = userResponse;
    }
    if (evaluation != null) {
      _result.evaluation = evaluation;
    }
    return _result;
  }
  factory ActionUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ActionUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ActionUser clone() => ActionUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ActionUser copyWith(void Function(ActionUser) updates) => super.copyWith((message) => updates(message as ActionUser)) as ActionUser; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ActionUser create() => ActionUser._();
  ActionUser createEmptyInstance() => create();
  static $pb.PbList<ActionUser> createRepeated() => $pb.PbList<ActionUser>();
  @$core.pragma('dart2js:noInline')
  static ActionUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ActionUser>(create);
  static ActionUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get actionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set actionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasActionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearActionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  ActionUser_Status get status => $_getN(3);
  @$pb.TagNumber(4)
  set status(ActionUser_Status v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get teacherResponse => $_getSZ(4);
  @$pb.TagNumber(5)
  set teacherResponse($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTeacherResponse() => $_has(4);
  @$pb.TagNumber(5)
  void clearTeacherResponse() => clearField(5);

  @$pb.TagNumber(7)
  $core.String get userResponse => $_getSZ(5);
  @$pb.TagNumber(7)
  set userResponse($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasUserResponse() => $_has(5);
  @$pb.TagNumber(7)
  void clearUserResponse() => clearField(7);

  @$pb.TagNumber(8)
  ActionUser_Evaluation get evaluation => $_getN(6);
  @$pb.TagNumber(8)
  set evaluation(ActionUser_Evaluation v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasEvaluation() => $_has(6);
  @$pb.TagNumber(8)
  void clearEvaluation() => clearField(8);
}

class AuthenticateRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AuthenticateRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'firebaseJwt')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userName')
    ..hasRequiredFields = false
  ;

  AuthenticateRequest._() : super();
  factory AuthenticateRequest({
    $core.String? firebaseJwt,
    $core.String? userName,
  }) {
    final _result = create();
    if (firebaseJwt != null) {
      _result.firebaseJwt = firebaseJwt;
    }
    if (userName != null) {
      _result.userName = userName;
    }
    return _result;
  }
  factory AuthenticateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AuthenticateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AuthenticateRequest clone() => AuthenticateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AuthenticateRequest copyWith(void Function(AuthenticateRequest) updates) => super.copyWith((message) => updates(message as AuthenticateRequest)) as AuthenticateRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AuthenticateRequest create() => AuthenticateRequest._();
  AuthenticateRequest createEmptyInstance() => create();
  static $pb.PbList<AuthenticateRequest> createRepeated() => $pb.PbList<AuthenticateRequest>();
  @$core.pragma('dart2js:noInline')
  static AuthenticateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthenticateRequest>(create);
  static AuthenticateRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firebaseJwt => $_getSZ(0);
  @$pb.TagNumber(1)
  set firebaseJwt($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFirebaseJwt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirebaseJwt() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(1);
  @$pb.TagNumber(2)
  set userName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => clearField(2);
}

class AuthenticateResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AuthenticateResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userToken')
    ..aOM<$3.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'expiresAt', subBuilder: $3.Timestamp.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..hasRequiredFields = false
  ;

  AuthenticateResponse._() : super();
  factory AuthenticateResponse({
    $core.String? userToken,
    $3.Timestamp? expiresAt,
    $core.String? userId,
    $core.String? refreshToken,
  }) {
    final _result = create();
    if (userToken != null) {
      _result.userToken = userToken;
    }
    if (expiresAt != null) {
      _result.expiresAt = expiresAt;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    return _result;
  }
  factory AuthenticateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AuthenticateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AuthenticateResponse clone() => AuthenticateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AuthenticateResponse copyWith(void Function(AuthenticateResponse) updates) => super.copyWith((message) => updates(message as AuthenticateResponse)) as AuthenticateResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AuthenticateResponse create() => AuthenticateResponse._();
  AuthenticateResponse createEmptyInstance() => create();
  static $pb.PbList<AuthenticateResponse> createRepeated() => $pb.PbList<AuthenticateResponse>();
  @$core.pragma('dart2js:noInline')
  static AuthenticateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AuthenticateResponse>(create);
  static AuthenticateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set userToken($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserToken() => clearField(1);

  @$pb.TagNumber(2)
  $3.Timestamp get expiresAt => $_getN(1);
  @$pb.TagNumber(2)
  set expiresAt($3.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpiresAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpiresAt() => clearField(2);
  @$pb.TagNumber(2)
  $3.Timestamp ensureExpiresAt() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get refreshToken => $_getSZ(3);
  @$pb.TagNumber(4)
  set refreshToken($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRefreshToken() => $_has(3);
  @$pb.TagNumber(4)
  void clearRefreshToken() => clearField(4);
}

class Country extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Country', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'diallingCode')
    ..hasRequiredFields = false
  ;

  Country._() : super();
  factory Country({
    $core.String? id,
    $core.String? name,
    $core.String? diallingCode,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (diallingCode != null) {
      _result.diallingCode = diallingCode;
    }
    return _result;
  }
  factory Country.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Country.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Country clone() => Country()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Country copyWith(void Function(Country) updates) => super.copyWith((message) => updates(message as Country)) as Country; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Country create() => Country._();
  Country createEmptyInstance() => create();
  static $pb.PbList<Country> createRepeated() => $pb.PbList<Country>();
  @$core.pragma('dart2js:noInline')
  static Country getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Country>(create);
  static Country? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get diallingCode => $_getSZ(2);
  @$pb.TagNumber(3)
  set diallingCode($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDiallingCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearDiallingCode() => clearField(3);
}

class CreateMaterialFeedbacksRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateMaterialFeedbacksRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<MaterialFeedback>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feedback', subBuilder: MaterialFeedback.create)
    ..hasRequiredFields = false
  ;

  CreateMaterialFeedbacksRequest._() : super();
  factory CreateMaterialFeedbacksRequest({
    MaterialFeedback? feedback,
  }) {
    final _result = create();
    if (feedback != null) {
      _result.feedback = feedback;
    }
    return _result;
  }
  factory CreateMaterialFeedbacksRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateMaterialFeedbacksRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateMaterialFeedbacksRequest clone() => CreateMaterialFeedbacksRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateMaterialFeedbacksRequest copyWith(void Function(CreateMaterialFeedbacksRequest) updates) => super.copyWith((message) => updates(message as CreateMaterialFeedbacksRequest)) as CreateMaterialFeedbacksRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateMaterialFeedbacksRequest create() => CreateMaterialFeedbacksRequest._();
  CreateMaterialFeedbacksRequest createEmptyInstance() => create();
  static $pb.PbList<CreateMaterialFeedbacksRequest> createRepeated() => $pb.PbList<CreateMaterialFeedbacksRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateMaterialFeedbacksRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateMaterialFeedbacksRequest>(create);
  static CreateMaterialFeedbacksRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MaterialFeedback get feedback => $_getN(0);
  @$pb.TagNumber(1)
  set feedback(MaterialFeedback v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFeedback() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeedback() => clearField(1);
  @$pb.TagNumber(1)
  MaterialFeedback ensureFeedback() => $_ensure(0);
}

class CreateMaterialFeedbacksResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateMaterialFeedbacksResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<MaterialFeedback>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feedback', subBuilder: MaterialFeedback.create)
    ..e<CreateMaterialFeedbacksResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateMaterialFeedbacksResponse_Status.SUCCESS, valueOf: CreateMaterialFeedbacksResponse_Status.valueOf, enumValues: CreateMaterialFeedbacksResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateMaterialFeedbacksResponse._() : super();
  factory CreateMaterialFeedbacksResponse({
    MaterialFeedback? feedback,
    CreateMaterialFeedbacksResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (feedback != null) {
      _result.feedback = feedback;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateMaterialFeedbacksResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateMaterialFeedbacksResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateMaterialFeedbacksResponse clone() => CreateMaterialFeedbacksResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateMaterialFeedbacksResponse copyWith(void Function(CreateMaterialFeedbacksResponse) updates) => super.copyWith((message) => updates(message as CreateMaterialFeedbacksResponse)) as CreateMaterialFeedbacksResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateMaterialFeedbacksResponse create() => CreateMaterialFeedbacksResponse._();
  CreateMaterialFeedbacksResponse createEmptyInstance() => create();
  static $pb.PbList<CreateMaterialFeedbacksResponse> createRepeated() => $pb.PbList<CreateMaterialFeedbacksResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateMaterialFeedbacksResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateMaterialFeedbacksResponse>(create);
  static CreateMaterialFeedbacksResponse? _defaultInstance;

  @$pb.TagNumber(1)
  MaterialFeedback get feedback => $_getN(0);
  @$pb.TagNumber(1)
  set feedback(MaterialFeedback v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFeedback() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeedback() => clearField(1);
  @$pb.TagNumber(1)
  MaterialFeedback ensureFeedback() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateMaterialFeedbacksResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateMaterialFeedbacksResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateActionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateActionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Action>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action', subBuilder: Action.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateActionsRequest._() : super();
  factory CreateUpdateActionsRequest({
    Action? action,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (action != null) {
      _result.action = action;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateActionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateActionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateActionsRequest clone() => CreateUpdateActionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateActionsRequest copyWith(void Function(CreateUpdateActionsRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateActionsRequest)) as CreateUpdateActionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionsRequest create() => CreateUpdateActionsRequest._();
  CreateUpdateActionsRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateActionsRequest> createRepeated() => $pb.PbList<CreateUpdateActionsRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateActionsRequest>(create);
  static CreateUpdateActionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Action get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(Action v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);
  @$pb.TagNumber(1)
  Action ensureAction() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateActionsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateActionsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Action>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action', subBuilder: Action.create)
    ..e<CreateUpdateActionsResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateActionsResponse_Status.SUCCESS, valueOf: CreateUpdateActionsResponse_Status.valueOf, enumValues: CreateUpdateActionsResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateActionsResponse._() : super();
  factory CreateUpdateActionsResponse({
    Action? action,
    CreateUpdateActionsResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (action != null) {
      _result.action = action;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateActionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateActionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateActionsResponse clone() => CreateUpdateActionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateActionsResponse copyWith(void Function(CreateUpdateActionsResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateActionsResponse)) as CreateUpdateActionsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionsResponse create() => CreateUpdateActionsResponse._();
  CreateUpdateActionsResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateActionsResponse> createRepeated() => $pb.PbList<CreateUpdateActionsResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateActionsResponse>(create);
  static CreateUpdateActionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Action get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(Action v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);
  @$pb.TagNumber(1)
  Action ensureAction() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateActionsResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateActionsResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateActionUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateActionUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<ActionUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionUser', subBuilder: ActionUser.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateActionUserRequest._() : super();
  factory CreateUpdateActionUserRequest({
    ActionUser? actionUser,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (actionUser != null) {
      _result.actionUser = actionUser;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateActionUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateActionUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateActionUserRequest clone() => CreateUpdateActionUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateActionUserRequest copyWith(void Function(CreateUpdateActionUserRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateActionUserRequest)) as CreateUpdateActionUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionUserRequest create() => CreateUpdateActionUserRequest._();
  CreateUpdateActionUserRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateActionUserRequest> createRepeated() => $pb.PbList<CreateUpdateActionUserRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateActionUserRequest>(create);
  static CreateUpdateActionUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ActionUser get actionUser => $_getN(0);
  @$pb.TagNumber(1)
  set actionUser(ActionUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasActionUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearActionUser() => clearField(1);
  @$pb.TagNumber(1)
  ActionUser ensureActionUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateActionUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateActionUserResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<ActionUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionUser', subBuilder: ActionUser.create)
    ..e<CreateUpdateActionUserResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateActionUserResponse_Status.SUCCESS, valueOf: CreateUpdateActionUserResponse_Status.valueOf, enumValues: CreateUpdateActionUserResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateActionUserResponse._() : super();
  factory CreateUpdateActionUserResponse({
    ActionUser? actionUser,
    CreateUpdateActionUserResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (actionUser != null) {
      _result.actionUser = actionUser;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateActionUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateActionUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateActionUserResponse clone() => CreateUpdateActionUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateActionUserResponse copyWith(void Function(CreateUpdateActionUserResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateActionUserResponse)) as CreateUpdateActionUserResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionUserResponse create() => CreateUpdateActionUserResponse._();
  CreateUpdateActionUserResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateActionUserResponse> createRepeated() => $pb.PbList<CreateUpdateActionUserResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateActionUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateActionUserResponse>(create);
  static CreateUpdateActionUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ActionUser get actionUser => $_getN(0);
  @$pb.TagNumber(1)
  set actionUser(ActionUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasActionUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearActionUser() => clearField(1);
  @$pb.TagNumber(1)
  ActionUser ensureActionUser() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateActionUserResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateActionUserResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateGroupEvaluationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateGroupEvaluationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<GroupEvaluation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupEvaluation', subBuilder: GroupEvaluation.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateGroupEvaluationRequest._() : super();
  factory CreateUpdateGroupEvaluationRequest({
    GroupEvaluation? groupEvaluation,
  }) {
    final _result = create();
    if (groupEvaluation != null) {
      _result.groupEvaluation = groupEvaluation;
    }
    return _result;
  }
  factory CreateUpdateGroupEvaluationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateGroupEvaluationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupEvaluationRequest clone() => CreateUpdateGroupEvaluationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupEvaluationRequest copyWith(void Function(CreateUpdateGroupEvaluationRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateGroupEvaluationRequest)) as CreateUpdateGroupEvaluationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupEvaluationRequest create() => CreateUpdateGroupEvaluationRequest._();
  CreateUpdateGroupEvaluationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateGroupEvaluationRequest> createRepeated() => $pb.PbList<CreateUpdateGroupEvaluationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupEvaluationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateGroupEvaluationRequest>(create);
  static CreateUpdateGroupEvaluationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  GroupEvaluation get groupEvaluation => $_getN(0);
  @$pb.TagNumber(1)
  set groupEvaluation(GroupEvaluation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupEvaluation() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupEvaluation() => clearField(1);
  @$pb.TagNumber(1)
  GroupEvaluation ensureGroupEvaluation() => $_ensure(0);
}

class CreateUpdateGroupEvaluationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateGroupEvaluationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<GroupEvaluation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupEvaluation', subBuilder: GroupEvaluation.create)
    ..e<CreateUpdateGroupEvaluationResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateGroupEvaluationResponse_Status.SUCCESS, valueOf: CreateUpdateGroupEvaluationResponse_Status.valueOf, enumValues: CreateUpdateGroupEvaluationResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateGroupEvaluationResponse._() : super();
  factory CreateUpdateGroupEvaluationResponse({
    GroupEvaluation? groupEvaluation,
    CreateUpdateGroupEvaluationResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (groupEvaluation != null) {
      _result.groupEvaluation = groupEvaluation;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateGroupEvaluationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateGroupEvaluationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupEvaluationResponse clone() => CreateUpdateGroupEvaluationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupEvaluationResponse copyWith(void Function(CreateUpdateGroupEvaluationResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateGroupEvaluationResponse)) as CreateUpdateGroupEvaluationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupEvaluationResponse create() => CreateUpdateGroupEvaluationResponse._();
  CreateUpdateGroupEvaluationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateGroupEvaluationResponse> createRepeated() => $pb.PbList<CreateUpdateGroupEvaluationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupEvaluationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateGroupEvaluationResponse>(create);
  static CreateUpdateGroupEvaluationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupEvaluation get groupEvaluation => $_getN(0);
  @$pb.TagNumber(1)
  set groupEvaluation(GroupEvaluation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupEvaluation() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupEvaluation() => clearField(1);
  @$pb.TagNumber(1)
  GroupEvaluation ensureGroupEvaluation() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateGroupEvaluationResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateGroupEvaluationResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateGroupsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateGroupsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Group>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: Group.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateGroupsRequest._() : super();
  factory CreateUpdateGroupsRequest({
    Group? group,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (group != null) {
      _result.group = group;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateGroupsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateGroupsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupsRequest clone() => CreateUpdateGroupsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupsRequest copyWith(void Function(CreateUpdateGroupsRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateGroupsRequest)) as CreateUpdateGroupsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupsRequest create() => CreateUpdateGroupsRequest._();
  CreateUpdateGroupsRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateGroupsRequest> createRepeated() => $pb.PbList<CreateUpdateGroupsRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateGroupsRequest>(create);
  static CreateUpdateGroupsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Group get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(Group v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  Group ensureGroup() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateGroupsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateGroupsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Group>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: Group.create)
    ..e<CreateUpdateGroupsResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateGroupsResponse_Status.SUCCESS, valueOf: CreateUpdateGroupsResponse_Status.valueOf, enumValues: CreateUpdateGroupsResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateGroupsResponse._() : super();
  factory CreateUpdateGroupsResponse({
    Group? group,
    CreateUpdateGroupsResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (group != null) {
      _result.group = group;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateGroupsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateGroupsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupsResponse clone() => CreateUpdateGroupsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupsResponse copyWith(void Function(CreateUpdateGroupsResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateGroupsResponse)) as CreateUpdateGroupsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupsResponse create() => CreateUpdateGroupsResponse._();
  CreateUpdateGroupsResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateGroupsResponse> createRepeated() => $pb.PbList<CreateUpdateGroupsResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateGroupsResponse>(create);
  static CreateUpdateGroupsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Group get group => $_getN(0);
  @$pb.TagNumber(1)
  set group(Group v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroup() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroup() => clearField(1);
  @$pb.TagNumber(1)
  Group ensureGroup() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateGroupsResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateGroupsResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateGroupUsersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateGroupUsersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<GroupUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupUser', subBuilder: GroupUser.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateGroupUsersRequest._() : super();
  factory CreateUpdateGroupUsersRequest({
    GroupUser? groupUser,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (groupUser != null) {
      _result.groupUser = groupUser;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateGroupUsersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateGroupUsersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupUsersRequest clone() => CreateUpdateGroupUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupUsersRequest copyWith(void Function(CreateUpdateGroupUsersRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateGroupUsersRequest)) as CreateUpdateGroupUsersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupUsersRequest create() => CreateUpdateGroupUsersRequest._();
  CreateUpdateGroupUsersRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateGroupUsersRequest> createRepeated() => $pb.PbList<CreateUpdateGroupUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupUsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateGroupUsersRequest>(create);
  static CreateUpdateGroupUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  GroupUser get groupUser => $_getN(0);
  @$pb.TagNumber(1)
  set groupUser(GroupUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupUser() => clearField(1);
  @$pb.TagNumber(1)
  GroupUser ensureGroupUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateGroupUsersResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateGroupUsersResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<GroupUser>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupUser', subBuilder: GroupUser.create)
    ..e<CreateUpdateGroupUsersResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateGroupUsersResponse_Status.SUCCESS, valueOf: CreateUpdateGroupUsersResponse_Status.valueOf, enumValues: CreateUpdateGroupUsersResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateGroupUsersResponse._() : super();
  factory CreateUpdateGroupUsersResponse({
    GroupUser? groupUser,
    CreateUpdateGroupUsersResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (groupUser != null) {
      _result.groupUser = groupUser;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateGroupUsersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateGroupUsersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupUsersResponse clone() => CreateUpdateGroupUsersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateGroupUsersResponse copyWith(void Function(CreateUpdateGroupUsersResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateGroupUsersResponse)) as CreateUpdateGroupUsersResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupUsersResponse create() => CreateUpdateGroupUsersResponse._();
  CreateUpdateGroupUsersResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateGroupUsersResponse> createRepeated() => $pb.PbList<CreateUpdateGroupUsersResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateGroupUsersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateGroupUsersResponse>(create);
  static CreateUpdateGroupUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  GroupUser get groupUser => $_getN(0);
  @$pb.TagNumber(1)
  set groupUser(GroupUser v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupUser() => clearField(1);
  @$pb.TagNumber(1)
  GroupUser ensureGroupUser() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateGroupUsersResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateGroupUsersResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateLearnerEvaluationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateLearnerEvaluationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<LearnerEvaluation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'learnerEvaluation', subBuilder: LearnerEvaluation.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateLearnerEvaluationRequest._() : super();
  factory CreateUpdateLearnerEvaluationRequest({
    LearnerEvaluation? learnerEvaluation,
  }) {
    final _result = create();
    if (learnerEvaluation != null) {
      _result.learnerEvaluation = learnerEvaluation;
    }
    return _result;
  }
  factory CreateUpdateLearnerEvaluationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateLearnerEvaluationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateLearnerEvaluationRequest clone() => CreateUpdateLearnerEvaluationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateLearnerEvaluationRequest copyWith(void Function(CreateUpdateLearnerEvaluationRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateLearnerEvaluationRequest)) as CreateUpdateLearnerEvaluationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateLearnerEvaluationRequest create() => CreateUpdateLearnerEvaluationRequest._();
  CreateUpdateLearnerEvaluationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateLearnerEvaluationRequest> createRepeated() => $pb.PbList<CreateUpdateLearnerEvaluationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateLearnerEvaluationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateLearnerEvaluationRequest>(create);
  static CreateUpdateLearnerEvaluationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  LearnerEvaluation get learnerEvaluation => $_getN(0);
  @$pb.TagNumber(1)
  set learnerEvaluation(LearnerEvaluation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLearnerEvaluation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLearnerEvaluation() => clearField(1);
  @$pb.TagNumber(1)
  LearnerEvaluation ensureLearnerEvaluation() => $_ensure(0);
}

class CreateUpdateLearnerEvaluationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateLearnerEvaluationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<LearnerEvaluation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'learnerEvaluation', subBuilder: LearnerEvaluation.create)
    ..e<CreateUpdateLearnerEvaluationResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateLearnerEvaluationResponse_Status.SUCCESS, valueOf: CreateUpdateLearnerEvaluationResponse_Status.valueOf, enumValues: CreateUpdateLearnerEvaluationResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateLearnerEvaluationResponse._() : super();
  factory CreateUpdateLearnerEvaluationResponse({
    LearnerEvaluation? learnerEvaluation,
    CreateUpdateLearnerEvaluationResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (learnerEvaluation != null) {
      _result.learnerEvaluation = learnerEvaluation;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateLearnerEvaluationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateLearnerEvaluationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateLearnerEvaluationResponse clone() => CreateUpdateLearnerEvaluationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateLearnerEvaluationResponse copyWith(void Function(CreateUpdateLearnerEvaluationResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateLearnerEvaluationResponse)) as CreateUpdateLearnerEvaluationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateLearnerEvaluationResponse create() => CreateUpdateLearnerEvaluationResponse._();
  CreateUpdateLearnerEvaluationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateLearnerEvaluationResponse> createRepeated() => $pb.PbList<CreateUpdateLearnerEvaluationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateLearnerEvaluationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateLearnerEvaluationResponse>(create);
  static CreateUpdateLearnerEvaluationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  LearnerEvaluation get learnerEvaluation => $_getN(0);
  @$pb.TagNumber(1)
  set learnerEvaluation(LearnerEvaluation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasLearnerEvaluation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLearnerEvaluation() => clearField(1);
  @$pb.TagNumber(1)
  LearnerEvaluation ensureLearnerEvaluation() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateLearnerEvaluationResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateLearnerEvaluationResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateMaterialsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateMaterialsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Material>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'material', subBuilder: Material.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateMaterialsRequest._() : super();
  factory CreateUpdateMaterialsRequest({
    Material? material,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (material != null) {
      _result.material = material;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateMaterialsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateMaterialsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateMaterialsRequest clone() => CreateUpdateMaterialsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateMaterialsRequest copyWith(void Function(CreateUpdateMaterialsRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateMaterialsRequest)) as CreateUpdateMaterialsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateMaterialsRequest create() => CreateUpdateMaterialsRequest._();
  CreateUpdateMaterialsRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateMaterialsRequest> createRepeated() => $pb.PbList<CreateUpdateMaterialsRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateMaterialsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateMaterialsRequest>(create);
  static CreateUpdateMaterialsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Material get material => $_getN(0);
  @$pb.TagNumber(1)
  set material(Material v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaterial() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaterial() => clearField(1);
  @$pb.TagNumber(1)
  Material ensureMaterial() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateMaterialsResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateMaterialsResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Material>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'material', subBuilder: Material.create)
    ..e<CreateUpdateMaterialsResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateMaterialsResponse_Status.SUCCESS, valueOf: CreateUpdateMaterialsResponse_Status.valueOf, enumValues: CreateUpdateMaterialsResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateMaterialsResponse._() : super();
  factory CreateUpdateMaterialsResponse({
    Material? material,
    CreateUpdateMaterialsResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (material != null) {
      _result.material = material;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateMaterialsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateMaterialsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateMaterialsResponse clone() => CreateUpdateMaterialsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateMaterialsResponse copyWith(void Function(CreateUpdateMaterialsResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateMaterialsResponse)) as CreateUpdateMaterialsResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateMaterialsResponse create() => CreateUpdateMaterialsResponse._();
  CreateUpdateMaterialsResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateMaterialsResponse> createRepeated() => $pb.PbList<CreateUpdateMaterialsResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateMaterialsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateMaterialsResponse>(create);
  static CreateUpdateMaterialsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Material get material => $_getN(0);
  @$pb.TagNumber(1)
  set material(Material v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaterial() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaterial() => clearField(1);
  @$pb.TagNumber(1)
  Material ensureMaterial() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateMaterialsResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateMaterialsResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateOutputRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateOutputRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Output>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output', subBuilder: Output.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateOutputRequest._() : super();
  factory CreateUpdateOutputRequest({
    Output? output,
  }) {
    final _result = create();
    if (output != null) {
      _result.output = output;
    }
    return _result;
  }
  factory CreateUpdateOutputRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateOutputRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateOutputRequest clone() => CreateUpdateOutputRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateOutputRequest copyWith(void Function(CreateUpdateOutputRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateOutputRequest)) as CreateUpdateOutputRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateOutputRequest create() => CreateUpdateOutputRequest._();
  CreateUpdateOutputRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateOutputRequest> createRepeated() => $pb.PbList<CreateUpdateOutputRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateOutputRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateOutputRequest>(create);
  static CreateUpdateOutputRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Output get output => $_getN(0);
  @$pb.TagNumber(1)
  set output(Output v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutput() => clearField(1);
  @$pb.TagNumber(1)
  Output ensureOutput() => $_ensure(0);
}

class CreateUpdateOutputResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateOutputResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Output>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output', subBuilder: Output.create)
    ..e<CreateUpdateOutputResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateOutputResponse_Status.SUCCESS, valueOf: CreateUpdateOutputResponse_Status.valueOf, enumValues: CreateUpdateOutputResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateOutputResponse._() : super();
  factory CreateUpdateOutputResponse({
    Output? output,
    CreateUpdateOutputResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (output != null) {
      _result.output = output;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateOutputResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateOutputResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateOutputResponse clone() => CreateUpdateOutputResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateOutputResponse copyWith(void Function(CreateUpdateOutputResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateOutputResponse)) as CreateUpdateOutputResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateOutputResponse create() => CreateUpdateOutputResponse._();
  CreateUpdateOutputResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateOutputResponse> createRepeated() => $pb.PbList<CreateUpdateOutputResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateOutputResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateOutputResponse>(create);
  static CreateUpdateOutputResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Output get output => $_getN(0);
  @$pb.TagNumber(1)
  set output(Output v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutput() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutput() => clearField(1);
  @$pb.TagNumber(1)
  Output ensureOutput() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateOutputResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateOutputResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateTeacherResponseRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateTeacherResponseRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<TeacherResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'teacherResponse', subBuilder: TeacherResponse.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateTeacherResponseRequest._() : super();
  factory CreateUpdateTeacherResponseRequest({
    TeacherResponse? teacherResponse,
  }) {
    final _result = create();
    if (teacherResponse != null) {
      _result.teacherResponse = teacherResponse;
    }
    return _result;
  }
  factory CreateUpdateTeacherResponseRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateTeacherResponseRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateTeacherResponseRequest clone() => CreateUpdateTeacherResponseRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateTeacherResponseRequest copyWith(void Function(CreateUpdateTeacherResponseRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateTeacherResponseRequest)) as CreateUpdateTeacherResponseRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTeacherResponseRequest create() => CreateUpdateTeacherResponseRequest._();
  CreateUpdateTeacherResponseRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateTeacherResponseRequest> createRepeated() => $pb.PbList<CreateUpdateTeacherResponseRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTeacherResponseRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateTeacherResponseRequest>(create);
  static CreateUpdateTeacherResponseRequest? _defaultInstance;

  @$pb.TagNumber(1)
  TeacherResponse get teacherResponse => $_getN(0);
  @$pb.TagNumber(1)
  set teacherResponse(TeacherResponse v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTeacherResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearTeacherResponse() => clearField(1);
  @$pb.TagNumber(1)
  TeacherResponse ensureTeacherResponse() => $_ensure(0);
}

class CreateUpdateTeacherResponseResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateTeacherResponseResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<TeacherResponse>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'teacherResponse', subBuilder: TeacherResponse.create)
    ..e<CreateUpdateTeacherResponseResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateTeacherResponseResponse_Status.SUCCESS, valueOf: CreateUpdateTeacherResponseResponse_Status.valueOf, enumValues: CreateUpdateTeacherResponseResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateTeacherResponseResponse._() : super();
  factory CreateUpdateTeacherResponseResponse({
    TeacherResponse? teacherResponse,
    CreateUpdateTeacherResponseResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (teacherResponse != null) {
      _result.teacherResponse = teacherResponse;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateTeacherResponseResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateTeacherResponseResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateTeacherResponseResponse clone() => CreateUpdateTeacherResponseResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateTeacherResponseResponse copyWith(void Function(CreateUpdateTeacherResponseResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateTeacherResponseResponse)) as CreateUpdateTeacherResponseResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTeacherResponseResponse create() => CreateUpdateTeacherResponseResponse._();
  CreateUpdateTeacherResponseResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateTeacherResponseResponse> createRepeated() => $pb.PbList<CreateUpdateTeacherResponseResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTeacherResponseResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateTeacherResponseResponse>(create);
  static CreateUpdateTeacherResponseResponse? _defaultInstance;

  @$pb.TagNumber(1)
  TeacherResponse get teacherResponse => $_getN(0);
  @$pb.TagNumber(1)
  set teacherResponse(TeacherResponse v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTeacherResponse() => $_has(0);
  @$pb.TagNumber(1)
  void clearTeacherResponse() => clearField(1);
  @$pb.TagNumber(1)
  TeacherResponse ensureTeacherResponse() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateTeacherResponseResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateTeacherResponseResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateTransformationRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateTransformationRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Transformation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transformation', subBuilder: Transformation.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateTransformationRequest._() : super();
  factory CreateUpdateTransformationRequest({
    Transformation? transformation,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (transformation != null) {
      _result.transformation = transformation;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateTransformationRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateTransformationRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateTransformationRequest clone() => CreateUpdateTransformationRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateTransformationRequest copyWith(void Function(CreateUpdateTransformationRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateTransformationRequest)) as CreateUpdateTransformationRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTransformationRequest create() => CreateUpdateTransformationRequest._();
  CreateUpdateTransformationRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateTransformationRequest> createRepeated() => $pb.PbList<CreateUpdateTransformationRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTransformationRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateTransformationRequest>(create);
  static CreateUpdateTransformationRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Transformation get transformation => $_getN(0);
  @$pb.TagNumber(1)
  set transformation(Transformation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransformation() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransformation() => clearField(1);
  @$pb.TagNumber(1)
  Transformation ensureTransformation() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateTransformationResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateTransformationResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Transformation>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transformation', subBuilder: Transformation.create)
    ..e<CreateUpdateTransformationResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateTransformationResponse_Status.SUCCESS, valueOf: CreateUpdateTransformationResponse_Status.valueOf, enumValues: CreateUpdateTransformationResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateTransformationResponse._() : super();
  factory CreateUpdateTransformationResponse({
    Transformation? transformation,
    CreateUpdateTransformationResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (transformation != null) {
      _result.transformation = transformation;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateTransformationResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateTransformationResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateTransformationResponse clone() => CreateUpdateTransformationResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateTransformationResponse copyWith(void Function(CreateUpdateTransformationResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateTransformationResponse)) as CreateUpdateTransformationResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTransformationResponse create() => CreateUpdateTransformationResponse._();
  CreateUpdateTransformationResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateTransformationResponse> createRepeated() => $pb.PbList<CreateUpdateTransformationResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateTransformationResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateTransformationResponse>(create);
  static CreateUpdateTransformationResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Transformation get transformation => $_getN(0);
  @$pb.TagNumber(1)
  set transformation(Transformation v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTransformation() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransformation() => clearField(1);
  @$pb.TagNumber(1)
  Transformation ensureTransformation() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateTransformationResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateTransformationResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class CreateUpdateUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateUserRequest._() : super();
  factory CreateUpdateUserRequest({
    User? user,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory CreateUpdateUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateUserRequest clone() => CreateUpdateUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateUserRequest copyWith(void Function(CreateUpdateUserRequest) updates) => super.copyWith((message) => updates(message as CreateUpdateUserRequest)) as CreateUpdateUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateUserRequest create() => CreateUpdateUserRequest._();
  CreateUpdateUserRequest createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateUserRequest> createRepeated() => $pb.PbList<CreateUpdateUserRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateUserRequest>(create);
  static CreateUpdateUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class CreateUpdateUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateUserResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..e<CreateUpdateUserResponse_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: CreateUpdateUserResponse_Status.SUCCESS, valueOf: CreateUpdateUserResponse_Status.valueOf, enumValues: CreateUpdateUserResponse_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  CreateUpdateUserResponse._() : super();
  factory CreateUpdateUserResponse({
    User? user,
    CreateUpdateUserResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory CreateUpdateUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateUpdateUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateUpdateUserResponse clone() => CreateUpdateUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateUpdateUserResponse copyWith(void Function(CreateUpdateUserResponse) updates) => super.copyWith((message) => updates(message as CreateUpdateUserResponse)) as CreateUpdateUserResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CreateUpdateUserResponse create() => CreateUpdateUserResponse._();
  CreateUpdateUserResponse createEmptyInstance() => create();
  static $pb.PbList<CreateUpdateUserResponse> createRepeated() => $pb.PbList<CreateUpdateUserResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateUpdateUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateUpdateUserResponse>(create);
  static CreateUpdateUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateUpdateUserResponse_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(CreateUpdateUserResponse_Status v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => clearField(3);
}

class DeleteActionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteActionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionId')
    ..hasRequiredFields = false
  ;

  DeleteActionRequest._() : super();
  factory DeleteActionRequest({
    $core.String? actionId,
  }) {
    final _result = create();
    if (actionId != null) {
      _result.actionId = actionId;
    }
    return _result;
  }
  factory DeleteActionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteActionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteActionRequest clone() => DeleteActionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteActionRequest copyWith(void Function(DeleteActionRequest) updates) => super.copyWith((message) => updates(message as DeleteActionRequest)) as DeleteActionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteActionRequest create() => DeleteActionRequest._();
  DeleteActionRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteActionRequest> createRepeated() => $pb.PbList<DeleteActionRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteActionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteActionRequest>(create);
  static DeleteActionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get actionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set actionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearActionId() => clearField(1);
}

class DeleteActionResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteActionResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionId')
    ..e<DeleteActionResponse_Status>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DeleteActionResponse_Status.SUCCESS, valueOf: DeleteActionResponse_Status.valueOf, enumValues: DeleteActionResponse_Status.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteActionResponse._() : super();
  factory DeleteActionResponse({
    $core.String? actionId,
    DeleteActionResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (actionId != null) {
      _result.actionId = actionId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteActionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteActionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteActionResponse clone() => DeleteActionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteActionResponse copyWith(void Function(DeleteActionResponse) updates) => super.copyWith((message) => updates(message as DeleteActionResponse)) as DeleteActionResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteActionResponse create() => DeleteActionResponse._();
  DeleteActionResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteActionResponse> createRepeated() => $pb.PbList<DeleteActionResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteActionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteActionResponse>(create);
  static DeleteActionResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get actionId => $_getSZ(0);
  @$pb.TagNumber(1)
  set actionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearActionId() => clearField(1);

  @$pb.TagNumber(3)
  DeleteActionResponse_Status get status => $_getN(1);
  @$pb.TagNumber(3)
  set status(DeleteActionResponse_Status v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class DeletedResource extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeletedResource', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..e<ResourceType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resourceType', $pb.PbFieldType.OE, defaultOrMaker: ResourceType.TYPE_UNSPECIFIED, valueOf: ResourceType.valueOf, enumValues: ResourceType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$2.Date>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deletionDate', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  DeletedResource._() : super();
  factory DeletedResource({
    ResourceType? resourceType,
    $core.String? id,
    $2.Date? deletionDate,
  }) {
    final _result = create();
    if (resourceType != null) {
      _result.resourceType = resourceType;
    }
    if (id != null) {
      _result.id = id;
    }
    if (deletionDate != null) {
      _result.deletionDate = deletionDate;
    }
    return _result;
  }
  factory DeletedResource.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletedResource.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletedResource clone() => DeletedResource()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletedResource copyWith(void Function(DeletedResource) updates) => super.copyWith((message) => updates(message as DeletedResource)) as DeletedResource; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeletedResource create() => DeletedResource._();
  DeletedResource createEmptyInstance() => create();
  static $pb.PbList<DeletedResource> createRepeated() => $pb.PbList<DeletedResource>();
  @$core.pragma('dart2js:noInline')
  static DeletedResource getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeletedResource>(create);
  static DeletedResource? _defaultInstance;

  @$pb.TagNumber(1)
  ResourceType get resourceType => $_getN(0);
  @$pb.TagNumber(1)
  set resourceType(ResourceType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResourceType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResourceType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $2.Date get deletionDate => $_getN(2);
  @$pb.TagNumber(3)
  set deletionDate($2.Date v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeletionDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeletionDate() => clearField(3);
  @$pb.TagNumber(3)
  $2.Date ensureDeletionDate() => $_ensure(2);
}

class DeleteGroupUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteGroupUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupUserId')
    ..hasRequiredFields = false
  ;

  DeleteGroupUserRequest._() : super();
  factory DeleteGroupUserRequest({
    $core.String? groupUserId,
  }) {
    final _result = create();
    if (groupUserId != null) {
      _result.groupUserId = groupUserId;
    }
    return _result;
  }
  factory DeleteGroupUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteGroupUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteGroupUserRequest clone() => DeleteGroupUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteGroupUserRequest copyWith(void Function(DeleteGroupUserRequest) updates) => super.copyWith((message) => updates(message as DeleteGroupUserRequest)) as DeleteGroupUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteGroupUserRequest create() => DeleteGroupUserRequest._();
  DeleteGroupUserRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteGroupUserRequest> createRepeated() => $pb.PbList<DeleteGroupUserRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteGroupUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteGroupUserRequest>(create);
  static DeleteGroupUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupUserId() => clearField(1);
}

class DeleteGroupUserResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteGroupUserResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupUserId')
    ..e<DeleteGroupUserResponse_Status>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DeleteGroupUserResponse_Status.SUCCESS, valueOf: DeleteGroupUserResponse_Status.valueOf, enumValues: DeleteGroupUserResponse_Status.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteGroupUserResponse._() : super();
  factory DeleteGroupUserResponse({
    $core.String? groupUserId,
    DeleteGroupUserResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (groupUserId != null) {
      _result.groupUserId = groupUserId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteGroupUserResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteGroupUserResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteGroupUserResponse clone() => DeleteGroupUserResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteGroupUserResponse copyWith(void Function(DeleteGroupUserResponse) updates) => super.copyWith((message) => updates(message as DeleteGroupUserResponse)) as DeleteGroupUserResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteGroupUserResponse create() => DeleteGroupUserResponse._();
  DeleteGroupUserResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteGroupUserResponse> createRepeated() => $pb.PbList<DeleteGroupUserResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteGroupUserResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteGroupUserResponse>(create);
  static DeleteGroupUserResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupUserId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupUserId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupUserId() => clearField(1);

  @$pb.TagNumber(3)
  DeleteGroupUserResponse_Status get status => $_getN(1);
  @$pb.TagNumber(3)
  set status(DeleteGroupUserResponse_Status v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class DeleteMaterialRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteMaterialRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'materialId')
    ..hasRequiredFields = false
  ;

  DeleteMaterialRequest._() : super();
  factory DeleteMaterialRequest({
    $core.String? materialId,
  }) {
    final _result = create();
    if (materialId != null) {
      _result.materialId = materialId;
    }
    return _result;
  }
  factory DeleteMaterialRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteMaterialRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteMaterialRequest clone() => DeleteMaterialRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteMaterialRequest copyWith(void Function(DeleteMaterialRequest) updates) => super.copyWith((message) => updates(message as DeleteMaterialRequest)) as DeleteMaterialRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteMaterialRequest create() => DeleteMaterialRequest._();
  DeleteMaterialRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteMaterialRequest> createRepeated() => $pb.PbList<DeleteMaterialRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteMaterialRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteMaterialRequest>(create);
  static DeleteMaterialRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get materialId => $_getSZ(0);
  @$pb.TagNumber(1)
  set materialId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaterialId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaterialId() => clearField(1);
}

class DeleteMaterialResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DeleteMaterialResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'materialId')
    ..e<DeleteMaterialResponse_Status>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: DeleteMaterialResponse_Status.SUCCESS, valueOf: DeleteMaterialResponse_Status.valueOf, enumValues: DeleteMaterialResponse_Status.values)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  DeleteMaterialResponse._() : super();
  factory DeleteMaterialResponse({
    $core.String? materialId,
    DeleteMaterialResponse_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (materialId != null) {
      _result.materialId = materialId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory DeleteMaterialResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteMaterialResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteMaterialResponse clone() => DeleteMaterialResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteMaterialResponse copyWith(void Function(DeleteMaterialResponse) updates) => super.copyWith((message) => updates(message as DeleteMaterialResponse)) as DeleteMaterialResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DeleteMaterialResponse create() => DeleteMaterialResponse._();
  DeleteMaterialResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteMaterialResponse> createRepeated() => $pb.PbList<DeleteMaterialResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteMaterialResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteMaterialResponse>(create);
  static DeleteMaterialResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get materialId => $_getSZ(0);
  @$pb.TagNumber(1)
  set materialId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaterialId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaterialId() => clearField(1);

  @$pb.TagNumber(3)
  DeleteMaterialResponse_Status get status => $_getN(1);
  @$pb.TagNumber(3)
  set status(DeleteMaterialResponse_Status v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(4)
  set message($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(4)
  void clearMessage() => clearField(4);
}

class Edit extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Edit', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'username')
    ..aOM<$3.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'time', subBuilder: $3.Timestamp.create)
    ..e<Edit_Event>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'event', $pb.PbFieldType.OE, defaultOrMaker: Edit_Event.EVENT_UNSPECIFIED, valueOf: Edit_Event.valueOf, enumValues: Edit_Event.values)
    ..hasRequiredFields = false
  ;

  Edit._() : super();
  factory Edit({
    $core.String? username,
    $3.Timestamp? time,
    Edit_Event? event,
  }) {
    final _result = create();
    if (username != null) {
      _result.username = username;
    }
    if (time != null) {
      _result.time = time;
    }
    if (event != null) {
      _result.event = event;
    }
    return _result;
  }
  factory Edit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Edit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Edit clone() => Edit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Edit copyWith(void Function(Edit) updates) => super.copyWith((message) => updates(message as Edit)) as Edit; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Edit create() => Edit._();
  Edit createEmptyInstance() => create();
  static $pb.PbList<Edit> createRepeated() => $pb.PbList<Edit>();
  @$core.pragma('dart2js:noInline')
  static Edit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Edit>(create);
  static Edit? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => clearField(1);

  @$pb.TagNumber(3)
  $3.Timestamp get time => $_getN(1);
  @$pb.TagNumber(3)
  set time($3.Timestamp v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(3)
  void clearTime() => clearField(3);
  @$pb.TagNumber(3)
  $3.Timestamp ensureTime() => $_ensure(1);

  @$pb.TagNumber(4)
  Edit_Event get event => $_getN(2);
  @$pb.TagNumber(4)
  set event(Edit_Event v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEvent() => $_has(2);
  @$pb.TagNumber(4)
  void clearEvent() => clearField(4);
}

class EvaluationCategory extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EvaluationCategory', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<EvaluationValueName>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'valueNames', $pb.PbFieldType.PM, subBuilder: EvaluationValueName.create)
    ..hasRequiredFields = false
  ;

  EvaluationCategory._() : super();
  factory EvaluationCategory({
    $core.String? id,
    $core.String? name,
    $core.Iterable<EvaluationValueName>? valueNames,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (valueNames != null) {
      _result.valueNames.addAll(valueNames);
    }
    return _result;
  }
  factory EvaluationCategory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EvaluationCategory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EvaluationCategory clone() => EvaluationCategory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EvaluationCategory copyWith(void Function(EvaluationCategory) updates) => super.copyWith((message) => updates(message as EvaluationCategory)) as EvaluationCategory; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EvaluationCategory create() => EvaluationCategory._();
  EvaluationCategory createEmptyInstance() => create();
  static $pb.PbList<EvaluationCategory> createRepeated() => $pb.PbList<EvaluationCategory>();
  @$core.pragma('dart2js:noInline')
  static EvaluationCategory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EvaluationCategory>(create);
  static EvaluationCategory? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<EvaluationValueName> get valueNames => $_getList(2);
}

class EvaluationValueName extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EvaluationValueName', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', $pb.PbFieldType.O3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  EvaluationValueName._() : super();
  factory EvaluationValueName({
    $core.int? value,
    $core.String? name,
    $core.String? id,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (name != null) {
      _result.name = name;
    }
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory EvaluationValueName.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EvaluationValueName.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EvaluationValueName clone() => EvaluationValueName()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EvaluationValueName copyWith(void Function(EvaluationValueName) updates) => super.copyWith((message) => updates(message as EvaluationValueName)) as EvaluationValueName; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EvaluationValueName create() => EvaluationValueName._();
  EvaluationValueName createEmptyInstance() => create();
  static $pb.PbList<EvaluationValueName> createRepeated() => $pb.PbList<EvaluationValueName>();
  @$core.pragma('dart2js:noInline')
  static EvaluationValueName getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EvaluationValueName>(create);
  static EvaluationValueName? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get value => $_getIZ(0);
  @$pb.TagNumber(1)
  set value($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get id => $_getSZ(2);
  @$pb.TagNumber(3)
  set id($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasId() => $_has(2);
  @$pb.TagNumber(3)
  void clearId() => clearField(3);
}

class Group extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Group', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'languageIds')
    ..pc<GroupUser>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'users', $pb.PbFieldType.PM, subBuilder: GroupUser.create)
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evaluationCategoryIds')
    ..pc<Edit>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'editHistory', $pb.PbFieldType.PM, subBuilder: Edit.create)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkEmail')
    ..m<$core.String, $core.String>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'languages', entryClassName: 'Group.LanguagesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('sil.starfish'))
    ..e<Group_Status>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Group_Status.ACTIVE, valueOf: Group_Status.valueOf, enumValues: Group_Status.values)
    ..pc<OutputMarker>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputMarkers', $pb.PbFieldType.PM, subBuilder: OutputMarker.create)
    ..hasRequiredFields = false
  ;

  Group._() : super();
  factory Group({
    $core.String? id,
    $core.String? name,
    $core.Iterable<$core.String>? languageIds,
    $core.Iterable<GroupUser>? users,
    $core.Iterable<$core.String>? evaluationCategoryIds,
    $core.Iterable<Edit>? editHistory,
    $core.String? description,
    $core.String? linkEmail,
    $core.Map<$core.String, $core.String>? languages,
    Group_Status? status,
    $core.Iterable<OutputMarker>? outputMarkers,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (languageIds != null) {
      _result.languageIds.addAll(languageIds);
    }
    if (users != null) {
      _result.users.addAll(users);
    }
    if (evaluationCategoryIds != null) {
      _result.evaluationCategoryIds.addAll(evaluationCategoryIds);
    }
    if (editHistory != null) {
      _result.editHistory.addAll(editHistory);
    }
    if (description != null) {
      _result.description = description;
    }
    if (linkEmail != null) {
      _result.linkEmail = linkEmail;
    }
    if (languages != null) {
      _result.languages.addAll(languages);
    }
    if (status != null) {
      _result.status = status;
    }
    if (outputMarkers != null) {
      _result.outputMarkers.addAll(outputMarkers);
    }
    return _result;
  }
  factory Group.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Group.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Group clone() => Group()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Group copyWith(void Function(Group) updates) => super.copyWith((message) => updates(message as Group)) as Group; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Group create() => Group._();
  Group createEmptyInstance() => create();
  static $pb.PbList<Group> createRepeated() => $pb.PbList<Group>();
  @$core.pragma('dart2js:noInline')
  static Group getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Group>(create);
  static Group? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get languageIds => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<GroupUser> get users => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get evaluationCategoryIds => $_getList(4);

  @$pb.TagNumber(7)
  $core.List<Edit> get editHistory => $_getList(5);

  @$pb.TagNumber(8)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(8)
  set description($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(8)
  void clearDescription() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get linkEmail => $_getSZ(7);
  @$pb.TagNumber(9)
  set linkEmail($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasLinkEmail() => $_has(7);
  @$pb.TagNumber(9)
  void clearLinkEmail() => clearField(9);

  @$pb.TagNumber(10)
  $core.Map<$core.String, $core.String> get languages => $_getMap(8);

  @$pb.TagNumber(11)
  Group_Status get status => $_getN(9);
  @$pb.TagNumber(11)
  set status(Group_Status v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(11)
  void clearStatus() => clearField(11);

  @$pb.TagNumber(13)
  $core.List<OutputMarker> get outputMarkers => $_getList(10);
}

class GroupEvaluation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupEvaluation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOM<$2.Date>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', subBuilder: $2.Date.create)
    ..e<GroupEvaluation_Evaluation>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evaluation', $pb.PbFieldType.OE, defaultOrMaker: GroupEvaluation_Evaluation.EVAL_UNSPECIFIED, valueOf: GroupEvaluation_Evaluation.valueOf, enumValues: GroupEvaluation_Evaluation.values)
    ..hasRequiredFields = false
  ;

  GroupEvaluation._() : super();
  factory GroupEvaluation({
    $core.String? id,
    $core.String? userId,
    $core.String? groupId,
    $2.Date? month,
    GroupEvaluation_Evaluation? evaluation,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (month != null) {
      _result.month = month;
    }
    if (evaluation != null) {
      _result.evaluation = evaluation;
    }
    return _result;
  }
  factory GroupEvaluation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupEvaluation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupEvaluation clone() => GroupEvaluation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupEvaluation copyWith(void Function(GroupEvaluation) updates) => super.copyWith((message) => updates(message as GroupEvaluation)) as GroupEvaluation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupEvaluation create() => GroupEvaluation._();
  GroupEvaluation createEmptyInstance() => create();
  static $pb.PbList<GroupEvaluation> createRepeated() => $pb.PbList<GroupEvaluation>();
  @$core.pragma('dart2js:noInline')
  static GroupEvaluation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupEvaluation>(create);
  static GroupEvaluation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => clearField(3);

  @$pb.TagNumber(4)
  $2.Date get month => $_getN(3);
  @$pb.TagNumber(4)
  set month($2.Date v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearMonth() => clearField(4);
  @$pb.TagNumber(4)
  $2.Date ensureMonth() => $_ensure(3);

  @$pb.TagNumber(5)
  GroupEvaluation_Evaluation get evaluation => $_getN(4);
  @$pb.TagNumber(5)
  set evaluation(GroupEvaluation_Evaluation v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEvaluation() => $_has(4);
  @$pb.TagNumber(5)
  void clearEvaluation() => clearField(5);
}

class GroupUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<GroupUser_Role>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: GroupUser_Role.UNSPECIFIED_ROLE, valueOf: GroupUser_Role.valueOf, enumValues: GroupUser_Role.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'profile')
    ..hasRequiredFields = false
  ;

  GroupUser._() : super();
  factory GroupUser({
    $core.String? id,
    $core.String? groupId,
    $core.String? userId,
    GroupUser_Role? role,
    $core.String? profile,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (role != null) {
      _result.role = role;
    }
    if (profile != null) {
      _result.profile = profile;
    }
    return _result;
  }
  factory GroupUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GroupUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GroupUser clone() => GroupUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GroupUser copyWith(void Function(GroupUser) updates) => super.copyWith((message) => updates(message as GroupUser)) as GroupUser; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static GroupUser create() => GroupUser._();
  GroupUser createEmptyInstance() => create();
  static $pb.PbList<GroupUser> createRepeated() => $pb.PbList<GroupUser>();
  @$core.pragma('dart2js:noInline')
  static GroupUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GroupUser>(create);
  static GroupUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(1);
  @$pb.TagNumber(2)
  set groupId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(1);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  GroupUser_Role get role => $_getN(3);
  @$pb.TagNumber(4)
  set role(GroupUser_Role v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRole() => $_has(3);
  @$pb.TagNumber(4)
  void clearRole() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get profile => $_getSZ(4);
  @$pb.TagNumber(5)
  set profile($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasProfile() => $_has(4);
  @$pb.TagNumber(5)
  void clearProfile() => clearField(5);
}

class Language extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Language', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  Language._() : super();
  factory Language({
    $core.String? id,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory Language.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Language.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Language clone() => Language()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Language copyWith(void Function(Language) updates) => super.copyWith((message) => updates(message as Language)) as Language; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Language create() => Language._();
  Language createEmptyInstance() => create();
  static $pb.PbList<Language> createRepeated() => $pb.PbList<Language>();
  @$core.pragma('dart2js:noInline')
  static Language getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Language>(create);
  static Language? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class LearnerEvaluation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'LearnerEvaluation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'learnerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evaluatorId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOM<$2.Date>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', subBuilder: $2.Date.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryId')
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evaluation', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  LearnerEvaluation._() : super();
  factory LearnerEvaluation({
    $core.String? id,
    $core.String? learnerId,
    $core.String? evaluatorId,
    $core.String? groupId,
    $2.Date? month,
    $core.String? categoryId,
    $core.int? evaluation,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (learnerId != null) {
      _result.learnerId = learnerId;
    }
    if (evaluatorId != null) {
      _result.evaluatorId = evaluatorId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (month != null) {
      _result.month = month;
    }
    if (categoryId != null) {
      _result.categoryId = categoryId;
    }
    if (evaluation != null) {
      _result.evaluation = evaluation;
    }
    return _result;
  }
  factory LearnerEvaluation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LearnerEvaluation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LearnerEvaluation clone() => LearnerEvaluation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LearnerEvaluation copyWith(void Function(LearnerEvaluation) updates) => super.copyWith((message) => updates(message as LearnerEvaluation)) as LearnerEvaluation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LearnerEvaluation create() => LearnerEvaluation._();
  LearnerEvaluation createEmptyInstance() => create();
  static $pb.PbList<LearnerEvaluation> createRepeated() => $pb.PbList<LearnerEvaluation>();
  @$core.pragma('dart2js:noInline')
  static LearnerEvaluation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LearnerEvaluation>(create);
  static LearnerEvaluation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get learnerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set learnerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLearnerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLearnerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get evaluatorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set evaluatorId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasEvaluatorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearEvaluatorId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get groupId => $_getSZ(3);
  @$pb.TagNumber(4)
  set groupId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGroupId() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroupId() => clearField(4);

  @$pb.TagNumber(5)
  $2.Date get month => $_getN(4);
  @$pb.TagNumber(5)
  set month($2.Date v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMonth() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonth() => clearField(5);
  @$pb.TagNumber(5)
  $2.Date ensureMonth() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get categoryId => $_getSZ(5);
  @$pb.TagNumber(6)
  set categoryId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCategoryId() => $_has(5);
  @$pb.TagNumber(6)
  void clearCategoryId() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get evaluation => $_getIZ(6);
  @$pb.TagNumber(7)
  set evaluation($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasEvaluation() => $_has(6);
  @$pb.TagNumber(7)
  void clearEvaluation() => clearField(7);
}

class ListActionsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListActionsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListActionsRequest._() : super();
  factory ListActionsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListActionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListActionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListActionsRequest clone() => ListActionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListActionsRequest copyWith(void Function(ListActionsRequest) updates) => super.copyWith((message) => updates(message as ListActionsRequest)) as ListActionsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListActionsRequest create() => ListActionsRequest._();
  ListActionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListActionsRequest> createRepeated() => $pb.PbList<ListActionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListActionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListActionsRequest>(create);
  static ListActionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListAllCountriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListAllCountriesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListAllCountriesRequest._() : super();
  factory ListAllCountriesRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListAllCountriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListAllCountriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListAllCountriesRequest clone() => ListAllCountriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListAllCountriesRequest copyWith(void Function(ListAllCountriesRequest) updates) => super.copyWith((message) => updates(message as ListAllCountriesRequest)) as ListAllCountriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListAllCountriesRequest create() => ListAllCountriesRequest._();
  ListAllCountriesRequest createEmptyInstance() => create();
  static $pb.PbList<ListAllCountriesRequest> createRepeated() => $pb.PbList<ListAllCountriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAllCountriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAllCountriesRequest>(create);
  static ListAllCountriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListEvaluationCategoriesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListEvaluationCategoriesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListEvaluationCategoriesRequest._() : super();
  factory ListEvaluationCategoriesRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListEvaluationCategoriesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListEvaluationCategoriesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListEvaluationCategoriesRequest clone() => ListEvaluationCategoriesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListEvaluationCategoriesRequest copyWith(void Function(ListEvaluationCategoriesRequest) updates) => super.copyWith((message) => updates(message as ListEvaluationCategoriesRequest)) as ListEvaluationCategoriesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListEvaluationCategoriesRequest create() => ListEvaluationCategoriesRequest._();
  ListEvaluationCategoriesRequest createEmptyInstance() => create();
  static $pb.PbList<ListEvaluationCategoriesRequest> createRepeated() => $pb.PbList<ListEvaluationCategoriesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListEvaluationCategoriesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListEvaluationCategoriesRequest>(create);
  static ListEvaluationCategoriesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListGroupsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListGroupsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListGroupsRequest._() : super();
  factory ListGroupsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListGroupsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListGroupsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListGroupsRequest clone() => ListGroupsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListGroupsRequest copyWith(void Function(ListGroupsRequest) updates) => super.copyWith((message) => updates(message as ListGroupsRequest)) as ListGroupsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListGroupsRequest create() => ListGroupsRequest._();
  ListGroupsRequest createEmptyInstance() => create();
  static $pb.PbList<ListGroupsRequest> createRepeated() => $pb.PbList<ListGroupsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListGroupsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListGroupsRequest>(create);
  static ListGroupsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListGroupEvaluationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListGroupEvaluationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListGroupEvaluationsRequest._() : super();
  factory ListGroupEvaluationsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListGroupEvaluationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListGroupEvaluationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListGroupEvaluationsRequest clone() => ListGroupEvaluationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListGroupEvaluationsRequest copyWith(void Function(ListGroupEvaluationsRequest) updates) => super.copyWith((message) => updates(message as ListGroupEvaluationsRequest)) as ListGroupEvaluationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListGroupEvaluationsRequest create() => ListGroupEvaluationsRequest._();
  ListGroupEvaluationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListGroupEvaluationsRequest> createRepeated() => $pb.PbList<ListGroupEvaluationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListGroupEvaluationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListGroupEvaluationsRequest>(create);
  static ListGroupEvaluationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListLanguagesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListLanguagesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListLanguagesRequest._() : super();
  factory ListLanguagesRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListLanguagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListLanguagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListLanguagesRequest clone() => ListLanguagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListLanguagesRequest copyWith(void Function(ListLanguagesRequest) updates) => super.copyWith((message) => updates(message as ListLanguagesRequest)) as ListLanguagesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLanguagesRequest create() => ListLanguagesRequest._();
  ListLanguagesRequest createEmptyInstance() => create();
  static $pb.PbList<ListLanguagesRequest> createRepeated() => $pb.PbList<ListLanguagesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLanguagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListLanguagesRequest>(create);
  static ListLanguagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListLearnerEvaluationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListLearnerEvaluationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListLearnerEvaluationsRequest._() : super();
  factory ListLearnerEvaluationsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListLearnerEvaluationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListLearnerEvaluationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListLearnerEvaluationsRequest clone() => ListLearnerEvaluationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListLearnerEvaluationsRequest copyWith(void Function(ListLearnerEvaluationsRequest) updates) => super.copyWith((message) => updates(message as ListLearnerEvaluationsRequest)) as ListLearnerEvaluationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListLearnerEvaluationsRequest create() => ListLearnerEvaluationsRequest._();
  ListLearnerEvaluationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListLearnerEvaluationsRequest> createRepeated() => $pb.PbList<ListLearnerEvaluationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListLearnerEvaluationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListLearnerEvaluationsRequest>(create);
  static ListLearnerEvaluationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListMaterialsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListMaterialsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListMaterialsRequest._() : super();
  factory ListMaterialsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListMaterialsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMaterialsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMaterialsRequest clone() => ListMaterialsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMaterialsRequest copyWith(void Function(ListMaterialsRequest) updates) => super.copyWith((message) => updates(message as ListMaterialsRequest)) as ListMaterialsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMaterialsRequest create() => ListMaterialsRequest._();
  ListMaterialsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMaterialsRequest> createRepeated() => $pb.PbList<ListMaterialsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMaterialsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMaterialsRequest>(create);
  static ListMaterialsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListMaterialTopicsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListMaterialTopicsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListMaterialTopicsRequest._() : super();
  factory ListMaterialTopicsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListMaterialTopicsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMaterialTopicsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMaterialTopicsRequest clone() => ListMaterialTopicsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMaterialTopicsRequest copyWith(void Function(ListMaterialTopicsRequest) updates) => super.copyWith((message) => updates(message as ListMaterialTopicsRequest)) as ListMaterialTopicsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMaterialTopicsRequest create() => ListMaterialTopicsRequest._();
  ListMaterialTopicsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMaterialTopicsRequest> createRepeated() => $pb.PbList<ListMaterialTopicsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMaterialTopicsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMaterialTopicsRequest>(create);
  static ListMaterialTopicsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListMaterialTypesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListMaterialTypesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListMaterialTypesRequest._() : super();
  factory ListMaterialTypesRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListMaterialTypesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMaterialTypesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMaterialTypesRequest clone() => ListMaterialTypesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMaterialTypesRequest copyWith(void Function(ListMaterialTypesRequest) updates) => super.copyWith((message) => updates(message as ListMaterialTypesRequest)) as ListMaterialTypesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMaterialTypesRequest create() => ListMaterialTypesRequest._();
  ListMaterialTypesRequest createEmptyInstance() => create();
  static $pb.PbList<ListMaterialTypesRequest> createRepeated() => $pb.PbList<ListMaterialTypesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMaterialTypesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMaterialTypesRequest>(create);
  static ListMaterialTypesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListOutputsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListOutputsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListOutputsRequest._() : super();
  factory ListOutputsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListOutputsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListOutputsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListOutputsRequest clone() => ListOutputsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListOutputsRequest copyWith(void Function(ListOutputsRequest) updates) => super.copyWith((message) => updates(message as ListOutputsRequest)) as ListOutputsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListOutputsRequest create() => ListOutputsRequest._();
  ListOutputsRequest createEmptyInstance() => create();
  static $pb.PbList<ListOutputsRequest> createRepeated() => $pb.PbList<ListOutputsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListOutputsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListOutputsRequest>(create);
  static ListOutputsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListTeacherResponsesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTeacherResponsesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListTeacherResponsesRequest._() : super();
  factory ListTeacherResponsesRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListTeacherResponsesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTeacherResponsesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTeacherResponsesRequest clone() => ListTeacherResponsesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTeacherResponsesRequest copyWith(void Function(ListTeacherResponsesRequest) updates) => super.copyWith((message) => updates(message as ListTeacherResponsesRequest)) as ListTeacherResponsesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTeacherResponsesRequest create() => ListTeacherResponsesRequest._();
  ListTeacherResponsesRequest createEmptyInstance() => create();
  static $pb.PbList<ListTeacherResponsesRequest> createRepeated() => $pb.PbList<ListTeacherResponsesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTeacherResponsesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTeacherResponsesRequest>(create);
  static ListTeacherResponsesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListTransformationsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListTransformationsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListTransformationsRequest._() : super();
  factory ListTransformationsRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListTransformationsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListTransformationsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListTransformationsRequest clone() => ListTransformationsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListTransformationsRequest copyWith(void Function(ListTransformationsRequest) updates) => super.copyWith((message) => updates(message as ListTransformationsRequest)) as ListTransformationsRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListTransformationsRequest create() => ListTransformationsRequest._();
  ListTransformationsRequest createEmptyInstance() => create();
  static $pb.PbList<ListTransformationsRequest> createRepeated() => $pb.PbList<ListTransformationsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListTransformationsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListTransformationsRequest>(create);
  static ListTransformationsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class ListUsersRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListUsersRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$2.Date>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ListUsersRequest._() : super();
  factory ListUsersRequest({
    $2.Date? updatedSince,
  }) {
    final _result = create();
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    return _result;
  }
  factory ListUsersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListUsersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListUsersRequest clone() => ListUsersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListUsersRequest copyWith(void Function(ListUsersRequest) updates) => super.copyWith((message) => updates(message as ListUsersRequest)) as ListUsersRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListUsersRequest create() => ListUsersRequest._();
  ListUsersRequest createEmptyInstance() => create();
  static $pb.PbList<ListUsersRequest> createRepeated() => $pb.PbList<ListUsersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUsersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListUsersRequest>(create);
  static ListUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Date get updatedSince => $_getN(0);
  @$pb.TagNumber(1)
  set updatedSince($2.Date v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUpdatedSince() => $_has(0);
  @$pb.TagNumber(1)
  void clearUpdatedSince() => clearField(1);
  @$pb.TagNumber(1)
  $2.Date ensureUpdatedSince() => $_ensure(0);
}

class Material extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Material', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..e<Material_Status>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Material_Status.UNSPECIFIED_STATUS, valueOf: Material_Status.valueOf, enumValues: Material_Status.values)
    ..e<Material_Visibility>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'visibility', $pb.PbFieldType.OE, defaultOrMaker: Material_Visibility.UNSPECIFIED_VISIBILITY, valueOf: Material_Visibility.valueOf, enumValues: Material_Visibility.values)
    ..e<Material_Editability>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'editability', $pb.PbFieldType.OE, defaultOrMaker: Material_Editability.UNSPECIFIED_EDITABILITY, valueOf: Material_Editability.valueOf, enumValues: Material_Editability.values)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'targetAudience')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..pPS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'files')
    ..pPS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'languageIds')
    ..pPS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'typeIds')
    ..pPS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'topics')
    ..pc<MaterialFeedback>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'feedbacks', $pb.PbFieldType.PM, subBuilder: MaterialFeedback.create)
    ..aOM<$2.Date>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateCreated', subBuilder: $2.Date.create)
    ..aOM<$2.Date>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateUpdated', subBuilder: $2.Date.create)
    ..pc<Edit>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'editHistory', $pb.PbFieldType.PM, subBuilder: Edit.create)
    ..m<$core.String, $core.String>(18, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'languages', entryClassName: 'Material.LanguagesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('sil.starfish'))
    ..hasRequiredFields = false
  ;

  Material._() : super();
  factory Material({
    $core.String? id,
    $core.String? creatorId,
    Material_Status? status,
    Material_Visibility? visibility,
    Material_Editability? editability,
    $core.String? title,
    $core.String? description,
    $core.String? targetAudience,
    $core.String? url,
    $core.Iterable<$core.String>? files,
    $core.Iterable<$core.String>? languageIds,
    $core.Iterable<$core.String>? typeIds,
    $core.Iterable<$core.String>? topics,
    $core.Iterable<MaterialFeedback>? feedbacks,
    $2.Date? dateCreated,
    $2.Date? dateUpdated,
    $core.Iterable<Edit>? editHistory,
    $core.Map<$core.String, $core.String>? languages,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (status != null) {
      _result.status = status;
    }
    if (visibility != null) {
      _result.visibility = visibility;
    }
    if (editability != null) {
      _result.editability = editability;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (targetAudience != null) {
      _result.targetAudience = targetAudience;
    }
    if (url != null) {
      _result.url = url;
    }
    if (files != null) {
      _result.files.addAll(files);
    }
    if (languageIds != null) {
      _result.languageIds.addAll(languageIds);
    }
    if (typeIds != null) {
      _result.typeIds.addAll(typeIds);
    }
    if (topics != null) {
      _result.topics.addAll(topics);
    }
    if (feedbacks != null) {
      _result.feedbacks.addAll(feedbacks);
    }
    if (dateCreated != null) {
      _result.dateCreated = dateCreated;
    }
    if (dateUpdated != null) {
      _result.dateUpdated = dateUpdated;
    }
    if (editHistory != null) {
      _result.editHistory.addAll(editHistory);
    }
    if (languages != null) {
      _result.languages.addAll(languages);
    }
    return _result;
  }
  factory Material.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Material.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Material clone() => Material()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Material copyWith(void Function(Material) updates) => super.copyWith((message) => updates(message as Material)) as Material; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Material create() => Material._();
  Material createEmptyInstance() => create();
  static $pb.PbList<Material> createRepeated() => $pb.PbList<Material>();
  @$core.pragma('dart2js:noInline')
  static Material getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Material>(create);
  static Material? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => clearField(2);

  @$pb.TagNumber(3)
  Material_Status get status => $_getN(2);
  @$pb.TagNumber(3)
  set status(Material_Status v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => clearField(3);

  @$pb.TagNumber(4)
  Material_Visibility get visibility => $_getN(3);
  @$pb.TagNumber(4)
  set visibility(Material_Visibility v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVisibility() => $_has(3);
  @$pb.TagNumber(4)
  void clearVisibility() => clearField(4);

  @$pb.TagNumber(5)
  Material_Editability get editability => $_getN(4);
  @$pb.TagNumber(5)
  set editability(Material_Editability v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEditability() => $_has(4);
  @$pb.TagNumber(5)
  void clearEditability() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get title => $_getSZ(5);
  @$pb.TagNumber(6)
  set title($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTitle() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get description => $_getSZ(6);
  @$pb.TagNumber(7)
  set description($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDescription() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescription() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get targetAudience => $_getSZ(7);
  @$pb.TagNumber(8)
  set targetAudience($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasTargetAudience() => $_has(7);
  @$pb.TagNumber(8)
  void clearTargetAudience() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get url => $_getSZ(8);
  @$pb.TagNumber(9)
  set url($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearUrl() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.String> get files => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<$core.String> get languageIds => $_getList(10);

  @$pb.TagNumber(12)
  $core.List<$core.String> get typeIds => $_getList(11);

  @$pb.TagNumber(13)
  $core.List<$core.String> get topics => $_getList(12);

  @$pb.TagNumber(14)
  $core.List<MaterialFeedback> get feedbacks => $_getList(13);

  @$pb.TagNumber(15)
  $2.Date get dateCreated => $_getN(14);
  @$pb.TagNumber(15)
  set dateCreated($2.Date v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasDateCreated() => $_has(14);
  @$pb.TagNumber(15)
  void clearDateCreated() => clearField(15);
  @$pb.TagNumber(15)
  $2.Date ensureDateCreated() => $_ensure(14);

  @$pb.TagNumber(16)
  $2.Date get dateUpdated => $_getN(15);
  @$pb.TagNumber(16)
  set dateUpdated($2.Date v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasDateUpdated() => $_has(15);
  @$pb.TagNumber(16)
  void clearDateUpdated() => clearField(16);
  @$pb.TagNumber(16)
  $2.Date ensureDateUpdated() => $_ensure(15);

  @$pb.TagNumber(17)
  $core.List<Edit> get editHistory => $_getList(16);

  @$pb.TagNumber(18)
  $core.Map<$core.String, $core.String> get languages => $_getMap(17);
}

class MaterialFeedback extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MaterialFeedback', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<MaterialFeedback_Type>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MaterialFeedback_Type.UNSPECIFIED_TYPE, valueOf: MaterialFeedback_Type.valueOf, enumValues: MaterialFeedback_Type.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reporterId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'report')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'materialId')
    ..hasRequiredFields = false
  ;

  MaterialFeedback._() : super();
  factory MaterialFeedback({
    $core.String? id,
    MaterialFeedback_Type? type,
    $core.String? reporterId,
    $core.String? report,
    $core.String? response,
    $core.String? materialId,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    if (reporterId != null) {
      _result.reporterId = reporterId;
    }
    if (report != null) {
      _result.report = report;
    }
    if (response != null) {
      _result.response = response;
    }
    if (materialId != null) {
      _result.materialId = materialId;
    }
    return _result;
  }
  factory MaterialFeedback.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MaterialFeedback.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MaterialFeedback clone() => MaterialFeedback()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MaterialFeedback copyWith(void Function(MaterialFeedback) updates) => super.copyWith((message) => updates(message as MaterialFeedback)) as MaterialFeedback; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MaterialFeedback create() => MaterialFeedback._();
  MaterialFeedback createEmptyInstance() => create();
  static $pb.PbList<MaterialFeedback> createRepeated() => $pb.PbList<MaterialFeedback>();
  @$core.pragma('dart2js:noInline')
  static MaterialFeedback getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MaterialFeedback>(create);
  static MaterialFeedback? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  MaterialFeedback_Type get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(MaterialFeedback_Type v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get reporterId => $_getSZ(2);
  @$pb.TagNumber(3)
  set reporterId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReporterId() => $_has(2);
  @$pb.TagNumber(3)
  void clearReporterId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get report => $_getSZ(3);
  @$pb.TagNumber(4)
  set report($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReport() => $_has(3);
  @$pb.TagNumber(4)
  void clearReport() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get response => $_getSZ(4);
  @$pb.TagNumber(5)
  set response($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasResponse() => $_has(4);
  @$pb.TagNumber(5)
  void clearResponse() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get materialId => $_getSZ(5);
  @$pb.TagNumber(6)
  set materialId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaterialId() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaterialId() => clearField(6);
}

class MaterialTopic extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MaterialTopic', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  MaterialTopic._() : super();
  factory MaterialTopic({
    $core.String? id,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory MaterialTopic.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MaterialTopic.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MaterialTopic clone() => MaterialTopic()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MaterialTopic copyWith(void Function(MaterialTopic) updates) => super.copyWith((message) => updates(message as MaterialTopic)) as MaterialTopic; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MaterialTopic create() => MaterialTopic._();
  MaterialTopic createEmptyInstance() => create();
  static $pb.PbList<MaterialTopic> createRepeated() => $pb.PbList<MaterialTopic>();
  @$core.pragma('dart2js:noInline')
  static MaterialTopic getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MaterialTopic>(create);
  static MaterialTopic? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class MaterialType extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MaterialType', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  MaterialType._() : super();
  factory MaterialType({
    $core.String? id,
    $core.String? name,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory MaterialType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MaterialType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MaterialType clone() => MaterialType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MaterialType copyWith(void Function(MaterialType) updates) => super.copyWith((message) => updates(message as MaterialType)) as MaterialType; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MaterialType create() => MaterialType._();
  MaterialType createEmptyInstance() => create();
  static $pb.PbList<MaterialType> createRepeated() => $pb.PbList<MaterialType>();
  @$core.pragma('dart2js:noInline')
  static MaterialType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MaterialType>(create);
  static MaterialType? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);
}

class Output extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Output', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<$2.Date>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', subBuilder: $2.Date.create)
    ..aInt64(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOM<OutputMarker>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'outputMarker', subBuilder: OutputMarker.create)
    ..hasRequiredFields = false
  ;

  Output._() : super();
  factory Output({
    $core.String? groupId,
    $core.String? id,
    $2.Date? month,
    $fixnum.Int64? value,
    OutputMarker? outputMarker,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (id != null) {
      _result.id = id;
    }
    if (month != null) {
      _result.month = month;
    }
    if (value != null) {
      _result.value = value;
    }
    if (outputMarker != null) {
      _result.outputMarker = outputMarker;
    }
    return _result;
  }
  factory Output.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Output.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Output clone() => Output()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Output copyWith(void Function(Output) updates) => super.copyWith((message) => updates(message as Output)) as Output; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Output create() => Output._();
  Output createEmptyInstance() => create();
  static $pb.PbList<Output> createRepeated() => $pb.PbList<Output>();
  @$core.pragma('dart2js:noInline')
  static Output getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Output>(create);
  static Output? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(1)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(1)
  void clearGroupId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(5)
  $2.Date get month => $_getN(2);
  @$pb.TagNumber(5)
  set month($2.Date v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMonth() => $_has(2);
  @$pb.TagNumber(5)
  void clearMonth() => clearField(5);
  @$pb.TagNumber(5)
  $2.Date ensureMonth() => $_ensure(2);

  @$pb.TagNumber(6)
  $fixnum.Int64 get value => $_getI64(3);
  @$pb.TagNumber(6)
  set value($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasValue() => $_has(3);
  @$pb.TagNumber(6)
  void clearValue() => clearField(6);

  @$pb.TagNumber(7)
  OutputMarker get outputMarker => $_getN(4);
  @$pb.TagNumber(7)
  set outputMarker(OutputMarker v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasOutputMarker() => $_has(4);
  @$pb.TagNumber(7)
  void clearOutputMarker() => clearField(7);
  @$pb.TagNumber(7)
  OutputMarker ensureOutputMarker() => $_ensure(4);
}

class OutputMarker extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'OutputMarker', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'markerId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'markerName')
    ..hasRequiredFields = false
  ;

  OutputMarker._() : super();
  factory OutputMarker({
    $core.String? projectId,
    $core.String? markerId,
    $core.String? markerName,
  }) {
    final _result = create();
    if (projectId != null) {
      _result.projectId = projectId;
    }
    if (markerId != null) {
      _result.markerId = markerId;
    }
    if (markerName != null) {
      _result.markerName = markerName;
    }
    return _result;
  }
  factory OutputMarker.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OutputMarker.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OutputMarker clone() => OutputMarker()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OutputMarker copyWith(void Function(OutputMarker) updates) => super.copyWith((message) => updates(message as OutputMarker)) as OutputMarker; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static OutputMarker create() => OutputMarker._();
  OutputMarker createEmptyInstance() => create();
  static $pb.PbList<OutputMarker> createRepeated() => $pb.PbList<OutputMarker>();
  @$core.pragma('dart2js:noInline')
  static OutputMarker getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutputMarker>(create);
  static OutputMarker? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get projectId => $_getSZ(0);
  @$pb.TagNumber(2)
  set projectId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasProjectId() => $_has(0);
  @$pb.TagNumber(2)
  void clearProjectId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get markerId => $_getSZ(1);
  @$pb.TagNumber(3)
  set markerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasMarkerId() => $_has(1);
  @$pb.TagNumber(3)
  void clearMarkerId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get markerName => $_getSZ(2);
  @$pb.TagNumber(4)
  set markerName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasMarkerName() => $_has(2);
  @$pb.TagNumber(4)
  void clearMarkerName() => clearField(4);
}

class RefreshSessionRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RefreshSessionRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'refreshToken')
    ..hasRequiredFields = false
  ;

  RefreshSessionRequest._() : super();
  factory RefreshSessionRequest({
    $core.String? userId,
    $core.String? refreshToken,
  }) {
    final _result = create();
    if (userId != null) {
      _result.userId = userId;
    }
    if (refreshToken != null) {
      _result.refreshToken = refreshToken;
    }
    return _result;
  }
  factory RefreshSessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RefreshSessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RefreshSessionRequest clone() => RefreshSessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RefreshSessionRequest copyWith(void Function(RefreshSessionRequest) updates) => super.copyWith((message) => updates(message as RefreshSessionRequest)) as RefreshSessionRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RefreshSessionRequest create() => RefreshSessionRequest._();
  RefreshSessionRequest createEmptyInstance() => create();
  static $pb.PbList<RefreshSessionRequest> createRepeated() => $pb.PbList<RefreshSessionRequest>();
  @$core.pragma('dart2js:noInline')
  static RefreshSessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RefreshSessionRequest>(create);
  static RefreshSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get refreshToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set refreshToken($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRefreshToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearRefreshToken() => clearField(2);
}

class SyncRequestMetaData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncRequestMetaData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'getNewRecords')
    ..aOM<$3.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedSince', subBuilder: $3.Timestamp.create)
    ..pc<ResourceType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resourceTypeWhitelist', $pb.PbFieldType.KE, valueOf: ResourceType.valueOf, enumValues: ResourceType.values, defaultEnumValue: ResourceType.TYPE_UNSPECIFIED)
    ..pc<ResourceType>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'resourceTypeBlacklist', $pb.PbFieldType.KE, valueOf: ResourceType.valueOf, enumValues: ResourceType.values, defaultEnumValue: ResourceType.TYPE_UNSPECIFIED)
    ..hasRequiredFields = false
  ;

  SyncRequestMetaData._() : super();
  factory SyncRequestMetaData({
    $core.bool? getNewRecords,
    $3.Timestamp? updatedSince,
    $core.Iterable<ResourceType>? resourceTypeWhitelist,
    $core.Iterable<ResourceType>? resourceTypeBlacklist,
  }) {
    final _result = create();
    if (getNewRecords != null) {
      _result.getNewRecords = getNewRecords;
    }
    if (updatedSince != null) {
      _result.updatedSince = updatedSince;
    }
    if (resourceTypeWhitelist != null) {
      _result.resourceTypeWhitelist.addAll(resourceTypeWhitelist);
    }
    if (resourceTypeBlacklist != null) {
      _result.resourceTypeBlacklist.addAll(resourceTypeBlacklist);
    }
    return _result;
  }
  factory SyncRequestMetaData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncRequestMetaData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncRequestMetaData clone() => SyncRequestMetaData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncRequestMetaData copyWith(void Function(SyncRequestMetaData) updates) => super.copyWith((message) => updates(message as SyncRequestMetaData)) as SyncRequestMetaData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncRequestMetaData create() => SyncRequestMetaData._();
  SyncRequestMetaData createEmptyInstance() => create();
  static $pb.PbList<SyncRequestMetaData> createRepeated() => $pb.PbList<SyncRequestMetaData>();
  @$core.pragma('dart2js:noInline')
  static SyncRequestMetaData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncRequestMetaData>(create);
  static SyncRequestMetaData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get getNewRecords => $_getBF(0);
  @$pb.TagNumber(1)
  set getNewRecords($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGetNewRecords() => $_has(0);
  @$pb.TagNumber(1)
  void clearGetNewRecords() => clearField(1);

  @$pb.TagNumber(2)
  $3.Timestamp get updatedSince => $_getN(1);
  @$pb.TagNumber(2)
  set updatedSince($3.Timestamp v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdatedSince() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdatedSince() => clearField(2);
  @$pb.TagNumber(2)
  $3.Timestamp ensureUpdatedSince() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.List<ResourceType> get resourceTypeWhitelist => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<ResourceType> get resourceTypeBlacklist => $_getList(3);
}

class SyncResponseMetaData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncResponseMetaData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<$3.Timestamp>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'requestTime', subBuilder: $3.Timestamp.create)
    ..hasRequiredFields = false
  ;

  SyncResponseMetaData._() : super();
  factory SyncResponseMetaData({
    $3.Timestamp? requestTime,
  }) {
    final _result = create();
    if (requestTime != null) {
      _result.requestTime = requestTime;
    }
    return _result;
  }
  factory SyncResponseMetaData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncResponseMetaData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncResponseMetaData clone() => SyncResponseMetaData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncResponseMetaData copyWith(void Function(SyncResponseMetaData) updates) => super.copyWith((message) => updates(message as SyncResponseMetaData)) as SyncResponseMetaData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncResponseMetaData create() => SyncResponseMetaData._();
  SyncResponseMetaData createEmptyInstance() => create();
  static $pb.PbList<SyncResponseMetaData> createRepeated() => $pb.PbList<SyncResponseMetaData>();
  @$core.pragma('dart2js:noInline')
  static SyncResponseMetaData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncResponseMetaData>(create);
  static SyncResponseMetaData? _defaultInstance;

  @$pb.TagNumber(1)
  $3.Timestamp get requestTime => $_getN(0);
  @$pb.TagNumber(1)
  set requestTime($3.Timestamp v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestTime() => clearField(1);
  @$pb.TagNumber(1)
  $3.Timestamp ensureRequestTime() => $_ensure(0);
}

enum SyncRequest_Update {
  metaData, 
  createMaterialFeedback, 
  createUpdateAction, 
  createUpdateActionUser, 
  createUpdateGroupEvaluation, 
  createUpdateGroup, 
  createUpdateGroupUser, 
  createUpdateLearnerEvaluation, 
  createUpdateMaterial, 
  createUpdateOutput, 
  createUpdateTeacherResponse, 
  createUpdateTransformation, 
  createUpdateUser, 
  deleteAction, 
  deleteGroupUser, 
  deleteMaterial, 
  updateCurrentUser, 
  notSet
}

class SyncRequest extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SyncRequest_Update> _SyncRequest_UpdateByTag = {
    1 : SyncRequest_Update.metaData,
    2 : SyncRequest_Update.createMaterialFeedback,
    3 : SyncRequest_Update.createUpdateAction,
    4 : SyncRequest_Update.createUpdateActionUser,
    5 : SyncRequest_Update.createUpdateGroupEvaluation,
    6 : SyncRequest_Update.createUpdateGroup,
    7 : SyncRequest_Update.createUpdateGroupUser,
    8 : SyncRequest_Update.createUpdateLearnerEvaluation,
    9 : SyncRequest_Update.createUpdateMaterial,
    10 : SyncRequest_Update.createUpdateOutput,
    11 : SyncRequest_Update.createUpdateTeacherResponse,
    12 : SyncRequest_Update.createUpdateTransformation,
    13 : SyncRequest_Update.createUpdateUser,
    14 : SyncRequest_Update.deleteAction,
    15 : SyncRequest_Update.deleteGroupUser,
    16 : SyncRequest_Update.deleteMaterial,
    17 : SyncRequest_Update.updateCurrentUser,
    0 : SyncRequest_Update.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])
    ..aOM<SyncRequestMetaData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaData', subBuilder: SyncRequestMetaData.create)
    ..aOM<CreateMaterialFeedbacksRequest>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createMaterialFeedback', subBuilder: CreateMaterialFeedbacksRequest.create)
    ..aOM<CreateUpdateActionsRequest>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateAction', subBuilder: CreateUpdateActionsRequest.create)
    ..aOM<CreateUpdateActionUserRequest>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateActionUser', subBuilder: CreateUpdateActionUserRequest.create)
    ..aOM<CreateUpdateGroupEvaluationRequest>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateGroupEvaluation', subBuilder: CreateUpdateGroupEvaluationRequest.create)
    ..aOM<CreateUpdateGroupsRequest>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateGroup', subBuilder: CreateUpdateGroupsRequest.create)
    ..aOM<CreateUpdateGroupUsersRequest>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateGroupUser', subBuilder: CreateUpdateGroupUsersRequest.create)
    ..aOM<CreateUpdateLearnerEvaluationRequest>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateLearnerEvaluation', subBuilder: CreateUpdateLearnerEvaluationRequest.create)
    ..aOM<CreateUpdateMaterialsRequest>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateMaterial', subBuilder: CreateUpdateMaterialsRequest.create)
    ..aOM<CreateUpdateOutputRequest>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateOutput', subBuilder: CreateUpdateOutputRequest.create)
    ..aOM<CreateUpdateTeacherResponseRequest>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateTeacherResponse', subBuilder: CreateUpdateTeacherResponseRequest.create)
    ..aOM<CreateUpdateTransformationRequest>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateTransformation', subBuilder: CreateUpdateTransformationRequest.create)
    ..aOM<CreateUpdateUserRequest>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createUpdateUser', subBuilder: CreateUpdateUserRequest.create)
    ..aOM<DeleteActionRequest>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deleteAction', subBuilder: DeleteActionRequest.create)
    ..aOM<GroupUser>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deleteGroupUser', subBuilder: GroupUser.create)
    ..aOM<DeleteMaterialRequest>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deleteMaterial', subBuilder: DeleteMaterialRequest.create)
    ..aOM<UpdateCurrentUserRequest>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateCurrentUser', subBuilder: UpdateCurrentUserRequest.create)
    ..hasRequiredFields = false
  ;

  SyncRequest._() : super();
  factory SyncRequest({
    SyncRequestMetaData? metaData,
    CreateMaterialFeedbacksRequest? createMaterialFeedback,
    CreateUpdateActionsRequest? createUpdateAction,
    CreateUpdateActionUserRequest? createUpdateActionUser,
    CreateUpdateGroupEvaluationRequest? createUpdateGroupEvaluation,
    CreateUpdateGroupsRequest? createUpdateGroup,
    CreateUpdateGroupUsersRequest? createUpdateGroupUser,
    CreateUpdateLearnerEvaluationRequest? createUpdateLearnerEvaluation,
    CreateUpdateMaterialsRequest? createUpdateMaterial,
    CreateUpdateOutputRequest? createUpdateOutput,
    CreateUpdateTeacherResponseRequest? createUpdateTeacherResponse,
    CreateUpdateTransformationRequest? createUpdateTransformation,
    CreateUpdateUserRequest? createUpdateUser,
    DeleteActionRequest? deleteAction,
    GroupUser? deleteGroupUser,
    DeleteMaterialRequest? deleteMaterial,
    UpdateCurrentUserRequest? updateCurrentUser,
  }) {
    final _result = create();
    if (metaData != null) {
      _result.metaData = metaData;
    }
    if (createMaterialFeedback != null) {
      _result.createMaterialFeedback = createMaterialFeedback;
    }
    if (createUpdateAction != null) {
      _result.createUpdateAction = createUpdateAction;
    }
    if (createUpdateActionUser != null) {
      _result.createUpdateActionUser = createUpdateActionUser;
    }
    if (createUpdateGroupEvaluation != null) {
      _result.createUpdateGroupEvaluation = createUpdateGroupEvaluation;
    }
    if (createUpdateGroup != null) {
      _result.createUpdateGroup = createUpdateGroup;
    }
    if (createUpdateGroupUser != null) {
      _result.createUpdateGroupUser = createUpdateGroupUser;
    }
    if (createUpdateLearnerEvaluation != null) {
      _result.createUpdateLearnerEvaluation = createUpdateLearnerEvaluation;
    }
    if (createUpdateMaterial != null) {
      _result.createUpdateMaterial = createUpdateMaterial;
    }
    if (createUpdateOutput != null) {
      _result.createUpdateOutput = createUpdateOutput;
    }
    if (createUpdateTeacherResponse != null) {
      _result.createUpdateTeacherResponse = createUpdateTeacherResponse;
    }
    if (createUpdateTransformation != null) {
      _result.createUpdateTransformation = createUpdateTransformation;
    }
    if (createUpdateUser != null) {
      _result.createUpdateUser = createUpdateUser;
    }
    if (deleteAction != null) {
      _result.deleteAction = deleteAction;
    }
    if (deleteGroupUser != null) {
      _result.deleteGroupUser = deleteGroupUser;
    }
    if (deleteMaterial != null) {
      _result.deleteMaterial = deleteMaterial;
    }
    if (updateCurrentUser != null) {
      _result.updateCurrentUser = updateCurrentUser;
    }
    return _result;
  }
  factory SyncRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncRequest clone() => SyncRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncRequest copyWith(void Function(SyncRequest) updates) => super.copyWith((message) => updates(message as SyncRequest)) as SyncRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncRequest create() => SyncRequest._();
  SyncRequest createEmptyInstance() => create();
  static $pb.PbList<SyncRequest> createRepeated() => $pb.PbList<SyncRequest>();
  @$core.pragma('dart2js:noInline')
  static SyncRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncRequest>(create);
  static SyncRequest? _defaultInstance;

  SyncRequest_Update whichUpdate() => _SyncRequest_UpdateByTag[$_whichOneof(0)]!;
  void clearUpdate() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  SyncRequestMetaData get metaData => $_getN(0);
  @$pb.TagNumber(1)
  set metaData(SyncRequestMetaData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMetaData() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetaData() => clearField(1);
  @$pb.TagNumber(1)
  SyncRequestMetaData ensureMetaData() => $_ensure(0);

  @$pb.TagNumber(2)
  CreateMaterialFeedbacksRequest get createMaterialFeedback => $_getN(1);
  @$pb.TagNumber(2)
  set createMaterialFeedback(CreateMaterialFeedbacksRequest v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCreateMaterialFeedback() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreateMaterialFeedback() => clearField(2);
  @$pb.TagNumber(2)
  CreateMaterialFeedbacksRequest ensureCreateMaterialFeedback() => $_ensure(1);

  @$pb.TagNumber(3)
  CreateUpdateActionsRequest get createUpdateAction => $_getN(2);
  @$pb.TagNumber(3)
  set createUpdateAction(CreateUpdateActionsRequest v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCreateUpdateAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreateUpdateAction() => clearField(3);
  @$pb.TagNumber(3)
  CreateUpdateActionsRequest ensureCreateUpdateAction() => $_ensure(2);

  @$pb.TagNumber(4)
  CreateUpdateActionUserRequest get createUpdateActionUser => $_getN(3);
  @$pb.TagNumber(4)
  set createUpdateActionUser(CreateUpdateActionUserRequest v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCreateUpdateActionUser() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreateUpdateActionUser() => clearField(4);
  @$pb.TagNumber(4)
  CreateUpdateActionUserRequest ensureCreateUpdateActionUser() => $_ensure(3);

  @$pb.TagNumber(5)
  CreateUpdateGroupEvaluationRequest get createUpdateGroupEvaluation => $_getN(4);
  @$pb.TagNumber(5)
  set createUpdateGroupEvaluation(CreateUpdateGroupEvaluationRequest v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCreateUpdateGroupEvaluation() => $_has(4);
  @$pb.TagNumber(5)
  void clearCreateUpdateGroupEvaluation() => clearField(5);
  @$pb.TagNumber(5)
  CreateUpdateGroupEvaluationRequest ensureCreateUpdateGroupEvaluation() => $_ensure(4);

  @$pb.TagNumber(6)
  CreateUpdateGroupsRequest get createUpdateGroup => $_getN(5);
  @$pb.TagNumber(6)
  set createUpdateGroup(CreateUpdateGroupsRequest v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreateUpdateGroup() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreateUpdateGroup() => clearField(6);
  @$pb.TagNumber(6)
  CreateUpdateGroupsRequest ensureCreateUpdateGroup() => $_ensure(5);

  @$pb.TagNumber(7)
  CreateUpdateGroupUsersRequest get createUpdateGroupUser => $_getN(6);
  @$pb.TagNumber(7)
  set createUpdateGroupUser(CreateUpdateGroupUsersRequest v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreateUpdateGroupUser() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreateUpdateGroupUser() => clearField(7);
  @$pb.TagNumber(7)
  CreateUpdateGroupUsersRequest ensureCreateUpdateGroupUser() => $_ensure(6);

  @$pb.TagNumber(8)
  CreateUpdateLearnerEvaluationRequest get createUpdateLearnerEvaluation => $_getN(7);
  @$pb.TagNumber(8)
  set createUpdateLearnerEvaluation(CreateUpdateLearnerEvaluationRequest v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreateUpdateLearnerEvaluation() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreateUpdateLearnerEvaluation() => clearField(8);
  @$pb.TagNumber(8)
  CreateUpdateLearnerEvaluationRequest ensureCreateUpdateLearnerEvaluation() => $_ensure(7);

  @$pb.TagNumber(9)
  CreateUpdateMaterialsRequest get createUpdateMaterial => $_getN(8);
  @$pb.TagNumber(9)
  set createUpdateMaterial(CreateUpdateMaterialsRequest v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCreateUpdateMaterial() => $_has(8);
  @$pb.TagNumber(9)
  void clearCreateUpdateMaterial() => clearField(9);
  @$pb.TagNumber(9)
  CreateUpdateMaterialsRequest ensureCreateUpdateMaterial() => $_ensure(8);

  @$pb.TagNumber(10)
  CreateUpdateOutputRequest get createUpdateOutput => $_getN(9);
  @$pb.TagNumber(10)
  set createUpdateOutput(CreateUpdateOutputRequest v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreateUpdateOutput() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreateUpdateOutput() => clearField(10);
  @$pb.TagNumber(10)
  CreateUpdateOutputRequest ensureCreateUpdateOutput() => $_ensure(9);

  @$pb.TagNumber(11)
  CreateUpdateTeacherResponseRequest get createUpdateTeacherResponse => $_getN(10);
  @$pb.TagNumber(11)
  set createUpdateTeacherResponse(CreateUpdateTeacherResponseRequest v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreateUpdateTeacherResponse() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreateUpdateTeacherResponse() => clearField(11);
  @$pb.TagNumber(11)
  CreateUpdateTeacherResponseRequest ensureCreateUpdateTeacherResponse() => $_ensure(10);

  @$pb.TagNumber(12)
  CreateUpdateTransformationRequest get createUpdateTransformation => $_getN(11);
  @$pb.TagNumber(12)
  set createUpdateTransformation(CreateUpdateTransformationRequest v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCreateUpdateTransformation() => $_has(11);
  @$pb.TagNumber(12)
  void clearCreateUpdateTransformation() => clearField(12);
  @$pb.TagNumber(12)
  CreateUpdateTransformationRequest ensureCreateUpdateTransformation() => $_ensure(11);

  @$pb.TagNumber(13)
  CreateUpdateUserRequest get createUpdateUser => $_getN(12);
  @$pb.TagNumber(13)
  set createUpdateUser(CreateUpdateUserRequest v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreateUpdateUser() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreateUpdateUser() => clearField(13);
  @$pb.TagNumber(13)
  CreateUpdateUserRequest ensureCreateUpdateUser() => $_ensure(12);

  @$pb.TagNumber(14)
  DeleteActionRequest get deleteAction => $_getN(13);
  @$pb.TagNumber(14)
  set deleteAction(DeleteActionRequest v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasDeleteAction() => $_has(13);
  @$pb.TagNumber(14)
  void clearDeleteAction() => clearField(14);
  @$pb.TagNumber(14)
  DeleteActionRequest ensureDeleteAction() => $_ensure(13);

  @$pb.TagNumber(15)
  GroupUser get deleteGroupUser => $_getN(14);
  @$pb.TagNumber(15)
  set deleteGroupUser(GroupUser v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasDeleteGroupUser() => $_has(14);
  @$pb.TagNumber(15)
  void clearDeleteGroupUser() => clearField(15);
  @$pb.TagNumber(15)
  GroupUser ensureDeleteGroupUser() => $_ensure(14);

  @$pb.TagNumber(16)
  DeleteMaterialRequest get deleteMaterial => $_getN(15);
  @$pb.TagNumber(16)
  set deleteMaterial(DeleteMaterialRequest v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasDeleteMaterial() => $_has(15);
  @$pb.TagNumber(16)
  void clearDeleteMaterial() => clearField(16);
  @$pb.TagNumber(16)
  DeleteMaterialRequest ensureDeleteMaterial() => $_ensure(15);

  @$pb.TagNumber(17)
  UpdateCurrentUserRequest get updateCurrentUser => $_getN(16);
  @$pb.TagNumber(17)
  set updateCurrentUser(UpdateCurrentUserRequest v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasUpdateCurrentUser() => $_has(16);
  @$pb.TagNumber(17)
  void clearUpdateCurrentUser() => clearField(17);
  @$pb.TagNumber(17)
  UpdateCurrentUserRequest ensureUpdateCurrentUser() => $_ensure(16);
}

enum SyncResponse_Value {
  action, 
  country, 
  evaluationCategory, 
  group, 
  groupEvaluation, 
  language, 
  learnerEvaluation, 
  material, 
  materialTopic, 
  materialType, 
  output, 
  teacherResponse, 
  transformation, 
  user, 
  deletedRecord, 
  metaData, 
  notSet
}

class SyncResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SyncResponse_Value> _SyncResponse_ValueByTag = {
    1 : SyncResponse_Value.action,
    2 : SyncResponse_Value.country,
    3 : SyncResponse_Value.evaluationCategory,
    4 : SyncResponse_Value.group,
    5 : SyncResponse_Value.groupEvaluation,
    7 : SyncResponse_Value.language,
    8 : SyncResponse_Value.learnerEvaluation,
    9 : SyncResponse_Value.material,
    10 : SyncResponse_Value.materialTopic,
    11 : SyncResponse_Value.materialType,
    12 : SyncResponse_Value.output,
    13 : SyncResponse_Value.teacherResponse,
    14 : SyncResponse_Value.transformation,
    15 : SyncResponse_Value.user,
    16 : SyncResponse_Value.deletedRecord,
    17 : SyncResponse_Value.metaData,
    0 : SyncResponse_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'SyncResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17])
    ..aOM<Action>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'action', subBuilder: Action.create)
    ..aOM<Country>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country', subBuilder: Country.create)
    ..aOM<EvaluationCategory>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'evaluationCategory', subBuilder: EvaluationCategory.create)
    ..aOM<Group>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'group', subBuilder: Group.create)
    ..aOM<GroupEvaluation>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupEvaluation', subBuilder: GroupEvaluation.create)
    ..aOM<Language>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language', subBuilder: Language.create)
    ..aOM<LearnerEvaluation>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'learnerEvaluation', subBuilder: LearnerEvaluation.create)
    ..aOM<Material>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'material', subBuilder: Material.create)
    ..aOM<MaterialTopic>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'materialTopic', subBuilder: MaterialTopic.create)
    ..aOM<MaterialType>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'materialType', subBuilder: MaterialType.create)
    ..aOM<Output>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'output', subBuilder: Output.create)
    ..aOM<TeacherResponse>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'teacherResponse', subBuilder: TeacherResponse.create)
    ..aOM<Transformation>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transformation', subBuilder: Transformation.create)
    ..aOM<User>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOM<DeletedResource>(16, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deletedRecord', subBuilder: DeletedResource.create)
    ..aOM<SyncResponseMetaData>(17, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaData', subBuilder: SyncResponseMetaData.create)
    ..hasRequiredFields = false
  ;

  SyncResponse._() : super();
  factory SyncResponse({
    Action? action,
    Country? country,
    EvaluationCategory? evaluationCategory,
    Group? group,
    GroupEvaluation? groupEvaluation,
    Language? language,
    LearnerEvaluation? learnerEvaluation,
    Material? material,
    MaterialTopic? materialTopic,
    MaterialType? materialType,
    Output? output,
    TeacherResponse? teacherResponse,
    Transformation? transformation,
    User? user,
    DeletedResource? deletedRecord,
    SyncResponseMetaData? metaData,
  }) {
    final _result = create();
    if (action != null) {
      _result.action = action;
    }
    if (country != null) {
      _result.country = country;
    }
    if (evaluationCategory != null) {
      _result.evaluationCategory = evaluationCategory;
    }
    if (group != null) {
      _result.group = group;
    }
    if (groupEvaluation != null) {
      _result.groupEvaluation = groupEvaluation;
    }
    if (language != null) {
      _result.language = language;
    }
    if (learnerEvaluation != null) {
      _result.learnerEvaluation = learnerEvaluation;
    }
    if (material != null) {
      _result.material = material;
    }
    if (materialTopic != null) {
      _result.materialTopic = materialTopic;
    }
    if (materialType != null) {
      _result.materialType = materialType;
    }
    if (output != null) {
      _result.output = output;
    }
    if (teacherResponse != null) {
      _result.teacherResponse = teacherResponse;
    }
    if (transformation != null) {
      _result.transformation = transformation;
    }
    if (user != null) {
      _result.user = user;
    }
    if (deletedRecord != null) {
      _result.deletedRecord = deletedRecord;
    }
    if (metaData != null) {
      _result.metaData = metaData;
    }
    return _result;
  }
  factory SyncResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SyncResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SyncResponse clone() => SyncResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SyncResponse copyWith(void Function(SyncResponse) updates) => super.copyWith((message) => updates(message as SyncResponse)) as SyncResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SyncResponse create() => SyncResponse._();
  SyncResponse createEmptyInstance() => create();
  static $pb.PbList<SyncResponse> createRepeated() => $pb.PbList<SyncResponse>();
  @$core.pragma('dart2js:noInline')
  static SyncResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SyncResponse>(create);
  static SyncResponse? _defaultInstance;

  SyncResponse_Value whichValue() => _SyncResponse_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Action get action => $_getN(0);
  @$pb.TagNumber(1)
  set action(Action v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAction() => $_has(0);
  @$pb.TagNumber(1)
  void clearAction() => clearField(1);
  @$pb.TagNumber(1)
  Action ensureAction() => $_ensure(0);

  @$pb.TagNumber(2)
  Country get country => $_getN(1);
  @$pb.TagNumber(2)
  set country(Country v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCountry() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountry() => clearField(2);
  @$pb.TagNumber(2)
  Country ensureCountry() => $_ensure(1);

  @$pb.TagNumber(3)
  EvaluationCategory get evaluationCategory => $_getN(2);
  @$pb.TagNumber(3)
  set evaluationCategory(EvaluationCategory v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasEvaluationCategory() => $_has(2);
  @$pb.TagNumber(3)
  void clearEvaluationCategory() => clearField(3);
  @$pb.TagNumber(3)
  EvaluationCategory ensureEvaluationCategory() => $_ensure(2);

  @$pb.TagNumber(4)
  Group get group => $_getN(3);
  @$pb.TagNumber(4)
  set group(Group v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasGroup() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroup() => clearField(4);
  @$pb.TagNumber(4)
  Group ensureGroup() => $_ensure(3);

  @$pb.TagNumber(5)
  GroupEvaluation get groupEvaluation => $_getN(4);
  @$pb.TagNumber(5)
  set groupEvaluation(GroupEvaluation v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasGroupEvaluation() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupEvaluation() => clearField(5);
  @$pb.TagNumber(5)
  GroupEvaluation ensureGroupEvaluation() => $_ensure(4);

  @$pb.TagNumber(7)
  Language get language => $_getN(5);
  @$pb.TagNumber(7)
  set language(Language v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasLanguage() => $_has(5);
  @$pb.TagNumber(7)
  void clearLanguage() => clearField(7);
  @$pb.TagNumber(7)
  Language ensureLanguage() => $_ensure(5);

  @$pb.TagNumber(8)
  LearnerEvaluation get learnerEvaluation => $_getN(6);
  @$pb.TagNumber(8)
  set learnerEvaluation(LearnerEvaluation v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasLearnerEvaluation() => $_has(6);
  @$pb.TagNumber(8)
  void clearLearnerEvaluation() => clearField(8);
  @$pb.TagNumber(8)
  LearnerEvaluation ensureLearnerEvaluation() => $_ensure(6);

  @$pb.TagNumber(9)
  Material get material => $_getN(7);
  @$pb.TagNumber(9)
  set material(Material v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasMaterial() => $_has(7);
  @$pb.TagNumber(9)
  void clearMaterial() => clearField(9);
  @$pb.TagNumber(9)
  Material ensureMaterial() => $_ensure(7);

  @$pb.TagNumber(10)
  MaterialTopic get materialTopic => $_getN(8);
  @$pb.TagNumber(10)
  set materialTopic(MaterialTopic v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasMaterialTopic() => $_has(8);
  @$pb.TagNumber(10)
  void clearMaterialTopic() => clearField(10);
  @$pb.TagNumber(10)
  MaterialTopic ensureMaterialTopic() => $_ensure(8);

  @$pb.TagNumber(11)
  MaterialType get materialType => $_getN(9);
  @$pb.TagNumber(11)
  set materialType(MaterialType v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasMaterialType() => $_has(9);
  @$pb.TagNumber(11)
  void clearMaterialType() => clearField(11);
  @$pb.TagNumber(11)
  MaterialType ensureMaterialType() => $_ensure(9);

  @$pb.TagNumber(12)
  Output get output => $_getN(10);
  @$pb.TagNumber(12)
  set output(Output v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasOutput() => $_has(10);
  @$pb.TagNumber(12)
  void clearOutput() => clearField(12);
  @$pb.TagNumber(12)
  Output ensureOutput() => $_ensure(10);

  @$pb.TagNumber(13)
  TeacherResponse get teacherResponse => $_getN(11);
  @$pb.TagNumber(13)
  set teacherResponse(TeacherResponse v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasTeacherResponse() => $_has(11);
  @$pb.TagNumber(13)
  void clearTeacherResponse() => clearField(13);
  @$pb.TagNumber(13)
  TeacherResponse ensureTeacherResponse() => $_ensure(11);

  @$pb.TagNumber(14)
  Transformation get transformation => $_getN(12);
  @$pb.TagNumber(14)
  set transformation(Transformation v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasTransformation() => $_has(12);
  @$pb.TagNumber(14)
  void clearTransformation() => clearField(14);
  @$pb.TagNumber(14)
  Transformation ensureTransformation() => $_ensure(12);

  @$pb.TagNumber(15)
  User get user => $_getN(13);
  @$pb.TagNumber(15)
  set user(User v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasUser() => $_has(13);
  @$pb.TagNumber(15)
  void clearUser() => clearField(15);
  @$pb.TagNumber(15)
  User ensureUser() => $_ensure(13);

  @$pb.TagNumber(16)
  DeletedResource get deletedRecord => $_getN(14);
  @$pb.TagNumber(16)
  set deletedRecord(DeletedResource v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasDeletedRecord() => $_has(14);
  @$pb.TagNumber(16)
  void clearDeletedRecord() => clearField(16);
  @$pb.TagNumber(16)
  DeletedResource ensureDeletedRecord() => $_ensure(14);

  @$pb.TagNumber(17)
  SyncResponseMetaData get metaData => $_getN(15);
  @$pb.TagNumber(17)
  set metaData(SyncResponseMetaData v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasMetaData() => $_has(15);
  @$pb.TagNumber(17)
  void clearMetaData() => clearField(17);
  @$pb.TagNumber(17)
  SyncResponseMetaData ensureMetaData() => $_ensure(15);
}

class TeacherResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TeacherResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'learnerId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'teacherId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOM<$2.Date>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', subBuilder: $2.Date.create)
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'response')
    ..hasRequiredFields = false
  ;

  TeacherResponse._() : super();
  factory TeacherResponse({
    $core.String? id,
    $core.String? learnerId,
    $core.String? teacherId,
    $core.String? groupId,
    $2.Date? month,
    $core.String? response,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (learnerId != null) {
      _result.learnerId = learnerId;
    }
    if (teacherId != null) {
      _result.teacherId = teacherId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (month != null) {
      _result.month = month;
    }
    if (response != null) {
      _result.response = response;
    }
    return _result;
  }
  factory TeacherResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TeacherResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TeacherResponse clone() => TeacherResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TeacherResponse copyWith(void Function(TeacherResponse) updates) => super.copyWith((message) => updates(message as TeacherResponse)) as TeacherResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TeacherResponse create() => TeacherResponse._();
  TeacherResponse createEmptyInstance() => create();
  static $pb.PbList<TeacherResponse> createRepeated() => $pb.PbList<TeacherResponse>();
  @$core.pragma('dart2js:noInline')
  static TeacherResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TeacherResponse>(create);
  static TeacherResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get learnerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set learnerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLearnerId() => $_has(1);
  @$pb.TagNumber(2)
  void clearLearnerId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get teacherId => $_getSZ(2);
  @$pb.TagNumber(3)
  set teacherId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTeacherId() => $_has(2);
  @$pb.TagNumber(3)
  void clearTeacherId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get groupId => $_getSZ(3);
  @$pb.TagNumber(4)
  set groupId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGroupId() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroupId() => clearField(4);

  @$pb.TagNumber(5)
  $2.Date get month => $_getN(4);
  @$pb.TagNumber(5)
  set month($2.Date v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMonth() => $_has(4);
  @$pb.TagNumber(5)
  void clearMonth() => clearField(5);
  @$pb.TagNumber(5)
  $2.Date ensureMonth() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.String get response => $_getSZ(5);
  @$pb.TagNumber(6)
  set response($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasResponse() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponse() => clearField(6);
}

class Transformation extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Transformation', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOM<$2.Date>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', subBuilder: $2.Date.create)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'impactStory')
    ..pPS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'files')
    ..hasRequiredFields = false
  ;

  Transformation._() : super();
  factory Transformation({
    $core.String? id,
    $core.String? userId,
    $core.String? groupId,
    $2.Date? month,
    $core.String? impactStory,
    $core.Iterable<$core.String>? files,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (month != null) {
      _result.month = month;
    }
    if (impactStory != null) {
      _result.impactStory = impactStory;
    }
    if (files != null) {
      _result.files.addAll(files);
    }
    return _result;
  }
  factory Transformation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transformation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transformation clone() => Transformation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transformation copyWith(void Function(Transformation) updates) => super.copyWith((message) => updates(message as Transformation)) as Transformation; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Transformation create() => Transformation._();
  Transformation createEmptyInstance() => create();
  static $pb.PbList<Transformation> createRepeated() => $pb.PbList<Transformation>();
  @$core.pragma('dart2js:noInline')
  static Transformation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transformation>(create);
  static Transformation? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get groupId => $_getSZ(2);
  @$pb.TagNumber(3)
  set groupId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasGroupId() => $_has(2);
  @$pb.TagNumber(3)
  void clearGroupId() => clearField(3);

  @$pb.TagNumber(4)
  $2.Date get month => $_getN(3);
  @$pb.TagNumber(4)
  set month($2.Date v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMonth() => $_has(3);
  @$pb.TagNumber(4)
  void clearMonth() => clearField(4);
  @$pb.TagNumber(4)
  $2.Date ensureMonth() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get impactStory => $_getSZ(4);
  @$pb.TagNumber(5)
  set impactStory($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasImpactStory() => $_has(4);
  @$pb.TagNumber(5)
  void clearImpactStory() => clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.String> get files => $_getList(5);
}

class UpdateCurrentUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCurrentUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOM<$4.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $4.FieldMask.create)
    ..hasRequiredFields = false
  ;

  UpdateCurrentUserRequest._() : super();
  factory UpdateCurrentUserRequest({
    User? user,
    $4.FieldMask? updateMask,
  }) {
    final _result = create();
    if (user != null) {
      _result.user = user;
    }
    if (updateMask != null) {
      _result.updateMask = updateMask;
    }
    return _result;
  }
  factory UpdateCurrentUserRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateCurrentUserRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateCurrentUserRequest clone() => UpdateCurrentUserRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateCurrentUserRequest copyWith(void Function(UpdateCurrentUserRequest) updates) => super.copyWith((message) => updates(message as UpdateCurrentUserRequest)) as UpdateCurrentUserRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpdateCurrentUserRequest create() => UpdateCurrentUserRequest._();
  UpdateCurrentUserRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateCurrentUserRequest> createRepeated() => $pb.PbList<UpdateCurrentUserRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateCurrentUserRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateCurrentUserRequest>(create);
  static UpdateCurrentUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);

  @$pb.TagNumber(2)
  $4.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($4.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $4.FieldMask ensureUpdateMask() => $_ensure(1);
}

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..pPS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'countryIds')
    ..pPS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'languageIds')
    ..aOB(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'linkGroups')
    ..pc<GroupUser>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groups', $pb.PbFieldType.PM, subBuilder: GroupUser.create)
    ..pc<ActionUser>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actions', $pb.PbFieldType.PM, subBuilder: ActionUser.create)
    ..e<ActionTab>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedActionsTab', $pb.PbFieldType.OE, defaultOrMaker: ActionTab.ACTIONS_UNSPECIFIED, valueOf: ActionTab.valueOf, enumValues: ActionTab.values)
    ..e<ResultsTab>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedResultsTab', $pb.PbFieldType.OE, defaultOrMaker: ResultsTab.RESULTS_UNSPECIFIED, valueOf: ResultsTab.valueOf, enumValues: ResultsTab.values)
    ..aOS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phoneCountryId')
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'diallingCode')
    ..e<User_Status>(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: User_Status.STATUS_UNSPECIFIED, valueOf: User_Status.valueOf, enumValues: User_Status.values)
    ..aOS(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId')
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $core.String? id,
    $core.String? name,
    $core.String? phone,
    $core.Iterable<$core.String>? countryIds,
    $core.Iterable<$core.String>? languageIds,
    $core.bool? linkGroups,
    $core.Iterable<GroupUser>? groups,
    $core.Iterable<ActionUser>? actions,
    ActionTab? selectedActionsTab,
    ResultsTab? selectedResultsTab,
    $core.String? phoneCountryId,
    $core.String? diallingCode,
    User_Status? status,
    $core.String? creatorId,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (name != null) {
      _result.name = name;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (countryIds != null) {
      _result.countryIds.addAll(countryIds);
    }
    if (languageIds != null) {
      _result.languageIds.addAll(languageIds);
    }
    if (linkGroups != null) {
      _result.linkGroups = linkGroups;
    }
    if (groups != null) {
      _result.groups.addAll(groups);
    }
    if (actions != null) {
      _result.actions.addAll(actions);
    }
    if (selectedActionsTab != null) {
      _result.selectedActionsTab = selectedActionsTab;
    }
    if (selectedResultsTab != null) {
      _result.selectedResultsTab = selectedResultsTab;
    }
    if (phoneCountryId != null) {
      _result.phoneCountryId = phoneCountryId;
    }
    if (diallingCode != null) {
      _result.diallingCode = diallingCode;
    }
    if (status != null) {
      _result.status = status;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get phone => $_getSZ(2);
  @$pb.TagNumber(3)
  set phone($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPhone() => $_has(2);
  @$pb.TagNumber(3)
  void clearPhone() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get countryIds => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<$core.String> get languageIds => $_getList(4);

  @$pb.TagNumber(6)
  $core.bool get linkGroups => $_getBF(5);
  @$pb.TagNumber(6)
  set linkGroups($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLinkGroups() => $_has(5);
  @$pb.TagNumber(6)
  void clearLinkGroups() => clearField(6);

  @$pb.TagNumber(7)
  $core.List<GroupUser> get groups => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<ActionUser> get actions => $_getList(7);

  @$pb.TagNumber(9)
  ActionTab get selectedActionsTab => $_getN(8);
  @$pb.TagNumber(9)
  set selectedActionsTab(ActionTab v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSelectedActionsTab() => $_has(8);
  @$pb.TagNumber(9)
  void clearSelectedActionsTab() => clearField(9);

  @$pb.TagNumber(10)
  ResultsTab get selectedResultsTab => $_getN(9);
  @$pb.TagNumber(10)
  set selectedResultsTab(ResultsTab v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSelectedResultsTab() => $_has(9);
  @$pb.TagNumber(10)
  void clearSelectedResultsTab() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get phoneCountryId => $_getSZ(10);
  @$pb.TagNumber(11)
  set phoneCountryId($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPhoneCountryId() => $_has(10);
  @$pb.TagNumber(11)
  void clearPhoneCountryId() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get diallingCode => $_getSZ(11);
  @$pb.TagNumber(12)
  set diallingCode($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasDiallingCode() => $_has(11);
  @$pb.TagNumber(12)
  void clearDiallingCode() => clearField(12);

  @$pb.TagNumber(13)
  User_Status get status => $_getN(12);
  @$pb.TagNumber(13)
  set status(User_Status v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasStatus() => $_has(12);
  @$pb.TagNumber(13)
  void clearStatus() => clearField(13);

  @$pb.TagNumber(14)
  $core.String get creatorId => $_getSZ(13);
  @$pb.TagNumber(14)
  set creatorId($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasCreatorId() => $_has(13);
  @$pb.TagNumber(14)
  void clearCreatorId() => clearField(14);
}

