///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class SubTab extends $pb.ProtobufEnum {
  static const SubTab MINE = SubTab._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MINE');
  static const SubTab MY_GROUPS = SubTab._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MY_GROUPS');

  static const $core.List<SubTab> values = <SubTab> [
    MINE,
    MY_GROUPS,
  ];

  static final $core.Map<$core.int, SubTab> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SubTab? valueOf($core.int value) => _byValue[value];

  const SubTab._($core.int v, $core.String n) : super(v, n);
}

class GroupUser_Role extends $pb.ProtobufEnum {
  static const GroupUser_Role LEARNER = GroupUser_Role._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEARNER');
  static const GroupUser_Role TEACHER = GroupUser_Role._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEACHER');
  static const GroupUser_Role ADMIN = GroupUser_Role._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADMIN');

  static const $core.List<GroupUser_Role> values = <GroupUser_Role> [
    LEARNER,
    TEACHER,
    ADMIN,
  ];

  static final $core.Map<$core.int, GroupUser_Role> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GroupUser_Role? valueOf($core.int value) => _byValue[value];

  const GroupUser_Role._($core.int v, $core.String n) : super(v, n);
}

class ActionUser_Status extends $pb.ProtobufEnum {
  static const ActionUser_Status INCOMPLETE = ActionUser_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INCOMPLETE');
  static const ActionUser_Status COMPLETE = ActionUser_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETE');

  static const $core.List<ActionUser_Status> values = <ActionUser_Status> [
    INCOMPLETE,
    COMPLETE,
  ];

  static final $core.Map<$core.int, ActionUser_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ActionUser_Status? valueOf($core.int value) => _byValue[value];

  const ActionUser_Status._($core.int v, $core.String n) : super(v, n);
}

