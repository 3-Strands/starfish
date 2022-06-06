///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
import 'google/protobuf/timestamp.pbjson.dart' as $1;
import 'google/type/date.pbjson.dart' as $0;
import 'google/protobuf/field_mask.pbjson.dart' as $2;
import 'google/protobuf/empty.pbjson.dart' as $3;

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
@$core.Deprecated('Use actionDescriptor instead')
const Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.Action.Type', '10': 'type'},
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'creator_id', '3': 4, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'group_id', '3': 5, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'instructions', '3': 6, '4': 1, '5': 9, '10': 'instructions'},
    const {'1': 'material_id', '3': 7, '4': 1, '5': 9, '10': 'materialId'},
    const {'1': 'question', '3': 8, '4': 1, '5': 9, '10': 'question'},
    const {'1': 'date_due', '3': 9, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'dateDue'},
    const {'1': 'edit_history', '3': 10, '4': 3, '5': 11, '6': '.sil.starfish.Edit', '10': 'editHistory'},
  ],
  '4': const [Action_Type$json],
};

@$core.Deprecated('Use actionDescriptor instead')
const Action_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'TEXT_INSTRUCTION', '2': 0},
    const {'1': 'TEXT_RESPONSE', '2': 1},
    const {'1': 'MATERIAL_INSTRUCTION', '2': 2},
    const {'1': 'MATERIAL_RESPONSE', '2': 3},
  ],
};

/// Descriptor for `Action`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionDescriptor = $convert.base64Decode('CgZBY3Rpb24SDgoCaWQYASABKAlSAmlkEi0KBHR5cGUYAiABKA4yGS5zaWwuc3RhcmZpc2guQWN0aW9uLlR5cGVSBHR5cGUSEgoEbmFtZRgDIAEoCVIEbmFtZRIdCgpjcmVhdG9yX2lkGAQgASgJUgljcmVhdG9ySWQSGQoIZ3JvdXBfaWQYBSABKAlSB2dyb3VwSWQSIgoMaW5zdHJ1Y3Rpb25zGAYgASgJUgxpbnN0cnVjdGlvbnMSHwoLbWF0ZXJpYWxfaWQYByABKAlSCm1hdGVyaWFsSWQSGgoIcXVlc3Rpb24YCCABKAlSCHF1ZXN0aW9uEiwKCGRhdGVfZHVlGAkgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIHZGF0ZUR1ZRI1CgxlZGl0X2hpc3RvcnkYCiADKAsyEi5zaWwuc3RhcmZpc2guRWRpdFILZWRpdEhpc3RvcnkiYAoEVHlwZRIUChBURVhUX0lOU1RSVUNUSU9OEAASEQoNVEVYVF9SRVNQT05TRRABEhgKFE1BVEVSSUFMX0lOU1RSVUNUSU9OEAISFQoRTUFURVJJQUxfUkVTUE9OU0UQAw==');
@$core.Deprecated('Use actionUserDescriptor instead')
const ActionUser$json = const {
  '1': 'ActionUser',
  '2': const [
    const {'1': 'action_id', '3': 2, '4': 1, '5': 9, '10': 'actionId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'status', '3': 4, '4': 1, '5': 14, '6': '.sil.starfish.ActionUser.Status', '10': 'status'},
    const {'1': 'teacher_response', '3': 5, '4': 1, '5': 9, '10': 'teacherResponse'},
    const {'1': 'user_response', '3': 7, '4': 1, '5': 9, '10': 'userResponse'},
    const {'1': 'evaluation', '3': 8, '4': 1, '5': 14, '6': '.sil.starfish.ActionUser.Evaluation', '10': 'evaluation'},
  ],
  '4': const [ActionUser_Status$json, ActionUser_Evaluation$json],
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

@$core.Deprecated('Use actionUserDescriptor instead')
const ActionUser_Evaluation$json = const {
  '1': 'Evaluation',
  '2': const [
    const {'1': 'UNSPECIFIED_EVALUATION', '2': 0},
    const {'1': 'GOOD', '2': 1},
    const {'1': 'BAD', '2': 2},
  ],
};

/// Descriptor for `ActionUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List actionUserDescriptor = $convert.base64Decode('CgpBY3Rpb25Vc2VyEhsKCWFjdGlvbl9pZBgCIAEoCVIIYWN0aW9uSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEjcKBnN0YXR1cxgEIAEoDjIfLnNpbC5zdGFyZmlzaC5BY3Rpb25Vc2VyLlN0YXR1c1IGc3RhdHVzEikKEHRlYWNoZXJfcmVzcG9uc2UYBSABKAlSD3RlYWNoZXJSZXNwb25zZRIjCg11c2VyX3Jlc3BvbnNlGAcgASgJUgx1c2VyUmVzcG9uc2USQwoKZXZhbHVhdGlvbhgIIAEoDjIjLnNpbC5zdGFyZmlzaC5BY3Rpb25Vc2VyLkV2YWx1YXRpb25SCmV2YWx1YXRpb24iPgoGU3RhdHVzEhYKElVOU1BFQ0lGSUVEX1NUQVRVUxAAEg4KCklOQ09NUExFVEUQARIMCghDT01QTEVURRACIjsKCkV2YWx1YXRpb24SGgoWVU5TUEVDSUZJRURfRVZBTFVBVElPThAAEggKBEdPT0QQARIHCgNCQUQQAg==');
@$core.Deprecated('Use authenticateRequestDescriptor instead')
const AuthenticateRequest$json = const {
  '1': 'AuthenticateRequest',
  '2': const [
    const {'1': 'firebase_jwt', '3': 1, '4': 1, '5': 9, '10': 'firebaseJwt'},
    const {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
  ],
};

/// Descriptor for `AuthenticateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticateRequestDescriptor = $convert.base64Decode('ChNBdXRoZW50aWNhdGVSZXF1ZXN0EiEKDGZpcmViYXNlX2p3dBgBIAEoCVILZmlyZWJhc2VKd3QSGwoJdXNlcl9uYW1lGAIgASgJUgh1c2VyTmFtZQ==');
@$core.Deprecated('Use authenticateResponseDescriptor instead')
const AuthenticateResponse$json = const {
  '1': 'AuthenticateResponse',
  '2': const [
    const {'1': 'user_token', '3': 1, '4': 1, '5': 9, '10': 'userToken'},
    const {'1': 'expires_at', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'expiresAt'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `AuthenticateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticateResponseDescriptor = $convert.base64Decode('ChRBdXRoZW50aWNhdGVSZXNwb25zZRIdCgp1c2VyX3Rva2VuGAEgASgJUgl1c2VyVG9rZW4SOQoKZXhwaXJlc19hdBgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWV4cGlyZXNBdBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSIwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2Vu');
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
@$core.Deprecated('Use createUpdateActionsRequestDescriptor instead')
const CreateUpdateActionsRequest$json = const {
  '1': 'CreateUpdateActionsRequest',
  '2': const [
    const {'1': 'action', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Action', '10': 'action'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateActionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateActionsRequestDescriptor = $convert.base64Decode('ChpDcmVhdGVVcGRhdGVBY3Rpb25zUmVxdWVzdBIsCgZhY3Rpb24YASABKAsyFC5zaWwuc3RhcmZpc2guQWN0aW9uUgZhY3Rpb24SOwoLdXBkYXRlX21hc2sYAiABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');
@$core.Deprecated('Use createUpdateActionsResponseDescriptor instead')
const CreateUpdateActionsResponse$json = const {
  '1': 'CreateUpdateActionsResponse',
  '2': const [
    const {'1': 'action', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Action', '10': 'action'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateActionsResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateActionsResponse_Status$json],
};

@$core.Deprecated('Use createUpdateActionsResponseDescriptor instead')
const CreateUpdateActionsResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateActionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateActionsResponseDescriptor = $convert.base64Decode('ChtDcmVhdGVVcGRhdGVBY3Rpb25zUmVzcG9uc2USLAoGYWN0aW9uGAEgASgLMhQuc2lsLnN0YXJmaXNoLkFjdGlvblIGYWN0aW9uEkgKBnN0YXR1cxgCIAEoDjIwLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVBY3Rpb25zUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use createUpdateActionUserRequestDescriptor instead')
const CreateUpdateActionUserRequest$json = const {
  '1': 'CreateUpdateActionUserRequest',
  '2': const [
    const {'1': 'action_user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.ActionUser', '10': 'actionUser'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateActionUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateActionUserRequestDescriptor = $convert.base64Decode('Ch1DcmVhdGVVcGRhdGVBY3Rpb25Vc2VyUmVxdWVzdBI5CgthY3Rpb25fdXNlchgBIAEoCzIYLnNpbC5zdGFyZmlzaC5BY3Rpb25Vc2VyUgphY3Rpb25Vc2VyEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use createUpdateActionUserResponseDescriptor instead')
const CreateUpdateActionUserResponse$json = const {
  '1': 'CreateUpdateActionUserResponse',
  '2': const [
    const {'1': 'action_user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.ActionUser', '10': 'actionUser'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateActionUserResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateActionUserResponse_Status$json],
};

@$core.Deprecated('Use createUpdateActionUserResponseDescriptor instead')
const CreateUpdateActionUserResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateActionUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateActionUserResponseDescriptor = $convert.base64Decode('Ch5DcmVhdGVVcGRhdGVBY3Rpb25Vc2VyUmVzcG9uc2USOQoLYWN0aW9uX3VzZXIYASABKAsyGC5zaWwuc3RhcmZpc2guQWN0aW9uVXNlclIKYWN0aW9uVXNlchJLCgZzdGF0dXMYAiABKA4yMy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlQWN0aW9uVXNlclJlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateGroupEvaluationRequestDescriptor instead')
const CreateUpdateGroupEvaluationRequest$json = const {
  '1': 'CreateUpdateGroupEvaluationRequest',
  '2': const [
    const {'1': 'group_evaluation', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.GroupEvaluation', '10': 'groupEvaluation'},
  ],
};

/// Descriptor for `CreateUpdateGroupEvaluationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupEvaluationRequestDescriptor = $convert.base64Decode('CiJDcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXF1ZXN0EkgKEGdyb3VwX2V2YWx1YXRpb24YASABKAsyHS5zaWwuc3RhcmZpc2guR3JvdXBFdmFsdWF0aW9uUg9ncm91cEV2YWx1YXRpb24=');
@$core.Deprecated('Use createUpdateGroupEvaluationResponseDescriptor instead')
const CreateUpdateGroupEvaluationResponse$json = const {
  '1': 'CreateUpdateGroupEvaluationResponse',
  '2': const [
    const {'1': 'group_evaluation', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.GroupEvaluation', '10': 'groupEvaluation'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateGroupEvaluationResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateGroupEvaluationResponse_Status$json],
};

@$core.Deprecated('Use createUpdateGroupEvaluationResponseDescriptor instead')
const CreateUpdateGroupEvaluationResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateGroupEvaluationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupEvaluationResponseDescriptor = $convert.base64Decode('CiNDcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXNwb25zZRJIChBncm91cF9ldmFsdWF0aW9uGAEgASgLMh0uc2lsLnN0YXJmaXNoLkdyb3VwRXZhbHVhdGlvblIPZ3JvdXBFdmFsdWF0aW9uElAKBnN0YXR1cxgCIAEoDjI4LnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use createUpdateGroupsRequestDescriptor instead')
const CreateUpdateGroupsRequest$json = const {
  '1': 'CreateUpdateGroupsRequest',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Group', '10': 'group'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupsRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVVcGRhdGVHcm91cHNSZXF1ZXN0EikKBWdyb3VwGAEgASgLMhMuc2lsLnN0YXJmaXNoLkdyb3VwUgVncm91cBI7Cgt1cGRhdGVfbWFzaxgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tSCnVwZGF0ZU1hc2s=');
@$core.Deprecated('Use createUpdateGroupsResponseDescriptor instead')
const CreateUpdateGroupsResponse$json = const {
  '1': 'CreateUpdateGroupsResponse',
  '2': const [
    const {'1': 'group', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Group', '10': 'group'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateGroupsResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateGroupsResponse_Status$json],
};

@$core.Deprecated('Use createUpdateGroupsResponseDescriptor instead')
const CreateUpdateGroupsResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateGroupsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupsResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVVcGRhdGVHcm91cHNSZXNwb25zZRIpCgVncm91cBgBIAEoCzITLnNpbC5zdGFyZmlzaC5Hcm91cFIFZ3JvdXASRwoGc3RhdHVzGAIgASgOMi8uc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUdyb3Vwc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateGroupUsersRequestDescriptor instead')
const CreateUpdateGroupUsersRequest$json = const {
  '1': 'CreateUpdateGroupUsersRequest',
  '2': const [
    const {'1': 'group_user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.GroupUser', '10': 'groupUser'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateGroupUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupUsersRequestDescriptor = $convert.base64Decode('Ch1DcmVhdGVVcGRhdGVHcm91cFVzZXJzUmVxdWVzdBI2Cgpncm91cF91c2VyGAEgASgLMhcuc2lsLnN0YXJmaXNoLkdyb3VwVXNlclIJZ3JvdXBVc2VyEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use createUpdateGroupUsersResponseDescriptor instead')
const CreateUpdateGroupUsersResponse$json = const {
  '1': 'CreateUpdateGroupUsersResponse',
  '2': const [
    const {'1': 'group_user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.GroupUser', '10': 'groupUser'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateGroupUsersResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateGroupUsersResponse_Status$json],
};

@$core.Deprecated('Use createUpdateGroupUsersResponseDescriptor instead')
const CreateUpdateGroupUsersResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateGroupUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupUsersResponseDescriptor = $convert.base64Decode('Ch5DcmVhdGVVcGRhdGVHcm91cFVzZXJzUmVzcG9uc2USNgoKZ3JvdXBfdXNlchgBIAEoCzIXLnNpbC5zdGFyZmlzaC5Hcm91cFVzZXJSCWdyb3VwVXNlchJLCgZzdGF0dXMYAiABKA4yMy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlR3JvdXBVc2Vyc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateLearnerEvaluationRequestDescriptor instead')
const CreateUpdateLearnerEvaluationRequest$json = const {
  '1': 'CreateUpdateLearnerEvaluationRequest',
  '2': const [
    const {'1': 'learner_evaluation', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.LearnerEvaluation', '10': 'learnerEvaluation'},
  ],
};

/// Descriptor for `CreateUpdateLearnerEvaluationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateLearnerEvaluationRequestDescriptor = $convert.base64Decode('CiRDcmVhdGVVcGRhdGVMZWFybmVyRXZhbHVhdGlvblJlcXVlc3QSTgoSbGVhcm5lcl9ldmFsdWF0aW9uGAEgASgLMh8uc2lsLnN0YXJmaXNoLkxlYXJuZXJFdmFsdWF0aW9uUhFsZWFybmVyRXZhbHVhdGlvbg==');
@$core.Deprecated('Use createUpdateLearnerEvaluationResponseDescriptor instead')
const CreateUpdateLearnerEvaluationResponse$json = const {
  '1': 'CreateUpdateLearnerEvaluationResponse',
  '2': const [
    const {'1': 'learner_evaluation', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.LearnerEvaluation', '10': 'learnerEvaluation'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateLearnerEvaluationResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateLearnerEvaluationResponse_Status$json],
};

@$core.Deprecated('Use createUpdateLearnerEvaluationResponseDescriptor instead')
const CreateUpdateLearnerEvaluationResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateLearnerEvaluationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateLearnerEvaluationResponseDescriptor = $convert.base64Decode('CiVDcmVhdGVVcGRhdGVMZWFybmVyRXZhbHVhdGlvblJlc3BvbnNlEk4KEmxlYXJuZXJfZXZhbHVhdGlvbhgBIAEoCzIfLnNpbC5zdGFyZmlzaC5MZWFybmVyRXZhbHVhdGlvblIRbGVhcm5lckV2YWx1YXRpb24SUgoGc3RhdHVzGAIgASgOMjouc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUxlYXJuZXJFdmFsdWF0aW9uUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
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
@$core.Deprecated('Use createUpdateOutputRequestDescriptor instead')
const CreateUpdateOutputRequest$json = const {
  '1': 'CreateUpdateOutputRequest',
  '2': const [
    const {'1': 'output', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Output', '10': 'output'},
  ],
};

/// Descriptor for `CreateUpdateOutputRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateOutputRequestDescriptor = $convert.base64Decode('ChlDcmVhdGVVcGRhdGVPdXRwdXRSZXF1ZXN0EiwKBm91dHB1dBgBIAEoCzIULnNpbC5zdGFyZmlzaC5PdXRwdXRSBm91dHB1dA==');
@$core.Deprecated('Use createUpdateOutputResponseDescriptor instead')
const CreateUpdateOutputResponse$json = const {
  '1': 'CreateUpdateOutputResponse',
  '2': const [
    const {'1': 'output', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Output', '10': 'output'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateOutputResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateOutputResponse_Status$json],
};

@$core.Deprecated('Use createUpdateOutputResponseDescriptor instead')
const CreateUpdateOutputResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateOutputResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateOutputResponseDescriptor = $convert.base64Decode('ChpDcmVhdGVVcGRhdGVPdXRwdXRSZXNwb25zZRIsCgZvdXRwdXQYASABKAsyFC5zaWwuc3RhcmZpc2guT3V0cHV0UgZvdXRwdXQSRwoGc3RhdHVzGAIgASgOMi8uc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZU91dHB1dFJlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateTeacherResponseRequestDescriptor instead')
const CreateUpdateTeacherResponseRequest$json = const {
  '1': 'CreateUpdateTeacherResponseRequest',
  '2': const [
    const {'1': 'teacher_response', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.TeacherResponse', '10': 'teacherResponse'},
  ],
};

/// Descriptor for `CreateUpdateTeacherResponseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateTeacherResponseRequestDescriptor = $convert.base64Decode('CiJDcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VSZXF1ZXN0EkgKEHRlYWNoZXJfcmVzcG9uc2UYASABKAsyHS5zaWwuc3RhcmZpc2guVGVhY2hlclJlc3BvbnNlUg90ZWFjaGVyUmVzcG9uc2U=');
@$core.Deprecated('Use createUpdateTeacherResponseResponseDescriptor instead')
const CreateUpdateTeacherResponseResponse$json = const {
  '1': 'CreateUpdateTeacherResponseResponse',
  '2': const [
    const {'1': 'teacher_response', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.TeacherResponse', '10': 'teacherResponse'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateTeacherResponseResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateTeacherResponseResponse_Status$json],
};

@$core.Deprecated('Use createUpdateTeacherResponseResponseDescriptor instead')
const CreateUpdateTeacherResponseResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateTeacherResponseResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateTeacherResponseResponseDescriptor = $convert.base64Decode('CiNDcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VSZXNwb25zZRJIChB0ZWFjaGVyX3Jlc3BvbnNlGAEgASgLMh0uc2lsLnN0YXJmaXNoLlRlYWNoZXJSZXNwb25zZVIPdGVhY2hlclJlc3BvbnNlElAKBnN0YXR1cxgCIAEoDjI4LnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VSZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use createUpdateTransformationRequestDescriptor instead')
const CreateUpdateTransformationRequest$json = const {
  '1': 'CreateUpdateTransformationRequest',
  '2': const [
    const {'1': 'transformation', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Transformation', '10': 'transformation'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateTransformationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateTransformationRequestDescriptor = $convert.base64Decode('CiFDcmVhdGVVcGRhdGVUcmFuc2Zvcm1hdGlvblJlcXVlc3QSRAoOdHJhbnNmb3JtYXRpb24YASABKAsyHC5zaWwuc3RhcmZpc2guVHJhbnNmb3JtYXRpb25SDnRyYW5zZm9ybWF0aW9uEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use createUpdateTransformationResponseDescriptor instead')
const CreateUpdateTransformationResponse$json = const {
  '1': 'CreateUpdateTransformationResponse',
  '2': const [
    const {'1': 'transformation', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.Transformation', '10': 'transformation'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateTransformationResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateTransformationResponse_Status$json],
};

@$core.Deprecated('Use createUpdateTransformationResponseDescriptor instead')
const CreateUpdateTransformationResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateTransformationResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateTransformationResponseDescriptor = $convert.base64Decode('CiJDcmVhdGVVcGRhdGVUcmFuc2Zvcm1hdGlvblJlc3BvbnNlEkQKDnRyYW5zZm9ybWF0aW9uGAEgASgLMhwuc2lsLnN0YXJmaXNoLlRyYW5zZm9ybWF0aW9uUg50cmFuc2Zvcm1hdGlvbhJPCgZzdGF0dXMYAiABKA4yNy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlVHJhbnNmb3JtYXRpb25SZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use createUpdateUserRequestDescriptor instead')
const CreateUpdateUserRequest$json = const {
  '1': 'CreateUpdateUserRequest',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.User', '10': 'user'},
    const {'1': 'update_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '10': 'updateMask'},
  ],
};

/// Descriptor for `CreateUpdateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateUserRequestDescriptor = $convert.base64Decode('ChdDcmVhdGVVcGRhdGVVc2VyUmVxdWVzdBImCgR1c2VyGAEgASgLMhIuc2lsLnN0YXJmaXNoLlVzZXJSBHVzZXISOwoLdXBkYXRlX21hc2sYAiABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');
@$core.Deprecated('Use createUpdateUserResponseDescriptor instead')
const CreateUpdateUserResponse$json = const {
  '1': 'CreateUpdateUserResponse',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.User', '10': 'user'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.CreateUpdateUserResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [CreateUpdateUserResponse_Status$json],
};

@$core.Deprecated('Use createUpdateUserResponseDescriptor instead')
const CreateUpdateUserResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `CreateUpdateUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateUserResponseDescriptor = $convert.base64Decode('ChhDcmVhdGVVcGRhdGVVc2VyUmVzcG9uc2USJgoEdXNlchgBIAEoCzISLnNpbC5zdGFyZmlzaC5Vc2VyUgR1c2VyEkUKBnN0YXR1cxgCIAEoDjItLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVVc2VyUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use deleteActionRequestDescriptor instead')
const DeleteActionRequest$json = const {
  '1': 'DeleteActionRequest',
  '2': const [
    const {'1': 'action_id', '3': 1, '4': 1, '5': 9, '10': 'actionId'},
  ],
};

/// Descriptor for `DeleteActionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteActionRequestDescriptor = $convert.base64Decode('ChNEZWxldGVBY3Rpb25SZXF1ZXN0EhsKCWFjdGlvbl9pZBgBIAEoCVIIYWN0aW9uSWQ=');
@$core.Deprecated('Use deleteActionResponseDescriptor instead')
const DeleteActionResponse$json = const {
  '1': 'DeleteActionResponse',
  '2': const [
    const {'1': 'action_id', '3': 1, '4': 1, '5': 9, '10': 'actionId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.sil.starfish.DeleteActionResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [DeleteActionResponse_Status$json],
};

@$core.Deprecated('Use deleteActionResponseDescriptor instead')
const DeleteActionResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `DeleteActionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteActionResponseDescriptor = $convert.base64Decode('ChREZWxldGVBY3Rpb25SZXNwb25zZRIbCglhY3Rpb25faWQYASABKAlSCGFjdGlvbklkEkEKBnN0YXR1cxgDIAEoDjIpLnNpbC5zdGFyZmlzaC5EZWxldGVBY3Rpb25SZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use deleteGroupUsersResponseDescriptor instead')
const DeleteGroupUsersResponse$json = const {
  '1': 'DeleteGroupUsersResponse',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.sil.starfish.DeleteGroupUsersResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [DeleteGroupUsersResponse_Status$json],
};

@$core.Deprecated('Use deleteGroupUsersResponseDescriptor instead')
const DeleteGroupUsersResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `DeleteGroupUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupUsersResponseDescriptor = $convert.base64Decode('ChhEZWxldGVHcm91cFVzZXJzUmVzcG9uc2USFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEhkKCGdyb3VwX2lkGAIgASgJUgdncm91cElkEkUKBnN0YXR1cxgDIAEoDjItLnNpbC5zdGFyZmlzaC5EZWxldGVHcm91cFVzZXJzUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use deleteMaterialRequestDescriptor instead')
const DeleteMaterialRequest$json = const {
  '1': 'DeleteMaterialRequest',
  '2': const [
    const {'1': 'material_id', '3': 1, '4': 1, '5': 9, '10': 'materialId'},
  ],
};

/// Descriptor for `DeleteMaterialRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMaterialRequestDescriptor = $convert.base64Decode('ChVEZWxldGVNYXRlcmlhbFJlcXVlc3QSHwoLbWF0ZXJpYWxfaWQYASABKAlSCm1hdGVyaWFsSWQ=');
@$core.Deprecated('Use deleteMaterialResponseDescriptor instead')
const DeleteMaterialResponse$json = const {
  '1': 'DeleteMaterialResponse',
  '2': const [
    const {'1': 'material_id', '3': 1, '4': 1, '5': 9, '10': 'materialId'},
    const {'1': 'status', '3': 3, '4': 1, '5': 14, '6': '.sil.starfish.DeleteMaterialResponse.Status', '10': 'status'},
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [DeleteMaterialResponse_Status$json],
};

@$core.Deprecated('Use deleteMaterialResponseDescriptor instead')
const DeleteMaterialResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `DeleteMaterialResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMaterialResponseDescriptor = $convert.base64Decode('ChZEZWxldGVNYXRlcmlhbFJlc3BvbnNlEh8KC21hdGVyaWFsX2lkGAEgASgJUgptYXRlcmlhbElkEkMKBnN0YXR1cxgDIAEoDjIrLnNpbC5zdGFyZmlzaC5EZWxldGVNYXRlcmlhbFJlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
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
@$core.Deprecated('Use evaluationCategoryDescriptor instead')
const EvaluationCategory$json = const {
  '1': 'EvaluationCategory',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'value_names', '3': 3, '4': 3, '5': 11, '6': '.sil.starfish.EvaluationValueName', '10': 'valueNames'},
  ],
};

/// Descriptor for `EvaluationCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluationCategoryDescriptor = $convert.base64Decode('ChJFdmFsdWF0aW9uQ2F0ZWdvcnkSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSQgoLdmFsdWVfbmFtZXMYAyADKAsyIS5zaWwuc3RhcmZpc2guRXZhbHVhdGlvblZhbHVlTmFtZVIKdmFsdWVOYW1lcw==');
@$core.Deprecated('Use evaluationValueNameDescriptor instead')
const EvaluationValueName$json = const {
  '1': 'EvaluationValueName',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `EvaluationValueName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluationValueNameDescriptor = $convert.base64Decode('ChNFdmFsdWF0aW9uVmFsdWVOYW1lEhQKBXZhbHVlGAEgASgFUgV2YWx1ZRISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use groupDescriptor instead')
const Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'language_ids', '3': 3, '4': 3, '5': 9, '10': 'languageIds'},
    const {'1': 'users', '3': 4, '4': 3, '5': 11, '6': '.sil.starfish.GroupUser', '10': 'users'},
    const {'1': 'evaluation_category_ids', '3': 5, '4': 3, '5': 9, '10': 'evaluationCategoryIds'},
    const {'1': 'edit_history', '3': 7, '4': 3, '5': 11, '6': '.sil.starfish.Edit', '10': 'editHistory'},
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'link_email', '3': 9, '4': 1, '5': 9, '10': 'linkEmail'},
    const {'1': 'languages', '3': 10, '4': 3, '5': 11, '6': '.sil.starfish.Group.LanguagesEntry', '10': 'languages'},
    const {'1': 'status', '3': 11, '4': 1, '5': 14, '6': '.sil.starfish.Group.Status', '10': 'status'},
    const {'1': 'output_markers', '3': 13, '4': 3, '5': 11, '6': '.sil.starfish.OutputMarker', '10': 'outputMarkers'},
  ],
  '3': const [Group_LanguagesEntry$json],
  '4': const [Group_Status$json],
};

@$core.Deprecated('Use groupDescriptor instead')
const Group_LanguagesEntry$json = const {
  '1': 'LanguagesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
};

@$core.Deprecated('Use groupDescriptor instead')
const Group_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'ACTIVE', '2': 0},
    const {'1': 'INACTIVE', '2': 1},
  ],
};

/// Descriptor for `Group`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupDescriptor = $convert.base64Decode('CgVHcm91cBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIhCgxsYW5ndWFnZV9pZHMYAyADKAlSC2xhbmd1YWdlSWRzEi0KBXVzZXJzGAQgAygLMhcuc2lsLnN0YXJmaXNoLkdyb3VwVXNlclIFdXNlcnMSNgoXZXZhbHVhdGlvbl9jYXRlZ29yeV9pZHMYBSADKAlSFWV2YWx1YXRpb25DYXRlZ29yeUlkcxI1CgxlZGl0X2hpc3RvcnkYByADKAsyEi5zaWwuc3RhcmZpc2guRWRpdFILZWRpdEhpc3RvcnkSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCmxpbmtfZW1haWwYCSABKAlSCWxpbmtFbWFpbBJACglsYW5ndWFnZXMYCiADKAsyIi5zaWwuc3RhcmZpc2guR3JvdXAuTGFuZ3VhZ2VzRW50cnlSCWxhbmd1YWdlcxIyCgZzdGF0dXMYCyABKA4yGi5zaWwuc3RhcmZpc2guR3JvdXAuU3RhdHVzUgZzdGF0dXMSQQoOb3V0cHV0X21hcmtlcnMYDSADKAsyGi5zaWwuc3RhcmZpc2guT3V0cHV0TWFya2VyUg1vdXRwdXRNYXJrZXJzGjwKDkxhbmd1YWdlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEiIgoGU3RhdHVzEgoKBkFDVElWRRAAEgwKCElOQUNUSVZFEAE=');
@$core.Deprecated('Use groupEvaluationDescriptor instead')
const GroupEvaluation$json = const {
  '1': 'GroupEvaluation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'month', '3': 4, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'month'},
    const {'1': 'evaluation', '3': 5, '4': 1, '5': 14, '6': '.sil.starfish.GroupEvaluation.Evaluation', '10': 'evaluation'},
  ],
  '4': const [GroupEvaluation_Evaluation$json],
};

@$core.Deprecated('Use groupEvaluationDescriptor instead')
const GroupEvaluation_Evaluation$json = const {
  '1': 'Evaluation',
  '2': const [
    const {'1': 'EVAL_UNSPECIFIED', '2': 0},
    const {'1': 'BAD', '2': 1},
    const {'1': 'GOOD', '2': 2},
  ],
};

/// Descriptor for `GroupEvaluation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List groupEvaluationDescriptor = $convert.base64Decode('Cg9Hcm91cEV2YWx1YXRpb24SDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJZBInCgVtb250aBgEIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSBW1vbnRoEkgKCmV2YWx1YXRpb24YBSABKA4yKC5zaWwuc3RhcmZpc2guR3JvdXBFdmFsdWF0aW9uLkV2YWx1YXRpb25SCmV2YWx1YXRpb24iNQoKRXZhbHVhdGlvbhIUChBFVkFMX1VOU1BFQ0lGSUVEEAASBwoDQkFEEAESCAoER09PRBAC');
@$core.Deprecated('Use groupUserDescriptor instead')
const GroupUser$json = const {
  '1': 'GroupUser',
  '2': const [
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'role', '3': 4, '4': 1, '5': 14, '6': '.sil.starfish.GroupUser.Role', '10': 'role'},
    const {'1': 'profile', '3': 5, '4': 1, '5': 9, '10': 'profile'},
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
final $typed_data.Uint8List groupUserDescriptor = $convert.base64Decode('CglHcm91cFVzZXISGQoIZ3JvdXBfaWQYAiABKAlSB2dyb3VwSWQSFwoHdXNlcl9pZBgDIAEoCVIGdXNlcklkEjAKBHJvbGUYBCABKA4yHC5zaWwuc3RhcmZpc2guR3JvdXBVc2VyLlJvbGVSBHJvbGUSGAoHcHJvZmlsZRgFIAEoCVIHcHJvZmlsZSJBCgRSb2xlEhQKEFVOU1BFQ0lGSUVEX1JPTEUQABILCgdMRUFSTkVSEAESCwoHVEVBQ0hFUhACEgkKBUFETUlOEAM=');
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
@$core.Deprecated('Use learnerEvaluationDescriptor instead')
const LearnerEvaluation$json = const {
  '1': 'LearnerEvaluation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'learner_id', '3': 2, '4': 1, '5': 9, '10': 'learnerId'},
    const {'1': 'evaluator_id', '3': 3, '4': 1, '5': 9, '10': 'evaluatorId'},
    const {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'month', '3': 5, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'month'},
    const {'1': 'category_id', '3': 6, '4': 1, '5': 9, '10': 'categoryId'},
    const {'1': 'evaluation', '3': 7, '4': 1, '5': 5, '10': 'evaluation'},
  ],
};

/// Descriptor for `LearnerEvaluation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List learnerEvaluationDescriptor = $convert.base64Decode('ChFMZWFybmVyRXZhbHVhdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKbGVhcm5lcl9pZBgCIAEoCVIJbGVhcm5lcklkEiEKDGV2YWx1YXRvcl9pZBgDIAEoCVILZXZhbHVhdG9ySWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSJwoFbW9udGgYBSABKAsyES5nb29nbGUudHlwZS5EYXRlUgVtb250aBIfCgtjYXRlZ29yeV9pZBgGIAEoCVIKY2F0ZWdvcnlJZBIeCgpldmFsdWF0aW9uGAcgASgFUgpldmFsdWF0aW9u');
@$core.Deprecated('Use listActionsRequestDescriptor instead')
const ListActionsRequest$json = const {
  '1': 'ListActionsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListActionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listActionsRequestDescriptor = $convert.base64Decode('ChJMaXN0QWN0aW9uc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listAllCountriesRequestDescriptor instead')
const ListAllCountriesRequest$json = const {
  '1': 'ListAllCountriesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListAllCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAllCountriesRequestDescriptor = $convert.base64Decode('ChdMaXN0QWxsQ291bnRyaWVzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listEvaluationCategoriesRequestDescriptor instead')
const ListEvaluationCategoriesRequest$json = const {
  '1': 'ListEvaluationCategoriesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListEvaluationCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEvaluationCategoriesRequestDescriptor = $convert.base64Decode('Ch9MaXN0RXZhbHVhdGlvbkNhdGVnb3JpZXNSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use listGroupsRequestDescriptor instead')
const ListGroupsRequest$json = const {
  '1': 'ListGroupsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupsRequestDescriptor = $convert.base64Decode('ChFMaXN0R3JvdXBzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listGroupEvaluationsRequestDescriptor instead')
const ListGroupEvaluationsRequest$json = const {
  '1': 'ListGroupEvaluationsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListGroupEvaluationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupEvaluationsRequestDescriptor = $convert.base64Decode('ChtMaXN0R3JvdXBFdmFsdWF0aW9uc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listLanguagesRequestDescriptor instead')
const ListLanguagesRequest$json = const {
  '1': 'ListLanguagesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListLanguagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLanguagesRequestDescriptor = $convert.base64Decode('ChRMaXN0TGFuZ3VhZ2VzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listLearnerEvaluationsRequestDescriptor instead')
const ListLearnerEvaluationsRequest$json = const {
  '1': 'ListLearnerEvaluationsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListLearnerEvaluationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLearnerEvaluationsRequestDescriptor = $convert.base64Decode('Ch1MaXN0TGVhcm5lckV2YWx1YXRpb25zUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listMaterialsRequestDescriptor instead')
const ListMaterialsRequest$json = const {
  '1': 'ListMaterialsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListMaterialsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialsRequestDescriptor = $convert.base64Decode('ChRMaXN0TWF0ZXJpYWxzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listMaterialTopicsRequestDescriptor instead')
const ListMaterialTopicsRequest$json = const {
  '1': 'ListMaterialTopicsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListMaterialTopicsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialTopicsRequestDescriptor = $convert.base64Decode('ChlMaXN0TWF0ZXJpYWxUb3BpY3NSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use listMaterialTypesRequestDescriptor instead')
const ListMaterialTypesRequest$json = const {
  '1': 'ListMaterialTypesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListMaterialTypesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialTypesRequestDescriptor = $convert.base64Decode('ChhMaXN0TWF0ZXJpYWxUeXBlc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listOutputsRequestDescriptor instead')
const ListOutputsRequest$json = const {
  '1': 'ListOutputsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListOutputsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOutputsRequestDescriptor = $convert.base64Decode('ChJMaXN0T3V0cHV0c1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listTeacherResponsesRequestDescriptor instead')
const ListTeacherResponsesRequest$json = const {
  '1': 'ListTeacherResponsesRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListTeacherResponsesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTeacherResponsesRequestDescriptor = $convert.base64Decode('ChtMaXN0VGVhY2hlclJlc3BvbnNlc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listTransformationsRequestDescriptor instead')
const ListTransformationsRequest$json = const {
  '1': 'ListTransformationsRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListTransformationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransformationsRequestDescriptor = $convert.base64Decode('ChpMaXN0VHJhbnNmb3JtYXRpb25zUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listUsersRequestDescriptor instead')
const ListUsersRequest$json = const {
  '1': 'ListUsersRequest',
  '2': const [
    const {'1': 'updated_since', '3': 1, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'updatedSince'},
  ],
};

/// Descriptor for `ListUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersRequestDescriptor = $convert.base64Decode('ChBMaXN0VXNlcnNSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
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
    const {'1': 'languages', '3': 18, '4': 3, '5': 11, '6': '.sil.starfish.Material.LanguagesEntry', '10': 'languages'},
  ],
  '3': const [Material_LanguagesEntry$json],
  '4': const [Material_Status$json, Material_Visibility$json, Material_Editability$json],
};

@$core.Deprecated('Use materialDescriptor instead')
const Material_LanguagesEntry$json = const {
  '1': 'LanguagesEntry',
  '2': const [
    const {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    const {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': const {'7': true},
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
final $typed_data.Uint8List materialDescriptor = $convert.base64Decode('CghNYXRlcmlhbBIOCgJpZBgBIAEoCVICaWQSHQoKY3JlYXRvcl9pZBgCIAEoCVIJY3JlYXRvcklkEjUKBnN0YXR1cxgDIAEoDjIdLnNpbC5zdGFyZmlzaC5NYXRlcmlhbC5TdGF0dXNSBnN0YXR1cxJBCgp2aXNpYmlsaXR5GAQgASgOMiEuc2lsLnN0YXJmaXNoLk1hdGVyaWFsLlZpc2liaWxpdHlSCnZpc2liaWxpdHkSRAoLZWRpdGFiaWxpdHkYBSABKA4yIi5zaWwuc3RhcmZpc2guTWF0ZXJpYWwuRWRpdGFiaWxpdHlSC2VkaXRhYmlsaXR5EhQKBXRpdGxlGAYgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgHIAEoCVILZGVzY3JpcHRpb24SJwoPdGFyZ2V0X2F1ZGllbmNlGAggASgJUg50YXJnZXRBdWRpZW5jZRIQCgN1cmwYCSABKAlSA3VybBIUCgVmaWxlcxgKIAMoCVIFZmlsZXMSIQoMbGFuZ3VhZ2VfaWRzGAsgAygJUgtsYW5ndWFnZUlkcxIZCgh0eXBlX2lkcxgMIAMoCVIHdHlwZUlkcxIWCgZ0b3BpY3MYDSADKAlSBnRvcGljcxI8CglmZWVkYmFja3MYDiADKAsyHi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxGZWVkYmFja1IJZmVlZGJhY2tzEjQKDGRhdGVfY3JlYXRlZBgPIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSC2RhdGVDcmVhdGVkEjQKDGRhdGVfdXBkYXRlZBgQIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSC2RhdGVVcGRhdGVkEjUKDGVkaXRfaGlzdG9yeRgRIAMoCzISLnNpbC5zdGFyZmlzaC5FZGl0UgtlZGl0SGlzdG9yeRJDCglsYW5ndWFnZXMYEiADKAsyJS5zaWwuc3RhcmZpc2guTWF0ZXJpYWwuTGFuZ3VhZ2VzRW50cnlSCWxhbmd1YWdlcxo8Cg5MYW5ndWFnZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBIjoKBlN0YXR1cxIWChJVTlNQRUNJRklFRF9TVEFUVVMQABIKCgZBQ1RJVkUQARIMCghJTkFDVElWRRACIlgKClZpc2liaWxpdHkSGgoWVU5TUEVDSUZJRURfVklTSUJJTElUWRAAEhAKDENSRUFUT1JfVklFVxABEg4KCkdST1VQX1ZJRVcQAhIMCghBTExfVklFVxADIkwKC0VkaXRhYmlsaXR5EhsKF1VOU1BFQ0lGSUVEX0VESVRBQklMSVRZEAASEAoMQ1JFQVRPUl9FRElUEAESDgoKR1JPVVBfRURJVBAC');
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
@$core.Deprecated('Use outputDescriptor instead')
const Output$json = const {
  '1': 'Output',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'month', '3': 5, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'month'},
    const {'1': 'value', '3': 6, '4': 1, '5': 3, '10': 'value'},
    const {'1': 'output_marker', '3': 7, '4': 1, '5': 11, '6': '.sil.starfish.OutputMarker', '10': 'outputMarker'},
  ],
};

/// Descriptor for `Output`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outputDescriptor = $convert.base64Decode('CgZPdXRwdXQSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSJwoFbW9udGgYBSABKAsyES5nb29nbGUudHlwZS5EYXRlUgVtb250aBIUCgV2YWx1ZRgGIAEoA1IFdmFsdWUSPwoNb3V0cHV0X21hcmtlchgHIAEoCzIaLnNpbC5zdGFyZmlzaC5PdXRwdXRNYXJrZXJSDG91dHB1dE1hcmtlcg==');
@$core.Deprecated('Use outputMarkerDescriptor instead')
const OutputMarker$json = const {
  '1': 'OutputMarker',
  '2': const [
    const {'1': 'project_id', '3': 2, '4': 1, '5': 9, '10': 'projectId'},
    const {'1': 'marker_id', '3': 3, '4': 1, '5': 9, '10': 'markerId'},
    const {'1': 'marker_name', '3': 4, '4': 1, '5': 9, '10': 'markerName'},
  ],
};

/// Descriptor for `OutputMarker`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outputMarkerDescriptor = $convert.base64Decode('CgxPdXRwdXRNYXJrZXISHQoKcHJvamVjdF9pZBgCIAEoCVIJcHJvamVjdElkEhsKCW1hcmtlcl9pZBgDIAEoCVIIbWFya2VySWQSHwoLbWFya2VyX25hbWUYBCABKAlSCm1hcmtlck5hbWU=');
@$core.Deprecated('Use refreshSessionRequestDescriptor instead')
const RefreshSessionRequest$json = const {
  '1': 'RefreshSessionRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSessionRequestDescriptor = $convert.base64Decode('ChVSZWZyZXNoU2Vzc2lvblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbg==');
@$core.Deprecated('Use teacherResponseDescriptor instead')
const TeacherResponse$json = const {
  '1': 'TeacherResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'learner_id', '3': 2, '4': 1, '5': 9, '10': 'learnerId'},
    const {'1': 'teacher_id', '3': 3, '4': 1, '5': 9, '10': 'teacherId'},
    const {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'month', '3': 5, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'month'},
    const {'1': 'response', '3': 6, '4': 1, '5': 9, '10': 'response'},
  ],
};

/// Descriptor for `TeacherResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List teacherResponseDescriptor = $convert.base64Decode('Cg9UZWFjaGVyUmVzcG9uc2USDgoCaWQYASABKAlSAmlkEh0KCmxlYXJuZXJfaWQYAiABKAlSCWxlYXJuZXJJZBIdCgp0ZWFjaGVyX2lkGAMgASgJUgl0ZWFjaGVySWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSJwoFbW9udGgYBSABKAsyES5nb29nbGUudHlwZS5EYXRlUgVtb250aBIaCghyZXNwb25zZRgGIAEoCVIIcmVzcG9uc2U=');
@$core.Deprecated('Use transformationDescriptor instead')
const Transformation$json = const {
  '1': 'Transformation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'month', '3': 4, '4': 1, '5': 11, '6': '.google.type.Date', '10': 'month'},
    const {'1': 'impact_story', '3': 5, '4': 1, '5': 9, '10': 'impactStory'},
    const {'1': 'files', '3': 6, '4': 3, '5': 9, '10': 'files'},
  ],
};

/// Descriptor for `Transformation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transformationDescriptor = $convert.base64Decode('Cg5UcmFuc2Zvcm1hdGlvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhkKCGdyb3VwX2lkGAMgASgJUgdncm91cElkEicKBW1vbnRoGAQgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIFbW9udGgSIQoMaW1wYWN0X3N0b3J5GAUgASgJUgtpbXBhY3RTdG9yeRIUCgVmaWxlcxgGIAMoCVIFZmlsZXM=');
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
    const {'1': 'status', '3': 13, '4': 1, '5': 14, '6': '.sil.starfish.User.Status', '10': 'status'},
    const {'1': 'creator_id', '3': 14, '4': 1, '5': 9, '10': 'creatorId'},
  ],
  '4': const [User_Status$json],
};

@$core.Deprecated('Use userDescriptor instead')
const User_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'STATUS_UNSPECIFIED', '2': 0},
    const {'1': 'ACTIVE', '2': 1},
    const {'1': 'ACCOUNT_PENDING', '2': 2},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXBob25lGAMgASgJUgVwaG9uZRIfCgtjb3VudHJ5X2lkcxgEIAMoCVIKY291bnRyeUlkcxIhCgxsYW5ndWFnZV9pZHMYBSADKAlSC2xhbmd1YWdlSWRzEh8KC2xpbmtfZ3JvdXBzGAYgASgIUgpsaW5rR3JvdXBzEi8KBmdyb3VwcxgHIAMoCzIXLnNpbC5zdGFyZmlzaC5Hcm91cFVzZXJSBmdyb3VwcxIyCgdhY3Rpb25zGAggAygLMhguc2lsLnN0YXJmaXNoLkFjdGlvblVzZXJSB2FjdGlvbnMSSQoUc2VsZWN0ZWRfYWN0aW9uc190YWIYCSABKA4yFy5zaWwuc3RhcmZpc2guQWN0aW9uVGFiUhJzZWxlY3RlZEFjdGlvbnNUYWISSgoUc2VsZWN0ZWRfcmVzdWx0c190YWIYCiABKA4yGC5zaWwuc3RhcmZpc2guUmVzdWx0c1RhYlISc2VsZWN0ZWRSZXN1bHRzVGFiEigKEHBob25lX2NvdW50cnlfaWQYCyABKAlSDnBob25lQ291bnRyeUlkEiMKDWRpYWxsaW5nX2NvZGUYDCABKAlSDGRpYWxsaW5nQ29kZRIxCgZzdGF0dXMYDSABKA4yGS5zaWwuc3RhcmZpc2guVXNlci5TdGF0dXNSBnN0YXR1cxIdCgpjcmVhdG9yX2lkGA4gASgJUgljcmVhdG9ySWQiQQoGU3RhdHVzEhYKElNUQVRVU19VTlNQRUNJRklFRBAAEgoKBkFDVElWRRABEhMKD0FDQ09VTlRfUEVORElORxAC');
const $core.Map<$core.String, $core.dynamic> StarfishServiceBase$json = const {
  '1': 'Starfish',
  '2': const [
    const {'1': 'Authenticate', '2': '.sil.starfish.AuthenticateRequest', '3': '.sil.starfish.AuthenticateResponse', '4': const {}},
    const {'1': 'CreateMaterialFeedbacks', '2': '.sil.starfish.CreateMaterialFeedbacksRequest', '3': '.sil.starfish.CreateMaterialFeedbacksResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateActions', '2': '.sil.starfish.CreateUpdateActionsRequest', '3': '.sil.starfish.CreateUpdateActionsResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateActionUsers', '2': '.sil.starfish.CreateUpdateActionUserRequest', '3': '.sil.starfish.CreateUpdateActionUserResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateGroupEvaluations', '2': '.sil.starfish.CreateUpdateGroupEvaluationRequest', '3': '.sil.starfish.CreateUpdateGroupEvaluationResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateGroups', '2': '.sil.starfish.CreateUpdateGroupsRequest', '3': '.sil.starfish.CreateUpdateGroupsResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateGroupUsers', '2': '.sil.starfish.CreateUpdateGroupUsersRequest', '3': '.sil.starfish.CreateUpdateGroupUsersResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateLearnerEvaluations', '2': '.sil.starfish.CreateUpdateLearnerEvaluationRequest', '3': '.sil.starfish.CreateUpdateLearnerEvaluationResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateMaterials', '2': '.sil.starfish.CreateUpdateMaterialsRequest', '3': '.sil.starfish.CreateUpdateMaterialsResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateOutputs', '2': '.sil.starfish.CreateUpdateOutputRequest', '3': '.sil.starfish.CreateUpdateOutputResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateTeacherResponses', '2': '.sil.starfish.CreateUpdateTeacherResponseRequest', '3': '.sil.starfish.CreateUpdateTeacherResponseResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateTransformations', '2': '.sil.starfish.CreateUpdateTransformationRequest', '3': '.sil.starfish.CreateUpdateTransformationResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'CreateUpdateUsers', '2': '.sil.starfish.CreateUpdateUserRequest', '3': '.sil.starfish.CreateUpdateUserResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'DeleteActions', '2': '.sil.starfish.DeleteActionRequest', '3': '.sil.starfish.DeleteActionResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'DeleteGroupUsers', '2': '.sil.starfish.GroupUser', '3': '.sil.starfish.DeleteGroupUsersResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'DeleteMaterials', '2': '.sil.starfish.DeleteMaterialRequest', '3': '.sil.starfish.DeleteMaterialResponse', '4': const {}, '5': true, '6': true},
    const {'1': 'GetCurrentUser', '2': '.google.protobuf.Empty', '3': '.sil.starfish.User', '4': const {}},
    const {'1': 'ListActions', '2': '.sil.starfish.ListActionsRequest', '3': '.sil.starfish.Action', '4': const {}, '6': true},
    const {'1': 'ListAllCountries', '2': '.sil.starfish.ListAllCountriesRequest', '3': '.sil.starfish.Country', '4': const {}, '6': true},
    const {'1': 'ListEvaluationCategories', '2': '.sil.starfish.ListEvaluationCategoriesRequest', '3': '.sil.starfish.EvaluationCategory', '4': const {}, '6': true},
    const {'1': 'ListGroups', '2': '.sil.starfish.ListGroupsRequest', '3': '.sil.starfish.Group', '4': const {}, '6': true},
    const {'1': 'ListGroupEvaluations', '2': '.sil.starfish.ListGroupEvaluationsRequest', '3': '.sil.starfish.GroupEvaluation', '4': const {}, '6': true},
    const {'1': 'ListLanguages', '2': '.sil.starfish.ListLanguagesRequest', '3': '.sil.starfish.Language', '4': const {}, '6': true},
    const {'1': 'ListLearnerEvaluations', '2': '.sil.starfish.ListLearnerEvaluationsRequest', '3': '.sil.starfish.LearnerEvaluation', '4': const {}, '6': true},
    const {'1': 'ListMaterials', '2': '.sil.starfish.ListMaterialsRequest', '3': '.sil.starfish.Material', '4': const {}, '6': true},
    const {'1': 'ListMaterialTopics', '2': '.sil.starfish.ListMaterialTopicsRequest', '3': '.sil.starfish.MaterialTopic', '4': const {}, '6': true},
    const {'1': 'ListMaterialTypes', '2': '.sil.starfish.ListMaterialTypesRequest', '3': '.sil.starfish.MaterialType', '4': const {}, '6': true},
    const {'1': 'ListOutputs', '2': '.sil.starfish.ListOutputsRequest', '3': '.sil.starfish.Output', '4': const {}, '6': true},
    const {'1': 'ListTeacherResponses', '2': '.sil.starfish.ListTeacherResponsesRequest', '3': '.sil.starfish.TeacherResponse', '4': const {}, '6': true},
    const {'1': 'ListTransformations', '2': '.sil.starfish.ListTransformationsRequest', '3': '.sil.starfish.Transformation', '4': const {}, '6': true},
    const {'1': 'ListUsers', '2': '.sil.starfish.ListUsersRequest', '3': '.sil.starfish.User', '4': const {}, '6': true},
    const {'1': 'RefreshSession', '2': '.sil.starfish.RefreshSessionRequest', '3': '.sil.starfish.AuthenticateResponse', '4': const {}},
    const {'1': 'UpdateCurrentUser', '2': '.sil.starfish.UpdateCurrentUserRequest', '3': '.sil.starfish.User', '4': const {}},
  ],
};

@$core.Deprecated('Use starfishServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> StarfishServiceBase$messageJson = const {
  '.sil.starfish.AuthenticateRequest': AuthenticateRequest$json,
  '.sil.starfish.AuthenticateResponse': AuthenticateResponse$json,
  '.google.protobuf.Timestamp': $1.Timestamp$json,
  '.sil.starfish.CreateMaterialFeedbacksRequest': CreateMaterialFeedbacksRequest$json,
  '.sil.starfish.MaterialFeedback': MaterialFeedback$json,
  '.sil.starfish.CreateMaterialFeedbacksResponse': CreateMaterialFeedbacksResponse$json,
  '.sil.starfish.CreateUpdateActionsRequest': CreateUpdateActionsRequest$json,
  '.sil.starfish.Action': Action$json,
  '.google.type.Date': $0.Date$json,
  '.sil.starfish.Edit': Edit$json,
  '.google.protobuf.FieldMask': $2.FieldMask$json,
  '.sil.starfish.CreateUpdateActionsResponse': CreateUpdateActionsResponse$json,
  '.sil.starfish.CreateUpdateActionUserRequest': CreateUpdateActionUserRequest$json,
  '.sil.starfish.ActionUser': ActionUser$json,
  '.sil.starfish.CreateUpdateActionUserResponse': CreateUpdateActionUserResponse$json,
  '.sil.starfish.CreateUpdateGroupEvaluationRequest': CreateUpdateGroupEvaluationRequest$json,
  '.sil.starfish.GroupEvaluation': GroupEvaluation$json,
  '.sil.starfish.CreateUpdateGroupEvaluationResponse': CreateUpdateGroupEvaluationResponse$json,
  '.sil.starfish.CreateUpdateGroupsRequest': CreateUpdateGroupsRequest$json,
  '.sil.starfish.Group': Group$json,
  '.sil.starfish.GroupUser': GroupUser$json,
  '.sil.starfish.Group.LanguagesEntry': Group_LanguagesEntry$json,
  '.sil.starfish.OutputMarker': OutputMarker$json,
  '.sil.starfish.CreateUpdateGroupsResponse': CreateUpdateGroupsResponse$json,
  '.sil.starfish.CreateUpdateGroupUsersRequest': CreateUpdateGroupUsersRequest$json,
  '.sil.starfish.CreateUpdateGroupUsersResponse': CreateUpdateGroupUsersResponse$json,
  '.sil.starfish.CreateUpdateLearnerEvaluationRequest': CreateUpdateLearnerEvaluationRequest$json,
  '.sil.starfish.LearnerEvaluation': LearnerEvaluation$json,
  '.sil.starfish.CreateUpdateLearnerEvaluationResponse': CreateUpdateLearnerEvaluationResponse$json,
  '.sil.starfish.CreateUpdateMaterialsRequest': CreateUpdateMaterialsRequest$json,
  '.sil.starfish.Material': Material$json,
  '.sil.starfish.Material.LanguagesEntry': Material_LanguagesEntry$json,
  '.sil.starfish.CreateUpdateMaterialsResponse': CreateUpdateMaterialsResponse$json,
  '.sil.starfish.CreateUpdateOutputRequest': CreateUpdateOutputRequest$json,
  '.sil.starfish.Output': Output$json,
  '.sil.starfish.CreateUpdateOutputResponse': CreateUpdateOutputResponse$json,
  '.sil.starfish.CreateUpdateTeacherResponseRequest': CreateUpdateTeacherResponseRequest$json,
  '.sil.starfish.TeacherResponse': TeacherResponse$json,
  '.sil.starfish.CreateUpdateTeacherResponseResponse': CreateUpdateTeacherResponseResponse$json,
  '.sil.starfish.CreateUpdateTransformationRequest': CreateUpdateTransformationRequest$json,
  '.sil.starfish.Transformation': Transformation$json,
  '.sil.starfish.CreateUpdateTransformationResponse': CreateUpdateTransformationResponse$json,
  '.sil.starfish.CreateUpdateUserRequest': CreateUpdateUserRequest$json,
  '.sil.starfish.User': User$json,
  '.sil.starfish.CreateUpdateUserResponse': CreateUpdateUserResponse$json,
  '.sil.starfish.DeleteActionRequest': DeleteActionRequest$json,
  '.sil.starfish.DeleteActionResponse': DeleteActionResponse$json,
  '.sil.starfish.DeleteGroupUsersResponse': DeleteGroupUsersResponse$json,
  '.sil.starfish.DeleteMaterialRequest': DeleteMaterialRequest$json,
  '.sil.starfish.DeleteMaterialResponse': DeleteMaterialResponse$json,
  '.google.protobuf.Empty': $3.Empty$json,
  '.sil.starfish.ListActionsRequest': ListActionsRequest$json,
  '.sil.starfish.ListAllCountriesRequest': ListAllCountriesRequest$json,
  '.sil.starfish.Country': Country$json,
  '.sil.starfish.ListEvaluationCategoriesRequest': ListEvaluationCategoriesRequest$json,
  '.sil.starfish.EvaluationCategory': EvaluationCategory$json,
  '.sil.starfish.EvaluationValueName': EvaluationValueName$json,
  '.sil.starfish.ListGroupsRequest': ListGroupsRequest$json,
  '.sil.starfish.ListGroupEvaluationsRequest': ListGroupEvaluationsRequest$json,
  '.sil.starfish.ListLanguagesRequest': ListLanguagesRequest$json,
  '.sil.starfish.Language': Language$json,
  '.sil.starfish.ListLearnerEvaluationsRequest': ListLearnerEvaluationsRequest$json,
  '.sil.starfish.ListMaterialsRequest': ListMaterialsRequest$json,
  '.sil.starfish.ListMaterialTopicsRequest': ListMaterialTopicsRequest$json,
  '.sil.starfish.MaterialTopic': MaterialTopic$json,
  '.sil.starfish.ListMaterialTypesRequest': ListMaterialTypesRequest$json,
  '.sil.starfish.MaterialType': MaterialType$json,
  '.sil.starfish.ListOutputsRequest': ListOutputsRequest$json,
  '.sil.starfish.ListTeacherResponsesRequest': ListTeacherResponsesRequest$json,
  '.sil.starfish.ListTransformationsRequest': ListTransformationsRequest$json,
  '.sil.starfish.ListUsersRequest': ListUsersRequest$json,
  '.sil.starfish.RefreshSessionRequest': RefreshSessionRequest$json,
  '.sil.starfish.UpdateCurrentUserRequest': UpdateCurrentUserRequest$json,
};

/// Descriptor for `Starfish`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List starfishServiceDescriptor = $convert.base64Decode('CghTdGFyZmlzaBJXCgxBdXRoZW50aWNhdGUSIS5zaWwuc3RhcmZpc2guQXV0aGVudGljYXRlUmVxdWVzdBoiLnNpbC5zdGFyZmlzaC5BdXRoZW50aWNhdGVSZXNwb25zZSIAEnwKF0NyZWF0ZU1hdGVyaWFsRmVlZGJhY2tzEiwuc2lsLnN0YXJmaXNoLkNyZWF0ZU1hdGVyaWFsRmVlZGJhY2tzUmVxdWVzdBotLnNpbC5zdGFyZmlzaC5DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1Jlc3BvbnNlIgAoATABEnAKE0NyZWF0ZVVwZGF0ZUFjdGlvbnMSKC5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlQWN0aW9uc1JlcXVlc3QaKS5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlQWN0aW9uc1Jlc3BvbnNlIgAoATABEnoKF0NyZWF0ZVVwZGF0ZUFjdGlvblVzZXJzEisuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUFjdGlvblVzZXJSZXF1ZXN0Giwuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUFjdGlvblVzZXJSZXNwb25zZSIAKAEwARKJAQocQ3JlYXRlVXBkYXRlR3JvdXBFdmFsdWF0aW9ucxIwLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXF1ZXN0GjEuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUdyb3VwRXZhbHVhdGlvblJlc3BvbnNlIgAoATABEm0KEkNyZWF0ZVVwZGF0ZUdyb3VwcxInLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVHcm91cHNSZXF1ZXN0Giguc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUdyb3Vwc1Jlc3BvbnNlIgAoATABEnkKFkNyZWF0ZVVwZGF0ZUdyb3VwVXNlcnMSKy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlR3JvdXBVc2Vyc1JlcXVlc3QaLC5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlR3JvdXBVc2Vyc1Jlc3BvbnNlIgAoATABEo8BCh5DcmVhdGVVcGRhdGVMZWFybmVyRXZhbHVhdGlvbnMSMi5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlTGVhcm5lckV2YWx1YXRpb25SZXF1ZXN0GjMuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUxlYXJuZXJFdmFsdWF0aW9uUmVzcG9uc2UiACgBMAESdgoVQ3JlYXRlVXBkYXRlTWF0ZXJpYWxzEiouc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZU1hdGVyaWFsc1JlcXVlc3QaKy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlTWF0ZXJpYWxzUmVzcG9uc2UiACgBMAESbgoTQ3JlYXRlVXBkYXRlT3V0cHV0cxInLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVPdXRwdXRSZXF1ZXN0Giguc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZU91dHB1dFJlc3BvbnNlIgAoATABEokBChxDcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VzEjAuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZVRlYWNoZXJSZXNwb25zZVJlcXVlc3QaMS5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlVGVhY2hlclJlc3BvbnNlUmVzcG9uc2UiACgBMAEShgEKG0NyZWF0ZVVwZGF0ZVRyYW5zZm9ybWF0aW9ucxIvLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVUcmFuc2Zvcm1hdGlvblJlcXVlc3QaMC5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlVHJhbnNmb3JtYXRpb25SZXNwb25zZSIAKAEwARJoChFDcmVhdGVVcGRhdGVVc2VycxIlLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVVc2VyUmVxdWVzdBomLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVVc2VyUmVzcG9uc2UiACgBMAESXAoNRGVsZXRlQWN0aW9ucxIhLnNpbC5zdGFyZmlzaC5EZWxldGVBY3Rpb25SZXF1ZXN0GiIuc2lsLnN0YXJmaXNoLkRlbGV0ZUFjdGlvblJlc3BvbnNlIgAoATABElkKEERlbGV0ZUdyb3VwVXNlcnMSFy5zaWwuc3RhcmZpc2guR3JvdXBVc2VyGiYuc2lsLnN0YXJmaXNoLkRlbGV0ZUdyb3VwVXNlcnNSZXNwb25zZSIAKAEwARJiCg9EZWxldGVNYXRlcmlhbHMSIy5zaWwuc3RhcmZpc2guRGVsZXRlTWF0ZXJpYWxSZXF1ZXN0GiQuc2lsLnN0YXJmaXNoLkRlbGV0ZU1hdGVyaWFsUmVzcG9uc2UiACgBMAESPgoOR2V0Q3VycmVudFVzZXISFi5nb29nbGUucHJvdG9idWYuRW1wdHkaEi5zaWwuc3RhcmZpc2guVXNlciIAEkkKC0xpc3RBY3Rpb25zEiAuc2lsLnN0YXJmaXNoLkxpc3RBY3Rpb25zUmVxdWVzdBoULnNpbC5zdGFyZmlzaC5BY3Rpb24iADABElQKEExpc3RBbGxDb3VudHJpZXMSJS5zaWwuc3RhcmZpc2guTGlzdEFsbENvdW50cmllc1JlcXVlc3QaFS5zaWwuc3RhcmZpc2guQ291bnRyeSIAMAESbwoYTGlzdEV2YWx1YXRpb25DYXRlZ29yaWVzEi0uc2lsLnN0YXJmaXNoLkxpc3RFdmFsdWF0aW9uQ2F0ZWdvcmllc1JlcXVlc3QaIC5zaWwuc3RhcmZpc2guRXZhbHVhdGlvbkNhdGVnb3J5IgAwARJGCgpMaXN0R3JvdXBzEh8uc2lsLnN0YXJmaXNoLkxpc3RHcm91cHNSZXF1ZXN0GhMuc2lsLnN0YXJmaXNoLkdyb3VwIgAwARJkChRMaXN0R3JvdXBFdmFsdWF0aW9ucxIpLnNpbC5zdGFyZmlzaC5MaXN0R3JvdXBFdmFsdWF0aW9uc1JlcXVlc3QaHS5zaWwuc3RhcmZpc2guR3JvdXBFdmFsdWF0aW9uIgAwARJPCg1MaXN0TGFuZ3VhZ2VzEiIuc2lsLnN0YXJmaXNoLkxpc3RMYW5ndWFnZXNSZXF1ZXN0GhYuc2lsLnN0YXJmaXNoLkxhbmd1YWdlIgAwARJqChZMaXN0TGVhcm5lckV2YWx1YXRpb25zEisuc2lsLnN0YXJmaXNoLkxpc3RMZWFybmVyRXZhbHVhdGlvbnNSZXF1ZXN0Gh8uc2lsLnN0YXJmaXNoLkxlYXJuZXJFdmFsdWF0aW9uIgAwARJPCg1MaXN0TWF0ZXJpYWxzEiIuc2lsLnN0YXJmaXNoLkxpc3RNYXRlcmlhbHNSZXF1ZXN0GhYuc2lsLnN0YXJmaXNoLk1hdGVyaWFsIgAwARJeChJMaXN0TWF0ZXJpYWxUb3BpY3MSJy5zaWwuc3RhcmZpc2guTGlzdE1hdGVyaWFsVG9waWNzUmVxdWVzdBobLnNpbC5zdGFyZmlzaC5NYXRlcmlhbFRvcGljIgAwARJbChFMaXN0TWF0ZXJpYWxUeXBlcxImLnNpbC5zdGFyZmlzaC5MaXN0TWF0ZXJpYWxUeXBlc1JlcXVlc3QaGi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxUeXBlIgAwARJJCgtMaXN0T3V0cHV0cxIgLnNpbC5zdGFyZmlzaC5MaXN0T3V0cHV0c1JlcXVlc3QaFC5zaWwuc3RhcmZpc2guT3V0cHV0IgAwARJkChRMaXN0VGVhY2hlclJlc3BvbnNlcxIpLnNpbC5zdGFyZmlzaC5MaXN0VGVhY2hlclJlc3BvbnNlc1JlcXVlc3QaHS5zaWwuc3RhcmZpc2guVGVhY2hlclJlc3BvbnNlIgAwARJhChNMaXN0VHJhbnNmb3JtYXRpb25zEiguc2lsLnN0YXJmaXNoLkxpc3RUcmFuc2Zvcm1hdGlvbnNSZXF1ZXN0Ghwuc2lsLnN0YXJmaXNoLlRyYW5zZm9ybWF0aW9uIgAwARJDCglMaXN0VXNlcnMSHi5zaWwuc3RhcmZpc2guTGlzdFVzZXJzUmVxdWVzdBoSLnNpbC5zdGFyZmlzaC5Vc2VyIgAwARJbCg5SZWZyZXNoU2Vzc2lvbhIjLnNpbC5zdGFyZmlzaC5SZWZyZXNoU2Vzc2lvblJlcXVlc3QaIi5zaWwuc3RhcmZpc2guQXV0aGVudGljYXRlUmVzcG9uc2UiABJRChFVcGRhdGVDdXJyZW50VXNlchImLnNpbC5zdGFyZmlzaC5VcGRhdGVDdXJyZW50VXNlclJlcXVlc3QaEi5zaWwuc3RhcmZpc2guVXNlciIA');
