///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use actionTabDescriptor instead')
const ActionTab$json = const {
  '1': 'ActionTab',
  '2': const [
    const {'1': 'ACTIONS_UNSPECIFIED', '2': 0},
    const {'1': 'ACTIONS_MINE', '2': 1},
    const {'1': 'ACTIONS_MY_GROUPS', '2': 2},
  ],
};

/// Descriptor for `ActionTab`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List actionTabDescriptor = $convert.base64Decode('CglBY3Rpb25UYWISFwoTQUNUSU9OU19VTlNQRUNJRklFRBAAEhAKDEFDVElPTlNfTUlORRABEhUKEUFDVElPTlNfTVlfR1JPVVBTEAI=');
@$core.Deprecated('Use resultsTabDescriptor instead')
const ResultsTab$json = const {
  '1': 'ResultsTab',
  '2': const [
    const {'1': 'RESULTS_UNSPECIFIED', '2': 0},
    const {'1': 'RESULTS_MINE', '2': 1},
    const {'1': 'RESULTS_MY_GROUPS', '2': 2},
  ],
};

/// Descriptor for `ResultsTab`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List resultsTabDescriptor = $convert.base64Decode('CgpSZXN1bHRzVGFiEhcKE1JFU1VMVFNfVU5TUEVDSUZJRUQQABIQCgxSRVNVTFRTX01JTkUQARIVChFSRVNVTFRTX01ZX0dST1VQUxAC');
@$core.Deprecated('Use editDescriptor instead')
const Edit$json = const {
  '1': 'Edit',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {'1': 'time', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'time'},
    const {'1': 'event', '3': 4, '4': 1, '5': 14, '6': '.sil.starfish.Edit.Event', '10': 'event'},
  ],
  '4': const [Edit_Event$json],
};

@$core.Deprecated('Use editDescriptor instead')
const Edit_Event$json = const {
  '1': 'Event',
  '2': const [
    const {'1': 'EVENT_UNSPECIFIED', '2': 0},
    const {'1': 'CREATE', '2': 1},
    const {'1': 'UPDATE', '2': 2},
    const {'1': 'DELETE', '2': 3},
  ],
};

/// Descriptor for `Edit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editDescriptor = $convert.base64Decode('CgRFZGl0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIuCgR0aW1lGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEdGltZRIuCgVldmVudBgEIAEoDjIYLnNpbC5zdGFyZmlzaC5FZGl0LkV2ZW50UgVldmVudCJCCgVFdmVudBIVChFFVkVOVF9VTlNQRUNJRklFRBAAEgoKBkNSRUFURRABEgoKBlVQREFURRACEgoKBkRFTEVURRAD');
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
    const {'1': 'selected_actions_tab', '3': 9, '4': 1, '5': 14, '6': '.sil.starfish.ActionTab', '10': 'selectedActionsTab'},
    const {'1': 'selected_results_tab', '3': 10, '4': 1, '5': 14, '6': '.sil.starfish.ResultsTab', '10': 'selectedResultsTab'},
    const {'1': 'phone_country_id', '3': 11, '4': 1, '5': 9, '10': 'phoneCountryId'},
    const {'1': 'dialling_code', '3': 12, '4': 1, '5': 9, '10': 'diallingCode'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXBob25lGAMgASgJUgVwaG9uZRIfCgtjb3VudHJ5X2lkcxgEIAMoCVIKY291bnRyeUlkcxIhCgxsYW5ndWFnZV9pZHMYBSADKAlSC2xhbmd1YWdlSWRzEh8KC2xpbmtfZ3JvdXBzGAYgASgIUgpsaW5rR3JvdXBzEi8KBmdyb3VwcxgHIAMoCzIXLnNpbC5zdGFyZmlzaC5Hcm91cFVzZXJSBmdyb3VwcxIyCgdhY3Rpb25zGAggAygLMhguc2lsLnN0YXJmaXNoLkFjdGlvblVzZXJSB2FjdGlvbnMSSQoUc2VsZWN0ZWRfYWN0aW9uc190YWIYCSABKA4yFy5zaWwuc3RhcmZpc2guQWN0aW9uVGFiUhJzZWxlY3RlZEFjdGlvbnNUYWISSgoUc2VsZWN0ZWRfcmVzdWx0c190YWIYCiABKA4yGC5zaWwuc3RhcmZpc2guUmVzdWx0c1RhYlISc2VsZWN0ZWRSZXN1bHRzVGFiEigKEHBob25lX2NvdW50cnlfaWQYCyABKAlSDnBob25lQ291bnRyeUlkEiMKDWRpYWxsaW5nX2NvZGUYDCABKAlSDGRpYWxsaW5nQ29kZQ==');
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
    const {'1': 'UNSPECIFIED_ROLE', '2': 0},
    const {'1': 'LEARNER', '2': 1},
    const {'1': 'TEACHER', '2': 2},
    const {'1': 'ADMIN', '2': 3},
  ],
};

/// Descriptor for `GroupUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupUserDescriptor = $convert.base64Decode('CglHcm91cFVzZXISGQoIZ3JvdXBfaWQYAiABKAlSB2dyb3VwSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEjAKBHJvbGUYBCABKA4yHC5zaWwuc3RhcmZpc2guR3JvdXBVc2VyLlJvbGVSBHJvbGUiQQoEUm9sZRIUChBVTlNQRUNJRklFRF9ST0xFEAASCwoHTEVBUk5FUhABEgsKB1RFQUNIRVIQAhIJCgVBRE1JThAD');
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
    const {'1': 'UNSPECIFIED_STATUS', '2': 0},
    const {'1': 'INCOMPLETE', '2': 1},
    const {'1': 'COMPLETE', '2': 2},
  ],
};

/// Descriptor for `ActionUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionUserDescriptor = $convert.base64Decode('CgpBY3Rpb25Vc2VyEhsKCWFjdGlvbl9pZBgCIAEoCVIIYWN0aW9uSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEjcKBnN0YXR1cxgEIAEoDjIfLnNpbC5zdGFyZmlzaC5BY3Rpb25Vc2VyLlN0YXR1c1IGc3RhdHVzEikKEHRlYWNoZXJfcmVzcG9uc2UYBSABKAlSD3RlYWNoZXJSZXNwb25zZRIsCghkYXRlX2R1ZRgGIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSB2RhdGVEdWUiPgoGU3RhdHVzEhYKElVOU1BFQ0lGSUVEX1NUQVRVUxAAEg4KCklOQ09NUExFVEUQARIMCghDT01QTEVURRAC');
@$core.Deprecated('Use countryDescriptor instead')
const Country$json = const {
  '1': 'Country',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'dialling_code', '3': 3, '4': 1, '5': 9, '10': 'diallingCode'},
  ],
};

/// Descriptor for `Country`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryDescriptor = $convert.base64Decode('CgdDb3VudHJ5Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDWRpYWxsaW5nX2NvZGUYAyABKAlSDGRpYWxsaW5nQ29kZQ==');
@$core.Deprecated('Use languageDescriptor instead')
const Language$json = const {
  '1': 'Language',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Language`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List languageDescriptor = $convert.base64Decode('CghMYW5ndWFnZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use materialTypeDescriptor instead')
const MaterialType$json = const {
  '1': 'MaterialType',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MaterialType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List materialTypeDescriptor = $convert.base64Decode('CgxNYXRlcmlhbFR5cGUSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use materialTopicDescriptor instead')
const MaterialTopic$json = const {
  '1': 'MaterialTopic',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MaterialTopic`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List materialTopicDescriptor = $convert.base64Decode('Cg1NYXRlcmlhbFRvcGljEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use evaluationCategoryDescriptor instead')
const EvaluationCategory$json = const {
  '1': 'EvaluationCategory',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `EvaluationCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluationCategoryDescriptor = $convert.base64Decode('ChJFdmFsdWF0aW9uQ2F0ZWdvcnkSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use materialDescriptor instead')
const Material$json = const {
  '1': 'Material',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.sil.starfish.Material.Status', '10': 'status'},
    const {'1': 'visibility', '3': 4, '4': 1, '5': 14, '6': '.sil.starfish.Material.Visibility', '10': 'visibility'},
    const {'1': 'editability', '3': 5, '4': 1, '5': 14, '6': '.sil.starfish.Material.Editability', '10': 'editability'},
    const {'1': 'title', '3': 6, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'target_audience', '3': 8, '4': 1, '5': 9, '10': 'targetAudience'},
    const {'1': 'url', '3': 9, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'files', '3': 10, '4': 3, '5': 9, '10': 'files'},
    const {'1': 'language_ids', '3': 11, '4': 3, '5': 9, '10': 'languageIds'},
    const {'1': 'type_ids', '3': 12, '4': 3, '5': 9, '10': 'typeIds'},
    const {'1': 'topics', '3': 13, '4': 3, '5': 9, '10': 'topics'},
    const {'1': 'feedbacks', '3': 14, '4': 3, '5': 11, '6': '.sil.starfish.MaterialFeedback', '10': 'feedbacks'},
    const {'1': 'date_created', '3': 15, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'dateCreated'},
    const {'1': 'date_updated', '3': 16, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'dateUpdated'},
    const {'1': 'edit_history', '3': 17, '4': 3, '5': 11, '6': '.sil.starfish.Edit', '10': 'editHistory'},
  ],
  '4': const [Material_Status$json, Material_Visibility$json, Material_Editability$json],
};

@$core.Deprecated('Use materialDescriptor instead')
const Material_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'UNSPECIFIED_STATUS', '2': 0},
    const {'1': 'ACTIVE', '2': 1},
    const {'1': 'INACTIVE', '2': 2},
  ],
};

@$core.Deprecated('Use materialDescriptor instead')
const Material_Visibility$json = const {
  '1': 'Visibility',
  '2': const [
    const {'1': 'UNSPECIFIED_VISIBILITY', '2': 0},
    const {'1': 'CREATOR_VIEW', '2': 1},
    const {'1': 'GROUP_VIEW', '2': 2},
    const {'1': 'ALL_VIEW', '2': 3},
  ],
};

@$core.Deprecated('Use materialDescriptor instead')
const Material_Editability$json = const {
  '1': 'Editability',
  '2': const [
    const {'1': 'UNSPECIFIED_EDITABILITY', '2': 0},
    const {'1': 'CREATOR_EDIT', '2': 1},
    const {'1': 'GROUP_EDIT', '2': 2},
  ],
};

/// Descriptor for `Material`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List materialDescriptor = $convert.base64Decode('CghNYXRlcmlhbBIOCgJpZBgBIAEoCVICaWQSHQoKY3JlYXRvcl9pZBgCIAEoCVIJY3JlYXRvcklkEjUKBnN0YXR1cxgDIAEoDjIdLnNpbC5zdGFyZmlzaC5NYXRlcmlhbC5TdGF0dXNSBnN0YXR1cxJBCgp2aXNpYmlsaXR5GAQgASgOMiEuc2lsLnN0YXJmaXNoLk1hdGVyaWFsLlZpc2liaWxpdHlSCnZpc2liaWxpdHkSRAoLZWRpdGFiaWxpdHkYBSABKA4yIi5zaWwuc3RhcmZpc2guTWF0ZXJpYWwuRWRpdGFiaWxpdHlSC2VkaXRhYmlsaXR5EhQKBXRpdGxlGAYgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgHIAEoCVILZGVzY3JpcHRpb24SJwoPdGFyZ2V0X2F1ZGllbmNlGAggASgJUg50YXJnZXRBdWRpZW5jZRIQCgN1cmwYCSABKAlSA3VybBIUCgVmaWxlcxgKIAMoCVIFZmlsZXMSIQoMbGFuZ3VhZ2VfaWRzGAsgAygJUgtsYW5ndWFnZUlkcxIZCgh0eXBlX2lkcxgMIAMoCVIHdHlwZUlkcxIWCgZ0b3BpY3MYDSADKAlSBnRvcGljcxI8CglmZWVkYmFja3MYDiADKAsyHi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxGZWVkYmFja1IJZmVlZGJhY2tzEjQKDGRhdGVfY3JlYXRlZBgPIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSC2RhdGVDcmVhdGVkEjQKDGRhdGVfdXBkYXRlZBgQIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSC2RhdGVVcGRhdGVkEjUKDGVkaXRfaGlzdG9yeRgRIAMoCzISLnNpbC5zdGFyZmlzaC5FZGl0UgtlZGl0SGlzdG9yeSI6CgZTdGF0dXMSFgoSVU5TUEVDSUZJRURfU1RBVFVTEAASCgoGQUNUSVZFEAESDAoISU5BQ1RJVkUQAiJYCgpWaXNpYmlsaXR5EhoKFlVOU1BFQ0lGSUVEX1ZJU0lCSUxJVFkQABIQCgxDUkVBVE9SX1ZJRVcQARIOCgpHUk9VUF9WSUVXEAISDAoIQUxMX1ZJRVcQAyJMCgtFZGl0YWJpbGl0eRIbChdVTlNQRUNJRklFRF9FRElUQUJJTElUWRAAEhAKDENSRUFUT1JfRURJVBABEg4KCkdST1VQX0VESVQQAg==');
@$core.Deprecated('Use materialFeedbackDescriptor instead')
const MaterialFeedback$json = const {
  '1': 'MaterialFeedback',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.MaterialFeedback.Type', '10': 'type'},
    const {'1': 'reporter_id', '3': 3, '4': 1, '5': 9, '10': 'reporterId'},
    const {'1': 'report', '3': 4, '4': 1, '5': 9, '10': 'report'},
    const {'1': 'response', '3': 5, '4': 1, '5': 9, '10': 'response'},
    const {'1': 'material_id', '3': 6, '4': 1, '5': 9, '10': 'materialId'},
  ],
  '4': const [MaterialFeedback_Type$json],
};

@$core.Deprecated('Use materialFeedbackDescriptor instead')
const MaterialFeedback_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'UNSPECIFIED_TYPE', '2': 0},
    const {'1': 'INAPPROPRIATE', '2': 1},
  ],
};

/// Descriptor for `MaterialFeedback`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List materialFeedbackDescriptor = $convert.base64Decode('ChBNYXRlcmlhbEZlZWRiYWNrEg4KAmlkGAEgASgJUgJpZBI3CgR0eXBlGAIgASgOMiMuc2lsLnN0YXJmaXNoLk1hdGVyaWFsRmVlZGJhY2suVHlwZVIEdHlwZRIfCgtyZXBvcnRlcl9pZBgDIAEoCVIKcmVwb3J0ZXJJZBIWCgZyZXBvcnQYBCABKAlSBnJlcG9ydBIaCghyZXNwb25zZRgFIAEoCVIIcmVzcG9uc2USHwoLbWF0ZXJpYWxfaWQYBiABKAlSCm1hdGVyaWFsSWQiLwoEVHlwZRIUChBVTlNQRUNJRklFRF9UWVBFEAASEQoNSU5BUFBST1BSSUFURRAB');
@$core.Deprecated('Use groupDescriptor instead')
const Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'language_ids', '3': 3, '4': 3, '5': 9, '10': 'languageIds'},
    const {'1': 'users', '3': 4, '4': 3, '5': 11, '6': '.sil.starfish.GroupUser', '10': 'users'},
    const {'1': 'evaluation_category_ids', '3': 5, '4': 3, '5': 9, '10': 'evaluationCategoryIds'},
    const {'1': 'actions', '3': 6, '4': 3, '5': 11, '6': '.sil.starfish.GroupAction', '10': 'actions'},
    const {'1': 'edit_history', '3': 7, '4': 3, '5': 11, '6': '.sil.starfish.Edit', '10': 'editHistory'},
  ],
};

/// Descriptor for `Group`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupDescriptor = $convert.base64Decode('CgVHcm91cBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIhCgxsYW5ndWFnZV9pZHMYAyADKAlSC2xhbmd1YWdlSWRzEi0KBXVzZXJzGAQgAygLMhcuc2lsLnN0YXJmaXNoLkdyb3VwVXNlclIFdXNlcnMSNgoXZXZhbHVhdGlvbl9jYXRlZ29yeV9pZHMYBSADKAlSFWV2YWx1YXRpb25DYXRlZ29yeUlkcxIzCgdhY3Rpb25zGAYgAygLMhkuc2lsLnN0YXJmaXNoLkdyb3VwQWN0aW9uUgdhY3Rpb25zEjUKDGVkaXRfaGlzdG9yeRgHIAMoCzISLnNpbC5zdGFyZmlzaC5FZGl0UgtlZGl0SGlzdG9yeQ==');
@$core.Deprecated('Use groupActionDescriptor instead')
const GroupAction$json = const {
  '1': 'GroupAction',
  '2': const [
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'action_id', '3': 3, '4': 1, '5': 9, '10': 'actionId'},
    const {'1': 'due_date', '3': 4, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'dueDate'},
  ],
};

/// Descriptor for `GroupAction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupActionDescriptor = $convert.base64Decode('CgtHcm91cEFjdGlvbhIZCghncm91cF9pZBgCIAEoCVIHZ3JvdXBJZBIbCglhY3Rpb25faWQYAyABKAlSCGFjdGlvbklkEiwKCGR1ZV9kYXRlGAQgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIHZHVlRGF0ZQ==');
@$core.Deprecated('Use updateCurrentUserRequestDescriptor instead')
const UpdateCurrentUserRequest$json = const {
  '1': 'UpdateCurrentUserRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.User', '10': 'user'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `UpdateCurrentUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCurrentUserRequestDescriptor = $convert.base64Decode('ChhVcGRhdGVDdXJyZW50VXNlclJlcXVlc3QSJgoEdXNlchgBIAEoCzISLnNpbC5zdGFyZmlzaC5Vc2VyUgR1c2VyEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use listAllCountriesRequestDescriptor instead')
const ListAllCountriesRequest$json = const {
  '1': 'ListAllCountriesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListAllCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAllCountriesRequestDescriptor = $convert.base64Decode('ChdMaXN0QWxsQ291bnRyaWVzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listLanguagesRequestDescriptor instead')
const ListLanguagesRequest$json = const {
  '1': 'ListLanguagesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListLanguagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLanguagesRequestDescriptor = $convert.base64Decode('ChRMaXN0TGFuZ3VhZ2VzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listMaterialsRequestDescriptor instead')
const ListMaterialsRequest$json = const {
  '1': 'ListMaterialsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListMaterialsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialsRequestDescriptor = $convert.base64Decode('ChRMaXN0TWF0ZXJpYWxzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listMaterialTypesRequestDescriptor instead')
const ListMaterialTypesRequest$json = const {
  '1': 'ListMaterialTypesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListMaterialTypesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialTypesRequestDescriptor = $convert.base64Decode('ChhMaXN0TWF0ZXJpYWxUeXBlc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listMaterialTopicsRequestDescriptor instead')
const ListMaterialTopicsRequest$json = const {
  '1': 'ListMaterialTopicsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListMaterialTopicsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialTopicsRequestDescriptor = $convert.base64Decode('ChlMaXN0TWF0ZXJpYWxUb3BpY3NSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use listGroupsRequestDescriptor instead')
const ListGroupsRequest$json = const {
  '1': 'ListGroupsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupsRequestDescriptor = $convert.base64Decode('ChFMaXN0R3JvdXBzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listEvaluationCategoriesRequestDescriptor instead')
const ListEvaluationCategoriesRequest$json = const {
  '1': 'ListEvaluationCategoriesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListEvaluationCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEvaluationCategoriesRequestDescriptor = $convert.base64Decode('Ch9MaXN0RXZhbHVhdGlvbkNhdGVnb3JpZXNSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use createUpdateMaterialsRequestDescriptor instead')
const CreateUpdateMaterialsRequest$json = const {
  '1': 'CreateUpdateMaterialsRequest',
  '2': const [
    const {'1': 'material', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Material', '10': 'material'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateMaterialsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateMaterialsRequestDescriptor = $convert.base64Decode('ChxDcmVhdGVVcGRhdGVNYXRlcmlhbHNSZXF1ZXN0EjIKCG1hdGVyaWFsGAEgASgLMhYuc2lsLnN0YXJmaXNoLk1hdGVyaWFsUghtYXRlcmlhbBI7Cgt1cGRhdGVfbWFzaxgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tSCnVwZGF0ZU1hc2s=');
@$core.Deprecated('Use createUpdateMaterialsResponseDescriptor instead')
const CreateUpdateMaterialsResponse$json = const {
  '1': 'CreateUpdateMaterialsResponse',
  '2': const [
    const {'1': 'material', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Material', '10': 'material'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateMaterialsResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateMaterialsResponse_Status$json],
};

@$core.Deprecated('Use createUpdateMaterialsResponseDescriptor instead')
const CreateUpdateMaterialsResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateMaterialsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateMaterialsResponseDescriptor = $convert.base64Decode('Ch1DcmVhdGVVcGRhdGVNYXRlcmlhbHNSZXNwb25zZRIyCghtYXRlcmlhbBgBIAEoCzIWLnNpbC5zdGFyZmlzaC5NYXRlcmlhbFIIbWF0ZXJpYWwSSgoGc3RhdHVzGAIgASgOMjIuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZU1hdGVyaWFsc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createMaterialFeedbacksRequestDescriptor instead')
const CreateMaterialFeedbacksRequest$json = const {
  '1': 'CreateMaterialFeedbacksRequest',
  '2': const [
    const {'1': 'feedback', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.MaterialFeedback', '10': 'feedback'},
  ],
};

/// Descriptor for `CreateMaterialFeedbacksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMaterialFeedbacksRequestDescriptor = $convert.base64Decode('Ch5DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1JlcXVlc3QSOgoIZmVlZGJhY2sYASABKAsyHi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxGZWVkYmFja1IIZmVlZGJhY2s=');
@$core.Deprecated('Use createMaterialFeedbacksResponseDescriptor instead')
const CreateMaterialFeedbacksResponse$json = const {
  '1': 'CreateMaterialFeedbacksResponse',
  '2': const [
    const {'1': 'feedback', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.MaterialFeedback', '10': 'feedback'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateMaterialFeedbacksResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateMaterialFeedbacksResponse_Status$json],
};

@$core.Deprecated('Use createMaterialFeedbacksResponseDescriptor instead')
const CreateMaterialFeedbacksResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateMaterialFeedbacksResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMaterialFeedbacksResponseDescriptor = $convert.base64Decode('Ch9DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1Jlc3BvbnNlEjoKCGZlZWRiYWNrGAEgASgLMh4uc2lsLnN0YXJmaXNoLk1hdGVyaWFsRmVlZGJhY2tSCGZlZWRiYWNrEkwKBnN0YXR1cxgCIAEoDjI0LnNpbC5zdGFyZmlzaC5DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
