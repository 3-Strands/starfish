///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use subTabDescriptor instead')
const SubTab$json = const {
  '1': 'SubTab',
  '2': const [
    const {'1': 'MINE', '2': 0},
    const {'1': 'MY_GROUPS', '2': 1},
  ],
};

/// Descriptor for `SubTab`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List subTabDescriptor = $convert.base64Decode('CgZTdWJUYWISCAoETUlORRAAEg0KCU1ZX0dST1VQUxAB');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'phone', '3': 3, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'country_ids', '3': 4, '4': 3, '5': 9, '10': 'countryIds'},
    const {'1': 'language_ids', '3': 5, '4': 3, '5': 9, '10': 'languageIds'},
    const {'1': 'link_groups', '3': 6, '4': 1, '5': 8, '10': 'linkGroups'},
    const {'1': 'groups', '3': 7, '4': 3, '5': 11, '6': '.sil.starfish.GroupUser', '10': 'groups'},
    const {'1': 'actions', '3': 8, '4': 3, '5': 11, '6': '.sil.starfish.ActionUser', '10': 'actions'},
    const {'1': 'selected_actions_tab', '3': 9, '4': 1, '5': 14, '6': '.sil.starfish.SubTab', '10': 'selectedActionsTab'},
    const {'1': 'selected_results_tab', '3': 10, '4': 1, '5': 14, '6': '.sil.starfish.SubTab', '10': 'selectedResultsTab'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXBob25lGAMgASgJUgVwaG9uZRIfCgtjb3VudHJ5X2lkcxgEIAMoCVIKY291bnRyeUlkcxIhCgxsYW5ndWFnZV9pZHMYBSADKAlSC2xhbmd1YWdlSWRzEh8KC2xpbmtfZ3JvdXBzGAYgASgIUgpsaW5rR3JvdXBzEi8KBmdyb3VwcxgHIAMoCzIXLnNpbC5zdGFyZmlzaC5Hcm91cFVzZXJSBmdyb3VwcxIyCgdhY3Rpb25zGAggAygLMhguc2lsLnN0YXJmaXNoLkFjdGlvblVzZXJSB2FjdGlvbnMSRgoUc2VsZWN0ZWRfYWN0aW9uc190YWIYCSABKA4yFC5zaWwuc3RhcmZpc2guU3ViVGFiUhJzZWxlY3RlZEFjdGlvbnNUYWISRgoUc2VsZWN0ZWRfcmVzdWx0c190YWIYCiABKA4yFC5zaWwuc3RhcmZpc2guU3ViVGFiUhJzZWxlY3RlZFJlc3VsdHNUYWI=');
@$core.Deprecated('Use groupUserDescriptor instead')
const GroupUser$json = const {
  '1': 'GroupUser',
  '2': const [
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'role', '3': 4, '4': 1, '5': 14, '6': '.sil.starfish.GroupUser.Role', '10': 'role'},
  ],
  '4': const [GroupUser_Role$json],
};

@$core.Deprecated('Use groupUserDescriptor instead')
const GroupUser_Role$json = const {
  '1': 'Role',
  '2': const [
    const {'1': 'LEARNER', '2': 0},
    const {'1': 'TEACHER', '2': 1},
    const {'1': 'ADMIN', '2': 2},
  ],
};

/// Descriptor for `GroupUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupUserDescriptor = $convert.base64Decode('CglHcm91cFVzZXISGQoIZ3JvdXBfaWQYAiABKAlSB2dyb3VwSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEjAKBHJvbGUYBCABKA4yHC5zaWwuc3RhcmZpc2guR3JvdXBVc2VyLlJvbGVSBHJvbGUiKwoEUm9sZRILCgdMRUFSTkVSEAASCwoHVEVBQ0hFUhABEgkKBUFETUlOEAI=');
@$core.Deprecated('Use actionUserDescriptor instead')
const ActionUser$json = const {
  '1': 'ActionUser',
  '2': const [
    const {'1': 'action_id', '3': 2, '4': 1, '5': 9, '10': 'actionId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.sil.starfish.ActionUser.Status', '10': 'status'},
    const {'1': 'teacher_response', '3': 5, '4': 1, '5': 9, '10': 'teacherResponse'},
    const {'1': 'date_due', '3': 6, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'dateDue'},
  ],
  '4': const [ActionUser_Status$json],
};

@$core.Deprecated('Use actionUserDescriptor instead')
const ActionUser_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'INCOMPLETE', '2': 0},
    const {'1': 'COMPLETE', '2': 1},
  ],
};

/// Descriptor for `ActionUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionUserDescriptor = $convert.base64Decode('CgpBY3Rpb25Vc2VyEhsKCWFjdGlvbl9pZBgCIAEoCVIIYWN0aW9uSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEjcKBnN0YXR1cxgEIAEoDjIfLnNpbC5zdGFyZmlzaC5BY3Rpb25Vc2VyLlN0YXR1c1IGc3RhdHVzEikKEHRlYWNoZXJfcmVzcG9uc2UYBSABKAlSD3RlYWNoZXJSZXNwb25zZRIsCghkYXRlX2R1ZRgGIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSB2RhdGVEdWUiJgoGU3RhdHVzEg4KCklOQ09NUExFVEUQABIMCghDT01QTEVURRAB');
