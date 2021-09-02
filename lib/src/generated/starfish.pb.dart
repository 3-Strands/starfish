///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/type/date.pb.dart' as $2;

import 'starfish.pbenum.dart';

export 'starfish.pbenum.dart';

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
    ..e<SubTab>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedActionsTab', $pb.PbFieldType.OE, defaultOrMaker: SubTab.MINE, valueOf: SubTab.valueOf, enumValues: SubTab.values)
    ..e<SubTab>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedResultsTab', $pb.PbFieldType.OE, defaultOrMaker: SubTab.MINE, valueOf: SubTab.valueOf, enumValues: SubTab.values)
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
    SubTab? selectedActionsTab,
    SubTab? selectedResultsTab,
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
  SubTab get selectedActionsTab => $_getN(8);
  @$pb.TagNumber(9)
  set selectedActionsTab(SubTab v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSelectedActionsTab() => $_has(8);
  @$pb.TagNumber(9)
  void clearSelectedActionsTab() => clearField(9);

  @$pb.TagNumber(10)
  SubTab get selectedResultsTab => $_getN(9);
  @$pb.TagNumber(10)
  set selectedResultsTab(SubTab v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSelectedResultsTab() => $_has(9);
  @$pb.TagNumber(10)
  void clearSelectedResultsTab() => clearField(10);
}

class GroupUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<GroupUser_Role>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: GroupUser_Role.LEARNER, valueOf: GroupUser_Role.valueOf, enumValues: GroupUser_Role.values)
    ..hasRequiredFields = false
  ;

  GroupUser._() : super();
  factory GroupUser({
    $core.String? groupId,
    $core.String? userId,
    GroupUser_Role? role,
  }) {
    final _result = create();
    if (groupId != null) {
      _result.groupId = groupId;
    }
    if (userId != null) {
      _result.userId = userId;
    }
    if (role != null) {
      _result.role = role;
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

  @$pb.TagNumber(2)
  $core.String get groupId => $_getSZ(0);
  @$pb.TagNumber(2)
  set groupId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasGroupId() => $_has(0);
  @$pb.TagNumber(2)
  void clearGroupId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  GroupUser_Role get role => $_getN(2);
  @$pb.TagNumber(4)
  set role(GroupUser_Role v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(4)
  void clearRole() => clearField(4);
}

class ActionUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ActionUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'actionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<ActionUser_Status>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ActionUser_Status.INCOMPLETE, valueOf: ActionUser_Status.valueOf, enumValues: ActionUser_Status.values)
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'teacherResponse')
    ..aOM<$2.Date>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dateDue', subBuilder: $2.Date.create)
    ..hasRequiredFields = false
  ;

  ActionUser._() : super();
  factory ActionUser({
    $core.String? actionId,
    $core.String? userId,
    ActionUser_Status? status,
    $core.String? teacherResponse,
    $2.Date? dateDue,
  }) {
    final _result = create();
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
    if (dateDue != null) {
      _result.dateDue = dateDue;
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

  @$pb.TagNumber(2)
  $core.String get actionId => $_getSZ(0);
  @$pb.TagNumber(2)
  set actionId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasActionId() => $_has(0);
  @$pb.TagNumber(2)
  void clearActionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(3)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(3)
  void clearUserId() => clearField(3);

  @$pb.TagNumber(4)
  ActionUser_Status get status => $_getN(2);
  @$pb.TagNumber(4)
  set status(ActionUser_Status v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(4)
  void clearStatus() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get teacherResponse => $_getSZ(3);
  @$pb.TagNumber(5)
  set teacherResponse($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasTeacherResponse() => $_has(3);
  @$pb.TagNumber(5)
  void clearTeacherResponse() => clearField(5);

  @$pb.TagNumber(6)
  $2.Date get dateDue => $_getN(4);
  @$pb.TagNumber(6)
  set dateDue($2.Date v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDateDue() => $_has(4);
  @$pb.TagNumber(6)
  void clearDateDue() => clearField(6);
  @$pb.TagNumber(6)
  $2.Date ensureDateDue() => $_ensure(4);
}

