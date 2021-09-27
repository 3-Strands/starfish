///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ActionTab extends $pb.ProtobufEnum {
  static const ActionTab ACTIONS_UNSPECIFIED = ActionTab._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACTIONS_UNSPECIFIED');
  static const ActionTab ACTIONS_MINE = ActionTab._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACTIONS_MINE');
  static const ActionTab ACTIONS_MY_GROUPS = ActionTab._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACTIONS_MY_GROUPS');

  static const $core.List<ActionTab> values = <ActionTab> [
    ACTIONS_UNSPECIFIED,
    ACTIONS_MINE,
    ACTIONS_MY_GROUPS,
  ];

  static final $core.Map<$core.int, ActionTab> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ActionTab? valueOf($core.int value) => _byValue[value];

  const ActionTab._($core.int v, $core.String n) : super(v, n);
}

class ResultsTab extends $pb.ProtobufEnum {
  static const ResultsTab RESULTS_UNSPECIFIED = ResultsTab._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RESULTS_UNSPECIFIED');
  static const ResultsTab RESULTS_MINE = ResultsTab._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RESULTS_MINE');
  static const ResultsTab RESULTS_MY_GROUPS = ResultsTab._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'RESULTS_MY_GROUPS');

  static const $core.List<ResultsTab> values = <ResultsTab> [
    RESULTS_UNSPECIFIED,
    RESULTS_MINE,
    RESULTS_MY_GROUPS,
  ];

  static final $core.Map<$core.int, ResultsTab> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ResultsTab? valueOf($core.int value) => _byValue[value];

  const ResultsTab._($core.int v, $core.String n) : super(v, n);
}

class ActionUser_Status extends $pb.ProtobufEnum {
  static const ActionUser_Status UNSPECIFIED_STATUS = ActionUser_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSPECIFIED_STATUS');
  static const ActionUser_Status INCOMPLETE = ActionUser_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INCOMPLETE');
  static const ActionUser_Status COMPLETE = ActionUser_Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETE');

  static const $core.List<ActionUser_Status> values = <ActionUser_Status> [
    UNSPECIFIED_STATUS,
    INCOMPLETE,
    COMPLETE,
  ];

  static final $core.Map<$core.int, ActionUser_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ActionUser_Status? valueOf($core.int value) => _byValue[value];

  const ActionUser_Status._($core.int v, $core.String n) : super(v, n);
}

class CreateMaterialFeedbacksResponse_Status extends $pb.ProtobufEnum {
  static const CreateMaterialFeedbacksResponse_Status SUCCESS = CreateMaterialFeedbacksResponse_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const CreateMaterialFeedbacksResponse_Status FAILURE = CreateMaterialFeedbacksResponse_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILURE');

  static const $core.List<CreateMaterialFeedbacksResponse_Status> values = <CreateMaterialFeedbacksResponse_Status> [
    SUCCESS,
    FAILURE,
  ];

  static final $core.Map<$core.int, CreateMaterialFeedbacksResponse_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreateMaterialFeedbacksResponse_Status? valueOf($core.int value) => _byValue[value];

  const CreateMaterialFeedbacksResponse_Status._($core.int v, $core.String n) : super(v, n);
}

class CreateUpdateGroupsResponse_Status extends $pb.ProtobufEnum {
  static const CreateUpdateGroupsResponse_Status SUCCESS = CreateUpdateGroupsResponse_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const CreateUpdateGroupsResponse_Status FAILURE = CreateUpdateGroupsResponse_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILURE');

  static const $core.List<CreateUpdateGroupsResponse_Status> values = <CreateUpdateGroupsResponse_Status> [
    SUCCESS,
    FAILURE,
  ];

  static final $core.Map<$core.int, CreateUpdateGroupsResponse_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreateUpdateGroupsResponse_Status? valueOf($core.int value) => _byValue[value];

  const CreateUpdateGroupsResponse_Status._($core.int v, $core.String n) : super(v, n);
}

class CreateUpdateGroupUsersResponse_Status extends $pb.ProtobufEnum {
  static const CreateUpdateGroupUsersResponse_Status SUCCESS = CreateUpdateGroupUsersResponse_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const CreateUpdateGroupUsersResponse_Status FAILURE = CreateUpdateGroupUsersResponse_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILURE');

  static const $core.List<CreateUpdateGroupUsersResponse_Status> values = <CreateUpdateGroupUsersResponse_Status> [
    SUCCESS,
    FAILURE,
  ];

  static final $core.Map<$core.int, CreateUpdateGroupUsersResponse_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreateUpdateGroupUsersResponse_Status? valueOf($core.int value) => _byValue[value];

  const CreateUpdateGroupUsersResponse_Status._($core.int v, $core.String n) : super(v, n);
}

class CreateUpdateMaterialsResponse_Status extends $pb.ProtobufEnum {
  static const CreateUpdateMaterialsResponse_Status SUCCESS = CreateUpdateMaterialsResponse_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const CreateUpdateMaterialsResponse_Status FAILURE = CreateUpdateMaterialsResponse_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILURE');

  static const $core.List<CreateUpdateMaterialsResponse_Status> values = <CreateUpdateMaterialsResponse_Status> [
    SUCCESS,
    FAILURE,
  ];

  static final $core.Map<$core.int, CreateUpdateMaterialsResponse_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CreateUpdateMaterialsResponse_Status? valueOf($core.int value) => _byValue[value];

  const CreateUpdateMaterialsResponse_Status._($core.int v, $core.String n) : super(v, n);
}

class DeleteGroupUsersResponse_Status extends $pb.ProtobufEnum {
  static const DeleteGroupUsersResponse_Status SUCCESS = DeleteGroupUsersResponse_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SUCCESS');
  static const DeleteGroupUsersResponse_Status FAILURE = DeleteGroupUsersResponse_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILURE');

  static const $core.List<DeleteGroupUsersResponse_Status> values = <DeleteGroupUsersResponse_Status> [
    SUCCESS,
    FAILURE,
  ];

  static final $core.Map<$core.int, DeleteGroupUsersResponse_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DeleteGroupUsersResponse_Status? valueOf($core.int value) => _byValue[value];

  const DeleteGroupUsersResponse_Status._($core.int v, $core.String n) : super(v, n);
}

class Edit_Event extends $pb.ProtobufEnum {
  static const Edit_Event EVENT_UNSPECIFIED = Edit_Event._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EVENT_UNSPECIFIED');
  static const Edit_Event CREATE = Edit_Event._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREATE');
  static const Edit_Event UPDATE = Edit_Event._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UPDATE');
  static const Edit_Event DELETE = Edit_Event._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DELETE');

  static const $core.List<Edit_Event> values = <Edit_Event> [
    EVENT_UNSPECIFIED,
    CREATE,
    UPDATE,
    DELETE,
  ];

  static final $core.Map<$core.int, Edit_Event> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Edit_Event? valueOf($core.int value) => _byValue[value];

  const Edit_Event._($core.int v, $core.String n) : super(v, n);
}

class GroupUser_Role extends $pb.ProtobufEnum {
  static const GroupUser_Role UNSPECIFIED_ROLE = GroupUser_Role._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSPECIFIED_ROLE');
  static const GroupUser_Role LEARNER = GroupUser_Role._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEARNER');
  static const GroupUser_Role TEACHER = GroupUser_Role._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEACHER');
  static const GroupUser_Role ADMIN = GroupUser_Role._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADMIN');

  static const $core.List<GroupUser_Role> values = <GroupUser_Role> [
    UNSPECIFIED_ROLE,
    LEARNER,
    TEACHER,
    ADMIN,
  ];

  static final $core.Map<$core.int, GroupUser_Role> _byValue = $pb.ProtobufEnum.initByValue(values);
  static GroupUser_Role? valueOf($core.int value) => _byValue[value];

  const GroupUser_Role._($core.int v, $core.String n) : super(v, n);
}

class Material_Status extends $pb.ProtobufEnum {
  static const Material_Status UNSPECIFIED_STATUS = Material_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSPECIFIED_STATUS');
  static const Material_Status ACTIVE = Material_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACTIVE');
  static const Material_Status INACTIVE = Material_Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INACTIVE');

  static const $core.List<Material_Status> values = <Material_Status> [
    UNSPECIFIED_STATUS,
    ACTIVE,
    INACTIVE,
  ];

  static final $core.Map<$core.int, Material_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Material_Status? valueOf($core.int value) => _byValue[value];

  const Material_Status._($core.int v, $core.String n) : super(v, n);
}

class Material_Visibility extends $pb.ProtobufEnum {
  static const Material_Visibility UNSPECIFIED_VISIBILITY = Material_Visibility._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSPECIFIED_VISIBILITY');
  static const Material_Visibility CREATOR_VIEW = Material_Visibility._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREATOR_VIEW');
  static const Material_Visibility GROUP_VIEW = Material_Visibility._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GROUP_VIEW');
  static const Material_Visibility ALL_VIEW = Material_Visibility._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ALL_VIEW');

  static const $core.List<Material_Visibility> values = <Material_Visibility> [
    UNSPECIFIED_VISIBILITY,
    CREATOR_VIEW,
    GROUP_VIEW,
    ALL_VIEW,
  ];

  static final $core.Map<$core.int, Material_Visibility> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Material_Visibility? valueOf($core.int value) => _byValue[value];

  const Material_Visibility._($core.int v, $core.String n) : super(v, n);
}

class Material_Editability extends $pb.ProtobufEnum {
  static const Material_Editability UNSPECIFIED_EDITABILITY = Material_Editability._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSPECIFIED_EDITABILITY');
  static const Material_Editability CREATOR_EDIT = Material_Editability._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CREATOR_EDIT');
  static const Material_Editability GROUP_EDIT = Material_Editability._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'GROUP_EDIT');

  static const $core.List<Material_Editability> values = <Material_Editability> [
    UNSPECIFIED_EDITABILITY,
    CREATOR_EDIT,
    GROUP_EDIT,
  ];

  static final $core.Map<$core.int, Material_Editability> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Material_Editability? valueOf($core.int value) => _byValue[value];

  const Material_Editability._($core.int v, $core.String n) : super(v, n);
}

class MaterialFeedback_Type extends $pb.ProtobufEnum {
  static const MaterialFeedback_Type UNSPECIFIED_TYPE = MaterialFeedback_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNSPECIFIED_TYPE');
  static const MaterialFeedback_Type INAPPROPRIATE = MaterialFeedback_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INAPPROPRIATE');

  static const $core.List<MaterialFeedback_Type> values = <MaterialFeedback_Type> [
    UNSPECIFIED_TYPE,
    INAPPROPRIATE,
  ];

  static final $core.Map<$core.int, MaterialFeedback_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MaterialFeedback_Type? valueOf($core.int value) => _byValue[value];

  const MaterialFeedback_Type._($core.int v, $core.String n) : super(v, n);
}

