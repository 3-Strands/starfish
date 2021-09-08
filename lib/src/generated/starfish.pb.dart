///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/type/date.pb.dart' as $2;
import 'google/protobuf/field_mask.pb.dart' as $3;

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
    ..e<ActionTab>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedActionsTab', $pb.PbFieldType.OE, defaultOrMaker: ActionTab.ACTIONS_UNSPECIFIED, valueOf: ActionTab.valueOf, enumValues: ActionTab.values)
    ..e<ResultsTab>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'selectedResultsTab', $pb.PbFieldType.OE, defaultOrMaker: ResultsTab.RESULTS_UNSPECIFIED, valueOf: ResultsTab.valueOf, enumValues: ResultsTab.values)
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
}

class GroupUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'GroupUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'groupId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userId')
    ..e<GroupUser_Role>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: GroupUser_Role.UNSPECIFIED_ROLE, valueOf: GroupUser_Role.valueOf, enumValues: GroupUser_Role.values)
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
    ..e<ActionUser_Status>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ActionUser_Status.UNSPECIFIED_STATUS, valueOf: ActionUser_Status.valueOf, enumValues: ActionUser_Status.values)
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

class UpdateCurrentUserRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UpdateCurrentUserRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<User>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'user', subBuilder: User.create)
    ..aOM<$3.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $3.FieldMask.create)
    ..hasRequiredFields = false
  ;

  UpdateCurrentUserRequest._() : super();
  factory UpdateCurrentUserRequest({
    User? user,
    $3.FieldMask? updateMask,
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
  $3.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($3.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $3.FieldMask ensureUpdateMask() => $_ensure(1);
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

class CreateUpdateMaterialsRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CreateUpdateMaterialsRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<Material>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'material', subBuilder: Material.create)
    ..aOM<$3.FieldMask>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateMask', subBuilder: $3.FieldMask.create)
    ..hasRequiredFields = false
  ;

  CreateUpdateMaterialsRequest._() : super();
  factory CreateUpdateMaterialsRequest({
    Material? material,
    $3.FieldMask? updateMask,
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
  $3.FieldMask get updateMask => $_getN(1);
  @$pb.TagNumber(2)
  set updateMask($3.FieldMask v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateMask() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateMask() => clearField(2);
  @$pb.TagNumber(2)
  $3.FieldMask ensureUpdateMask() => $_ensure(1);
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

