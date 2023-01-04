///
//  Generated code. Do not modify.
//  source: starfish.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

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
final $typed_data.Uint8List actionTabDescriptor = $convert.base64Decode(
    'CglBY3Rpb25UYWISFwoTQUNUSU9OU19VTlNQRUNJRklFRBAAEhAKDEFDVElPTlNfTUlORRABEhUKEUFDVElPTlNfTVlfR1JPVVBTEAI=');
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
final $typed_data.Uint8List resultsTabDescriptor = $convert.base64Decode(
    'CgpSZXN1bHRzVGFiEhcKE1JFU1VMVFNfVU5TUEVDSUZJRUQQABIQCgxSRVNVTFRTX01JTkUQARIVChFSRVNVTFRTX01ZX0dST1VQUxAC');
@$core.Deprecated('Use resourceTypeDescriptor instead')
const ResourceType$json = const {
  '1': 'ResourceType',
  '2': const [
    const {'1': 'TYPE_UNSPECIFIED', '2': 0},
    const {'1': 'ACTION_RESOURCE', '2': 1},
    const {'1': 'ACTION_USER_RESOURCE', '2': 2},
    const {'1': 'COUNTRY_RESOURCE', '2': 3},
    const {'1': 'EVALUATION_CATEGORY_RESOURCE', '2': 4},
    const {'1': 'EVALUATION_VALUE_NAME_RESOURCE', '2': 5},
    const {'1': 'GROUP_RESOURCE', '2': 6},
    const {'1': 'GROUP_EVALUATION_RESOURCE', '2': 7},
    const {'1': 'GROUP_USER_RESOURCE', '2': 8},
    const {'1': 'LANGUAGE_RESOURCE', '2': 9},
    const {'1': 'LEARNER_EVALUATION_RESOURCE', '2': 10},
    const {'1': 'MATERIAL_RESOURCE', '2': 11},
    const {'1': 'MATERIAL_FEEDBACK_RESOURCE', '2': 12},
    const {'1': 'MATERIAL_TOPIC_RESOURCE', '2': 13},
    const {'1': 'MATERIAL_TYPE_RESOURCE', '2': 14},
    const {'1': 'OUTPUT_RESOURCE', '2': 15},
    const {'1': 'OUTPUT_MARKER_RESOURCE', '2': 16},
    const {'1': 'TEACHER_RESPONSE_RESOURCE', '2': 17},
    const {'1': 'TRANSFORMATION_RESOURCE', '2': 18},
    const {'1': 'USER_RESOURCE', '2': 19},
  ],
};

/// Descriptor for `ResourceType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List resourceTypeDescriptor = $convert.base64Decode(
    'CgxSZXNvdXJjZVR5cGUSFAoQVFlQRV9VTlNQRUNJRklFRBAAEhMKD0FDVElPTl9SRVNPVVJDRRABEhgKFEFDVElPTl9VU0VSX1JFU09VUkNFEAISFAoQQ09VTlRSWV9SRVNPVVJDRRADEiAKHEVWQUxVQVRJT05fQ0FURUdPUllfUkVTT1VSQ0UQBBIiCh5FVkFMVUFUSU9OX1ZBTFVFX05BTUVfUkVTT1VSQ0UQBRISCg5HUk9VUF9SRVNPVVJDRRAGEh0KGUdST1VQX0VWQUxVQVRJT05fUkVTT1VSQ0UQBxIXChNHUk9VUF9VU0VSX1JFU09VUkNFEAgSFQoRTEFOR1VBR0VfUkVTT1VSQ0UQCRIfChtMRUFSTkVSX0VWQUxVQVRJT05fUkVTT1VSQ0UQChIVChFNQVRFUklBTF9SRVNPVVJDRRALEh4KGk1BVEVSSUFMX0ZFRURCQUNLX1JFU09VUkNFEAwSGwoXTUFURVJJQUxfVE9QSUNfUkVTT1VSQ0UQDRIaChZNQVRFUklBTF9UWVBFX1JFU09VUkNFEA4SEwoPT1VUUFVUX1JFU09VUkNFEA8SGgoWT1VUUFVUX01BUktFUl9SRVNPVVJDRRAQEh0KGVRFQUNIRVJfUkVTUE9OU0VfUkVTT1VSQ0UQERIbChdUUkFOU0ZPUk1BVElPTl9SRVNPVVJDRRASEhEKDVVTRVJfUkVTT1VSQ0UQEw==');
@$core.Deprecated('Use actionDescriptor instead')
const Action$json = const {
  '1': 'Action',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.Action.Type',
      '10': 'type'
    },
    const {'1': 'name', '3': 3, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'creator_id', '3': 4, '4': 1, '5': 9, '10': 'creatorId'},
    const {'1': 'group_id', '3': 5, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'instructions', '3': 6, '4': 1, '5': 9, '10': 'instructions'},
    const {'1': 'material_id', '3': 7, '4': 1, '5': 9, '10': 'materialId'},
    const {'1': 'question', '3': 8, '4': 1, '5': 9, '10': 'question'},
    const {
      '1': 'date_due',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'dateDue'
    },
    const {
      '1': 'edit_history',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.Edit',
      '10': 'editHistory'
    },
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
final $typed_data.Uint8List actionDescriptor = $convert.base64Decode(
    'CgZBY3Rpb24SDgoCaWQYASABKAlSAmlkEi0KBHR5cGUYAiABKA4yGS5zaWwuc3RhcmZpc2guQWN0aW9uLlR5cGVSBHR5cGUSEgoEbmFtZRgDIAEoCVIEbmFtZRIdCgpjcmVhdG9yX2lkGAQgASgJUgljcmVhdG9ySWQSGQoIZ3JvdXBfaWQYBSABKAlSB2dyb3VwSWQSIgoMaW5zdHJ1Y3Rpb25zGAYgASgJUgxpbnN0cnVjdGlvbnMSHwoLbWF0ZXJpYWxfaWQYByABKAlSCm1hdGVyaWFsSWQSGgoIcXVlc3Rpb24YCCABKAlSCHF1ZXN0aW9uEiwKCGRhdGVfZHVlGAkgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIHZGF0ZUR1ZRI1CgxlZGl0X2hpc3RvcnkYCiADKAsyEi5zaWwuc3RhcmZpc2guRWRpdFILZWRpdEhpc3RvcnkiYAoEVHlwZRIUChBURVhUX0lOU1RSVUNUSU9OEAASEQoNVEVYVF9SRVNQT05TRRABEhgKFE1BVEVSSUFMX0lOU1RSVUNUSU9OEAISFQoRTUFURVJJQUxfUkVTUE9OU0UQAw==');
@$core.Deprecated('Use actionUserDescriptor instead')
const ActionUser$json = const {
  '1': 'ActionUser',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'action_id', '3': 2, '4': 1, '5': 9, '10': 'actionId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.ActionUser.Status',
      '10': 'status'
    },
    const {
      '1': 'teacher_response',
      '3': 5,
      '4': 1,
      '5': 9,
      '10': 'teacherResponse'
    },
    const {'1': 'user_response', '3': 7, '4': 1, '5': 9, '10': 'userResponse'},
    const {
      '1': 'evaluation',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.ActionUser.Evaluation',
      '10': 'evaluation'
    },
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
final $typed_data.Uint8List actionUserDescriptor = $convert.base64Decode(
    'CgpBY3Rpb25Vc2VyEg4KAmlkGAEgASgJUgJpZBIbCglhY3Rpb25faWQYAiABKAlSCGFjdGlvbklkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBI3CgZzdGF0dXMYBCABKA4yHy5zaWwuc3RhcmZpc2guQWN0aW9uVXNlci5TdGF0dXNSBnN0YXR1cxIpChB0ZWFjaGVyX3Jlc3BvbnNlGAUgASgJUg90ZWFjaGVyUmVzcG9uc2USIwoNdXNlcl9yZXNwb25zZRgHIAEoCVIMdXNlclJlc3BvbnNlEkMKCmV2YWx1YXRpb24YCCABKA4yIy5zaWwuc3RhcmZpc2guQWN0aW9uVXNlci5FdmFsdWF0aW9uUgpldmFsdWF0aW9uIj4KBlN0YXR1cxIWChJVTlNQRUNJRklFRF9TVEFUVVMQABIOCgpJTkNPTVBMRVRFEAESDAoIQ09NUExFVEUQAiI7CgpFdmFsdWF0aW9uEhoKFlVOU1BFQ0lGSUVEX0VWQUxVQVRJT04QABIICgRHT09EEAESBwoDQkFEEAI=');
@$core.Deprecated('Use authenticateRequestDescriptor instead')
const AuthenticateRequest$json = const {
  '1': 'AuthenticateRequest',
  '2': const [
    const {'1': 'firebase_jwt', '3': 1, '4': 1, '5': 9, '10': 'firebaseJwt'},
    const {'1': 'user_name', '3': 2, '4': 1, '5': 9, '10': 'userName'},
  ],
};

/// Descriptor for `AuthenticateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticateRequestDescriptor = $convert.base64Decode(
    'ChNBdXRoZW50aWNhdGVSZXF1ZXN0EiEKDGZpcmViYXNlX2p3dBgBIAEoCVILZmlyZWJhc2VKd3QSGwoJdXNlcl9uYW1lGAIgASgJUgh1c2VyTmFtZQ==');
@$core.Deprecated('Use authenticateResponseDescriptor instead')
const AuthenticateResponse$json = const {
  '1': 'AuthenticateResponse',
  '2': const [
    const {'1': 'user_token', '3': 1, '4': 1, '5': 9, '10': 'userToken'},
    const {
      '1': 'expires_at',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'expiresAt'
    },
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'refresh_token', '3': 4, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `AuthenticateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticateResponseDescriptor = $convert.base64Decode(
    'ChRBdXRoZW50aWNhdGVSZXNwb25zZRIdCgp1c2VyX3Rva2VuGAEgASgJUgl1c2VyVG9rZW4SOQoKZXhwaXJlc19hdBgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCWV4cGlyZXNBdBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSIwoNcmVmcmVzaF90b2tlbhgEIAEoCVIMcmVmcmVzaFRva2Vu');
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
final $typed_data.Uint8List countryDescriptor = $convert.base64Decode(
    'CgdDb3VudHJ5Eg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEiMKDWRpYWxsaW5nX2NvZGUYAyABKAlSDGRpYWxsaW5nQ29kZQ==');
@$core.Deprecated('Use createMaterialFeedbacksRequestDescriptor instead')
const CreateMaterialFeedbacksRequest$json = const {
  '1': 'CreateMaterialFeedbacksRequest',
  '2': const [
    const {
      '1': 'feedback',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.MaterialFeedback',
      '10': 'feedback'
    },
  ],
};

/// Descriptor for `CreateMaterialFeedbacksRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createMaterialFeedbacksRequestDescriptor =
    $convert.base64Decode(
        'Ch5DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1JlcXVlc3QSOgoIZmVlZGJhY2sYASABKAsyHi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxGZWVkYmFja1IIZmVlZGJhY2s=');
@$core.Deprecated('Use createMaterialFeedbacksResponseDescriptor instead')
const CreateMaterialFeedbacksResponse$json = const {
  '1': 'CreateMaterialFeedbacksResponse',
  '2': const [
    const {
      '1': 'feedback',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.MaterialFeedback',
      '10': 'feedback'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateMaterialFeedbacksResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createMaterialFeedbacksResponseDescriptor =
    $convert.base64Decode(
        'Ch9DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1Jlc3BvbnNlEjoKCGZlZWRiYWNrGAEgASgLMh4uc2lsLnN0YXJmaXNoLk1hdGVyaWFsRmVlZGJhY2tSCGZlZWRiYWNrEkwKBnN0YXR1cxgCIAEoDjI0LnNpbC5zdGFyZmlzaC5DcmVhdGVNYXRlcmlhbEZlZWRiYWNrc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateActionsRequestDescriptor instead')
const CreateUpdateActionsRequest$json = const {
  '1': 'CreateUpdateActionsRequest',
  '2': const [
    const {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Action',
      '10': 'action'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateActionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateActionsRequestDescriptor =
    $convert.base64Decode(
        'ChpDcmVhdGVVcGRhdGVBY3Rpb25zUmVxdWVzdBIsCgZhY3Rpb24YASABKAsyFC5zaWwuc3RhcmZpc2guQWN0aW9uUgZhY3Rpb24SOwoLdXBkYXRlX21hc2sYAiABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');
@$core.Deprecated('Use createUpdateActionsResponseDescriptor instead')
const CreateUpdateActionsResponse$json = const {
  '1': 'CreateUpdateActionsResponse',
  '2': const [
    const {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Action',
      '10': 'action'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateActionsResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateActionsResponseDescriptor =
    $convert.base64Decode(
        'ChtDcmVhdGVVcGRhdGVBY3Rpb25zUmVzcG9uc2USLAoGYWN0aW9uGAEgASgLMhQuc2lsLnN0YXJmaXNoLkFjdGlvblIGYWN0aW9uEkgKBnN0YXR1cxgCIAEoDjIwLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVBY3Rpb25zUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use createUpdateActionUserRequestDescriptor instead')
const CreateUpdateActionUserRequest$json = const {
  '1': 'CreateUpdateActionUserRequest',
  '2': const [
    const {
      '1': 'action_user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.ActionUser',
      '10': 'actionUser'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateActionUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateActionUserRequestDescriptor =
    $convert.base64Decode(
        'Ch1DcmVhdGVVcGRhdGVBY3Rpb25Vc2VyUmVxdWVzdBI5CgthY3Rpb25fdXNlchgBIAEoCzIYLnNpbC5zdGFyZmlzaC5BY3Rpb25Vc2VyUgphY3Rpb25Vc2VyEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use createUpdateActionUserResponseDescriptor instead')
const CreateUpdateActionUserResponse$json = const {
  '1': 'CreateUpdateActionUserResponse',
  '2': const [
    const {
      '1': 'action_user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.ActionUser',
      '10': 'actionUser'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateActionUserResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateActionUserResponseDescriptor =
    $convert.base64Decode(
        'Ch5DcmVhdGVVcGRhdGVBY3Rpb25Vc2VyUmVzcG9uc2USOQoLYWN0aW9uX3VzZXIYASABKAsyGC5zaWwuc3RhcmZpc2guQWN0aW9uVXNlclIKYWN0aW9uVXNlchJLCgZzdGF0dXMYAiABKA4yMy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlQWN0aW9uVXNlclJlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateGroupEvaluationRequestDescriptor instead')
const CreateUpdateGroupEvaluationRequest$json = const {
  '1': 'CreateUpdateGroupEvaluationRequest',
  '2': const [
    const {
      '1': 'group_evaluation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.GroupEvaluation',
      '10': 'groupEvaluation'
    },
  ],
};

/// Descriptor for `CreateUpdateGroupEvaluationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupEvaluationRequestDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXF1ZXN0EkgKEGdyb3VwX2V2YWx1YXRpb24YASABKAsyHS5zaWwuc3RhcmZpc2guR3JvdXBFdmFsdWF0aW9uUg9ncm91cEV2YWx1YXRpb24=');
@$core.Deprecated('Use createUpdateGroupEvaluationResponseDescriptor instead')
const CreateUpdateGroupEvaluationResponse$json = const {
  '1': 'CreateUpdateGroupEvaluationResponse',
  '2': const [
    const {
      '1': 'group_evaluation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.GroupEvaluation',
      '10': 'groupEvaluation'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateGroupEvaluationResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateGroupEvaluationResponseDescriptor =
    $convert.base64Decode(
        'CiNDcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXNwb25zZRJIChBncm91cF9ldmFsdWF0aW9uGAEgASgLMh0uc2lsLnN0YXJmaXNoLkdyb3VwRXZhbHVhdGlvblIPZ3JvdXBFdmFsdWF0aW9uElAKBnN0YXR1cxgCIAEoDjI4LnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb25SZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use createUpdateGroupsRequestDescriptor instead')
const CreateUpdateGroupsRequest$json = const {
  '1': 'CreateUpdateGroupsRequest',
  '2': const [
    const {
      '1': 'group',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Group',
      '10': 'group'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupsRequestDescriptor =
    $convert.base64Decode(
        'ChlDcmVhdGVVcGRhdGVHcm91cHNSZXF1ZXN0EikKBWdyb3VwGAEgASgLMhMuc2lsLnN0YXJmaXNoLkdyb3VwUgVncm91cBI7Cgt1cGRhdGVfbWFzaxgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tSCnVwZGF0ZU1hc2s=');
@$core.Deprecated('Use createUpdateGroupsResponseDescriptor instead')
const CreateUpdateGroupsResponse$json = const {
  '1': 'CreateUpdateGroupsResponse',
  '2': const [
    const {
      '1': 'group',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Group',
      '10': 'group'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateGroupsResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateGroupsResponseDescriptor =
    $convert.base64Decode(
        'ChpDcmVhdGVVcGRhdGVHcm91cHNSZXNwb25zZRIpCgVncm91cBgBIAEoCzITLnNpbC5zdGFyZmlzaC5Hcm91cFIFZ3JvdXASRwoGc3RhdHVzGAIgASgOMi8uc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUdyb3Vwc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateGroupUsersRequestDescriptor instead')
const CreateUpdateGroupUsersRequest$json = const {
  '1': 'CreateUpdateGroupUsersRequest',
  '2': const [
    const {
      '1': 'group_user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.GroupUser',
      '10': 'groupUser'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateGroupUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateGroupUsersRequestDescriptor =
    $convert.base64Decode(
        'Ch1DcmVhdGVVcGRhdGVHcm91cFVzZXJzUmVxdWVzdBI2Cgpncm91cF91c2VyGAEgASgLMhcuc2lsLnN0YXJmaXNoLkdyb3VwVXNlclIJZ3JvdXBVc2VyEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use createUpdateGroupUsersResponseDescriptor instead')
const CreateUpdateGroupUsersResponse$json = const {
  '1': 'CreateUpdateGroupUsersResponse',
  '2': const [
    const {
      '1': 'group_user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.GroupUser',
      '10': 'groupUser'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateGroupUsersResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateGroupUsersResponseDescriptor =
    $convert.base64Decode(
        'Ch5DcmVhdGVVcGRhdGVHcm91cFVzZXJzUmVzcG9uc2USNgoKZ3JvdXBfdXNlchgBIAEoCzIXLnNpbC5zdGFyZmlzaC5Hcm91cFVzZXJSCWdyb3VwVXNlchJLCgZzdGF0dXMYAiABKA4yMy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlR3JvdXBVc2Vyc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateLearnerEvaluationRequestDescriptor instead')
const CreateUpdateLearnerEvaluationRequest$json = const {
  '1': 'CreateUpdateLearnerEvaluationRequest',
  '2': const [
    const {
      '1': 'learner_evaluation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.LearnerEvaluation',
      '10': 'learnerEvaluation'
    },
  ],
};

/// Descriptor for `CreateUpdateLearnerEvaluationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateLearnerEvaluationRequestDescriptor =
    $convert.base64Decode(
        'CiRDcmVhdGVVcGRhdGVMZWFybmVyRXZhbHVhdGlvblJlcXVlc3QSTgoSbGVhcm5lcl9ldmFsdWF0aW9uGAEgASgLMh8uc2lsLnN0YXJmaXNoLkxlYXJuZXJFdmFsdWF0aW9uUhFsZWFybmVyRXZhbHVhdGlvbg==');
@$core.Deprecated('Use createUpdateLearnerEvaluationResponseDescriptor instead')
const CreateUpdateLearnerEvaluationResponse$json = const {
  '1': 'CreateUpdateLearnerEvaluationResponse',
  '2': const [
    const {
      '1': 'learner_evaluation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.LearnerEvaluation',
      '10': 'learnerEvaluation'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateLearnerEvaluationResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateLearnerEvaluationResponseDescriptor =
    $convert.base64Decode(
        'CiVDcmVhdGVVcGRhdGVMZWFybmVyRXZhbHVhdGlvblJlc3BvbnNlEk4KEmxlYXJuZXJfZXZhbHVhdGlvbhgBIAEoCzIfLnNpbC5zdGFyZmlzaC5MZWFybmVyRXZhbHVhdGlvblIRbGVhcm5lckV2YWx1YXRpb24SUgoGc3RhdHVzGAIgASgOMjouc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZUxlYXJuZXJFdmFsdWF0aW9uUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use createUpdateMaterialsRequestDescriptor instead')
const CreateUpdateMaterialsRequest$json = const {
  '1': 'CreateUpdateMaterialsRequest',
  '2': const [
    const {
      '1': 'material',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Material',
      '10': 'material'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateMaterialsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateMaterialsRequestDescriptor =
    $convert.base64Decode(
        'ChxDcmVhdGVVcGRhdGVNYXRlcmlhbHNSZXF1ZXN0EjIKCG1hdGVyaWFsGAEgASgLMhYuc2lsLnN0YXJmaXNoLk1hdGVyaWFsUghtYXRlcmlhbBI7Cgt1cGRhdGVfbWFzaxgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tSCnVwZGF0ZU1hc2s=');
@$core.Deprecated('Use createUpdateMaterialsResponseDescriptor instead')
const CreateUpdateMaterialsResponse$json = const {
  '1': 'CreateUpdateMaterialsResponse',
  '2': const [
    const {
      '1': 'material',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Material',
      '10': 'material'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateMaterialsResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateMaterialsResponseDescriptor =
    $convert.base64Decode(
        'Ch1DcmVhdGVVcGRhdGVNYXRlcmlhbHNSZXNwb25zZRIyCghtYXRlcmlhbBgBIAEoCzIWLnNpbC5zdGFyZmlzaC5NYXRlcmlhbFIIbWF0ZXJpYWwSSgoGc3RhdHVzGAIgASgOMjIuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZU1hdGVyaWFsc1Jlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateOutputRequestDescriptor instead')
const CreateUpdateOutputRequest$json = const {
  '1': 'CreateUpdateOutputRequest',
  '2': const [
    const {
      '1': 'output',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Output',
      '10': 'output'
    },
  ],
};

/// Descriptor for `CreateUpdateOutputRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateOutputRequestDescriptor =
    $convert.base64Decode(
        'ChlDcmVhdGVVcGRhdGVPdXRwdXRSZXF1ZXN0EiwKBm91dHB1dBgBIAEoCzIULnNpbC5zdGFyZmlzaC5PdXRwdXRSBm91dHB1dA==');
@$core.Deprecated('Use createUpdateOutputResponseDescriptor instead')
const CreateUpdateOutputResponse$json = const {
  '1': 'CreateUpdateOutputResponse',
  '2': const [
    const {
      '1': 'output',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Output',
      '10': 'output'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateOutputResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateOutputResponseDescriptor =
    $convert.base64Decode(
        'ChpDcmVhdGVVcGRhdGVPdXRwdXRSZXNwb25zZRIsCgZvdXRwdXQYASABKAsyFC5zaWwuc3RhcmZpc2guT3V0cHV0UgZvdXRwdXQSRwoGc3RhdHVzGAIgASgOMi8uc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZU91dHB1dFJlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use createUpdateTeacherResponseRequestDescriptor instead')
const CreateUpdateTeacherResponseRequest$json = const {
  '1': 'CreateUpdateTeacherResponseRequest',
  '2': const [
    const {
      '1': 'teacher_response',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.TeacherResponse',
      '10': 'teacherResponse'
    },
  ],
};

/// Descriptor for `CreateUpdateTeacherResponseRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateTeacherResponseRequestDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VSZXF1ZXN0EkgKEHRlYWNoZXJfcmVzcG9uc2UYASABKAsyHS5zaWwuc3RhcmZpc2guVGVhY2hlclJlc3BvbnNlUg90ZWFjaGVyUmVzcG9uc2U=');
@$core.Deprecated('Use createUpdateTeacherResponseResponseDescriptor instead')
const CreateUpdateTeacherResponseResponse$json = const {
  '1': 'CreateUpdateTeacherResponseResponse',
  '2': const [
    const {
      '1': 'teacher_response',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.TeacherResponse',
      '10': 'teacherResponse'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateTeacherResponseResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateTeacherResponseResponseDescriptor =
    $convert.base64Decode(
        'CiNDcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VSZXNwb25zZRJIChB0ZWFjaGVyX3Jlc3BvbnNlGAEgASgLMh0uc2lsLnN0YXJmaXNoLlRlYWNoZXJSZXNwb25zZVIPdGVhY2hlclJlc3BvbnNlElAKBnN0YXR1cxgCIAEoDjI4LnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2VSZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use createUpdateTransformationRequestDescriptor instead')
const CreateUpdateTransformationRequest$json = const {
  '1': 'CreateUpdateTransformationRequest',
  '2': const [
    const {
      '1': 'transformation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Transformation',
      '10': 'transformation'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateTransformationRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateTransformationRequestDescriptor =
    $convert.base64Decode(
        'CiFDcmVhdGVVcGRhdGVUcmFuc2Zvcm1hdGlvblJlcXVlc3QSRAoOdHJhbnNmb3JtYXRpb24YASABKAsyHC5zaWwuc3RhcmZpc2guVHJhbnNmb3JtYXRpb25SDnRyYW5zZm9ybWF0aW9uEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
@$core.Deprecated('Use createUpdateTransformationResponseDescriptor instead')
const CreateUpdateTransformationResponse$json = const {
  '1': 'CreateUpdateTransformationResponse',
  '2': const [
    const {
      '1': 'transformation',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Transformation',
      '10': 'transformation'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateTransformationResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateTransformationResponseDescriptor =
    $convert.base64Decode(
        'CiJDcmVhdGVVcGRhdGVUcmFuc2Zvcm1hdGlvblJlc3BvbnNlEkQKDnRyYW5zZm9ybWF0aW9uGAEgASgLMhwuc2lsLnN0YXJmaXNoLlRyYW5zZm9ybWF0aW9uUg50cmFuc2Zvcm1hdGlvbhJPCgZzdGF0dXMYAiABKA4yNy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlVHJhbnNmb3JtYXRpb25SZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use createUpdateUserRequestDescriptor instead')
const CreateUpdateUserRequest$json = const {
  '1': 'CreateUpdateUserRequest',
  '2': const [
    const {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.User',
      '10': 'user'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `CreateUpdateUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUpdateUserRequestDescriptor =
    $convert.base64Decode(
        'ChdDcmVhdGVVcGRhdGVVc2VyUmVxdWVzdBImCgR1c2VyGAEgASgLMhIuc2lsLnN0YXJmaXNoLlVzZXJSBHVzZXISOwoLdXBkYXRlX21hc2sYAiABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrUgp1cGRhdGVNYXNr');
@$core.Deprecated('Use createUpdateUserResponseDescriptor instead')
const CreateUpdateUserResponse$json = const {
  '1': 'CreateUpdateUserResponse',
  '2': const [
    const {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.User',
      '10': 'user'
    },
    const {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.CreateUpdateUserResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List createUpdateUserResponseDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVVcGRhdGVVc2VyUmVzcG9uc2USJgoEdXNlchgBIAEoCzISLnNpbC5zdGFyZmlzaC5Vc2VyUgR1c2VyEkUKBnN0YXR1cxgCIAEoDjItLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVVc2VyUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgDIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use deleteActionRequestDescriptor instead')
const DeleteActionRequest$json = const {
  '1': 'DeleteActionRequest',
  '2': const [
    const {'1': 'action_id', '3': 1, '4': 1, '5': 9, '10': 'actionId'},
  ],
};

/// Descriptor for `DeleteActionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteActionRequestDescriptor =
    $convert.base64Decode(
        'ChNEZWxldGVBY3Rpb25SZXF1ZXN0EhsKCWFjdGlvbl9pZBgBIAEoCVIIYWN0aW9uSWQ=');
@$core.Deprecated('Use deleteActionResponseDescriptor instead')
const DeleteActionResponse$json = const {
  '1': 'DeleteActionResponse',
  '2': const [
    const {'1': 'action_id', '3': 1, '4': 1, '5': 9, '10': 'actionId'},
    const {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.DeleteActionResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List deleteActionResponseDescriptor = $convert.base64Decode(
    'ChREZWxldGVBY3Rpb25SZXNwb25zZRIbCglhY3Rpb25faWQYASABKAlSCGFjdGlvbklkEkEKBnN0YXR1cxgDIAEoDjIpLnNpbC5zdGFyZmlzaC5EZWxldGVBY3Rpb25SZXNwb25zZS5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAQgASgJUgdtZXNzYWdlIiIKBlN0YXR1cxILCgdTVUNDRVNTEAASCwoHRkFJTFVSRRAB');
@$core.Deprecated('Use deletedResourceDescriptor instead')
const DeletedResource$json = const {
  '1': 'DeletedResource',
  '2': const [
    const {
      '1': 'resource_type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.ResourceType',
      '10': 'resourceType'
    },
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {
      '1': 'deletion_date',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'deletionDate'
    },
  ],
};

/// Descriptor for `DeletedResource`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletedResourceDescriptor = $convert.base64Decode(
    'Cg9EZWxldGVkUmVzb3VyY2USPwoNcmVzb3VyY2VfdHlwZRgBIAEoDjIaLnNpbC5zdGFyZmlzaC5SZXNvdXJjZVR5cGVSDHJlc291cmNlVHlwZRIOCgJpZBgCIAEoCVICaWQSNgoNZGVsZXRpb25fZGF0ZRgDIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDGRlbGV0aW9uRGF0ZQ==');
@$core.Deprecated('Use deleteGroupUserRequestDescriptor instead')
const DeleteGroupUserRequest$json = const {
  '1': 'DeleteGroupUserRequest',
  '2': const [
    const {'1': 'group_user_id', '3': 1, '4': 1, '5': 9, '10': 'groupUserId'},
  ],
};

/// Descriptor for `DeleteGroupUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupUserRequestDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVHcm91cFVzZXJSZXF1ZXN0EiIKDWdyb3VwX3VzZXJfaWQYASABKAlSC2dyb3VwVXNlcklk');
@$core.Deprecated('Use deleteGroupUserResponseDescriptor instead')
const DeleteGroupUserResponse$json = const {
  '1': 'DeleteGroupUserResponse',
  '2': const [
    const {'1': 'group_user_id', '3': 1, '4': 1, '5': 9, '10': 'groupUserId'},
    const {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.DeleteGroupUserResponse.Status',
      '10': 'status'
    },
    const {'1': 'message', '3': 4, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [DeleteGroupUserResponse_Status$json],
};

@$core.Deprecated('Use deleteGroupUserResponseDescriptor instead')
const DeleteGroupUserResponse_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'FAILURE', '2': 1},
  ],
};

/// Descriptor for `DeleteGroupUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteGroupUserResponseDescriptor =
    $convert.base64Decode(
        'ChdEZWxldGVHcm91cFVzZXJSZXNwb25zZRIiCg1ncm91cF91c2VyX2lkGAEgASgJUgtncm91cFVzZXJJZBJECgZzdGF0dXMYAyABKA4yLC5zaWwuc3RhcmZpc2guRGVsZXRlR3JvdXBVc2VyUmVzcG9uc2UuU3RhdHVzUgZzdGF0dXMSGAoHbWVzc2FnZRgEIAEoCVIHbWVzc2FnZSIiCgZTdGF0dXMSCwoHU1VDQ0VTUxAAEgsKB0ZBSUxVUkUQAQ==');
@$core.Deprecated('Use deleteMaterialRequestDescriptor instead')
const DeleteMaterialRequest$json = const {
  '1': 'DeleteMaterialRequest',
  '2': const [
    const {'1': 'material_id', '3': 1, '4': 1, '5': 9, '10': 'materialId'},
  ],
};

/// Descriptor for `DeleteMaterialRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMaterialRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVNYXRlcmlhbFJlcXVlc3QSHwoLbWF0ZXJpYWxfaWQYASABKAlSCm1hdGVyaWFsSWQ=');
@$core.Deprecated('Use deleteMaterialResponseDescriptor instead')
const DeleteMaterialResponse$json = const {
  '1': 'DeleteMaterialResponse',
  '2': const [
    const {'1': 'material_id', '3': 1, '4': 1, '5': 9, '10': 'materialId'},
    const {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.DeleteMaterialResponse.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List deleteMaterialResponseDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVNYXRlcmlhbFJlc3BvbnNlEh8KC21hdGVyaWFsX2lkGAEgASgJUgptYXRlcmlhbElkEkMKBnN0YXR1cxgDIAEoDjIrLnNpbC5zdGFyZmlzaC5EZWxldGVNYXRlcmlhbFJlc3BvbnNlLlN0YXR1c1IGc3RhdHVzEhgKB21lc3NhZ2UYBCABKAlSB21lc3NhZ2UiIgoGU3RhdHVzEgsKB1NVQ0NFU1MQABILCgdGQUlMVVJFEAE=');
@$core.Deprecated('Use editDescriptor instead')
const Edit$json = const {
  '1': 'Edit',
  '2': const [
    const {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
    const {
      '1': 'time',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'time'
    },
    const {
      '1': 'event',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.Edit.Event',
      '10': 'event'
    },
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
final $typed_data.Uint8List editDescriptor = $convert.base64Decode(
    'CgRFZGl0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZRIuCgR0aW1lGAMgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIEdGltZRIuCgVldmVudBgEIAEoDjIYLnNpbC5zdGFyZmlzaC5FZGl0LkV2ZW50UgVldmVudCJCCgVFdmVudBIVChFFVkVOVF9VTlNQRUNJRklFRBAAEgoKBkNSRUFURRABEgoKBlVQREFURRACEgoKBkRFTEVURRAD');
@$core.Deprecated('Use evaluationCategoryDescriptor instead')
const EvaluationCategory$json = const {
  '1': 'EvaluationCategory',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {
      '1': 'value_names',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.EvaluationValueName',
      '10': 'valueNames'
    },
  ],
};

/// Descriptor for `EvaluationCategory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluationCategoryDescriptor = $convert.base64Decode(
    'ChJFdmFsdWF0aW9uQ2F0ZWdvcnkSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWUSQgoLdmFsdWVfbmFtZXMYAyADKAsyIS5zaWwuc3RhcmZpc2guRXZhbHVhdGlvblZhbHVlTmFtZVIKdmFsdWVOYW1lcw==');
@$core.Deprecated('Use evaluationValueNameDescriptor instead')
const EvaluationValueName$json = const {
  '1': 'EvaluationValueName',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 5, '10': 'value'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'id', '3': 3, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `EvaluationValueName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List evaluationValueNameDescriptor = $convert.base64Decode(
    'ChNFdmFsdWF0aW9uVmFsdWVOYW1lEhQKBXZhbHVlGAEgASgFUgV2YWx1ZRISCgRuYW1lGAIgASgJUgRuYW1lEg4KAmlkGAMgASgJUgJpZA==');
@$core.Deprecated('Use groupDescriptor instead')
const Group$json = const {
  '1': 'Group',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'language_ids', '3': 3, '4': 3, '5': 9, '10': 'languageIds'},
    const {
      '1': 'users',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.GroupUser',
      '10': 'users'
    },
    const {
      '1': 'evaluation_category_ids',
      '3': 5,
      '4': 3,
      '5': 9,
      '10': 'evaluationCategoryIds'
    },
    const {
      '1': 'edit_history',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.Edit',
      '10': 'editHistory'
    },
    const {'1': 'description', '3': 8, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'link_email', '3': 9, '4': 1, '5': 9, '10': 'linkEmail'},
    const {
      '1': 'languages',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.Group.LanguagesEntry',
      '10': 'languages'
    },
    const {
      '1': 'status',
      '3': 11,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.Group.Status',
      '10': 'status'
    },
    const {
      '1': 'output_markers',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.OutputMarker',
      '10': 'outputMarkers'
    },
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
final $typed_data.Uint8List groupDescriptor = $convert.base64Decode(
    'CgVHcm91cBIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZRIhCgxsYW5ndWFnZV9pZHMYAyADKAlSC2xhbmd1YWdlSWRzEi0KBXVzZXJzGAQgAygLMhcuc2lsLnN0YXJmaXNoLkdyb3VwVXNlclIFdXNlcnMSNgoXZXZhbHVhdGlvbl9jYXRlZ29yeV9pZHMYBSADKAlSFWV2YWx1YXRpb25DYXRlZ29yeUlkcxI1CgxlZGl0X2hpc3RvcnkYByADKAsyEi5zaWwuc3RhcmZpc2guRWRpdFILZWRpdEhpc3RvcnkSIAoLZGVzY3JpcHRpb24YCCABKAlSC2Rlc2NyaXB0aW9uEh0KCmxpbmtfZW1haWwYCSABKAlSCWxpbmtFbWFpbBJACglsYW5ndWFnZXMYCiADKAsyIi5zaWwuc3RhcmZpc2guR3JvdXAuTGFuZ3VhZ2VzRW50cnlSCWxhbmd1YWdlcxIyCgZzdGF0dXMYCyABKA4yGi5zaWwuc3RhcmZpc2guR3JvdXAuU3RhdHVzUgZzdGF0dXMSQQoOb3V0cHV0X21hcmtlcnMYDSADKAsyGi5zaWwuc3RhcmZpc2guT3V0cHV0TWFya2VyUg1vdXRwdXRNYXJrZXJzGjwKDkxhbmd1YWdlc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAEiIgoGU3RhdHVzEgoKBkFDVElWRRAAEgwKCElOQUNUSVZFEAE=');
@$core.Deprecated('Use groupEvaluationDescriptor instead')
const GroupEvaluation$json = const {
  '1': 'GroupEvaluation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {
      '1': 'month',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'month'
    },
    const {
      '1': 'evaluation',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.GroupEvaluation.Evaluation',
      '10': 'evaluation'
    },
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
final $typed_data.Uint8List groupEvaluationDescriptor = $convert.base64Decode(
    'Cg9Hcm91cEV2YWx1YXRpb24SDgoCaWQYASABKAlSAmlkEhcKB3VzZXJfaWQYAiABKAlSBnVzZXJJZBIZCghncm91cF9pZBgDIAEoCVIHZ3JvdXBJZBInCgVtb250aBgEIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSBW1vbnRoEkgKCmV2YWx1YXRpb24YBSABKA4yKC5zaWwuc3RhcmZpc2guR3JvdXBFdmFsdWF0aW9uLkV2YWx1YXRpb25SCmV2YWx1YXRpb24iNQoKRXZhbHVhdGlvbhIUChBFVkFMX1VOU1BFQ0lGSUVEEAASBwoDQkFEEAESCAoER09PRBAC');
@$core.Deprecated('Use groupUserDescriptor instead')
const GroupUser$json = const {
  '1': 'GroupUser',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'group_id', '3': 2, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    const {
      '1': 'role',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.GroupUser.Role',
      '10': 'role'
    },
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
final $typed_data.Uint8List groupUserDescriptor = $convert.base64Decode(
    'CglHcm91cFVzZXISDgoCaWQYASABKAlSAmlkEhkKCGdyb3VwX2lkGAIgASgJUgdncm91cElkEhcKB3VzZXJfaWQYAyABKAlSBnVzZXJJZBIwCgRyb2xlGAQgASgOMhwuc2lsLnN0YXJmaXNoLkdyb3VwVXNlci5Sb2xlUgRyb2xlEhgKB3Byb2ZpbGUYBSABKAlSB3Byb2ZpbGUiQQoEUm9sZRIUChBVTlNQRUNJRklFRF9ST0xFEAASCwoHTEVBUk5FUhABEgsKB1RFQUNIRVIQAhIJCgVBRE1JThAD');
@$core.Deprecated('Use languageDescriptor instead')
const Language$json = const {
  '1': 'Language',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `Language`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List languageDescriptor = $convert.base64Decode(
    'CghMYW5ndWFnZRIOCgJpZBgBIAEoCVICaWQSEgoEbmFtZRgCIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use learnerEvaluationDescriptor instead')
const LearnerEvaluation$json = const {
  '1': 'LearnerEvaluation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'learner_id', '3': 2, '4': 1, '5': 9, '10': 'learnerId'},
    const {'1': 'evaluator_id', '3': 3, '4': 1, '5': 9, '10': 'evaluatorId'},
    const {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {
      '1': 'month',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'month'
    },
    const {'1': 'category_id', '3': 6, '4': 1, '5': 9, '10': 'categoryId'},
    const {'1': 'evaluation', '3': 7, '4': 1, '5': 5, '10': 'evaluation'},
  ],
};

/// Descriptor for `LearnerEvaluation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List learnerEvaluationDescriptor = $convert.base64Decode(
    'ChFMZWFybmVyRXZhbHVhdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKbGVhcm5lcl9pZBgCIAEoCVIJbGVhcm5lcklkEiEKDGV2YWx1YXRvcl9pZBgDIAEoCVILZXZhbHVhdG9ySWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSJwoFbW9udGgYBSABKAsyES5nb29nbGUudHlwZS5EYXRlUgVtb250aBIfCgtjYXRlZ29yeV9pZBgGIAEoCVIKY2F0ZWdvcnlJZBIeCgpldmFsdWF0aW9uGAcgASgFUgpldmFsdWF0aW9u');
@$core.Deprecated('Use listActionsRequestDescriptor instead')
const ListActionsRequest$json = const {
  '1': 'ListActionsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListActionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listActionsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0QWN0aW9uc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listAllCountriesRequestDescriptor instead')
const ListAllCountriesRequest$json = const {
  '1': 'ListAllCountriesRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListAllCountriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAllCountriesRequestDescriptor =
    $convert.base64Decode(
        'ChdMaXN0QWxsQ291bnRyaWVzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listEvaluationCategoriesRequestDescriptor instead')
const ListEvaluationCategoriesRequest$json = const {
  '1': 'ListEvaluationCategoriesRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListEvaluationCategoriesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listEvaluationCategoriesRequestDescriptor =
    $convert.base64Decode(
        'Ch9MaXN0RXZhbHVhdGlvbkNhdGVnb3JpZXNSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use listGroupsRequestDescriptor instead')
const ListGroupsRequest$json = const {
  '1': 'ListGroupsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListGroupsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupsRequestDescriptor = $convert.base64Decode(
    'ChFMaXN0R3JvdXBzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listGroupEvaluationsRequestDescriptor instead')
const ListGroupEvaluationsRequest$json = const {
  '1': 'ListGroupEvaluationsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListGroupEvaluationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listGroupEvaluationsRequestDescriptor =
    $convert.base64Decode(
        'ChtMaXN0R3JvdXBFdmFsdWF0aW9uc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listLanguagesRequestDescriptor instead')
const ListLanguagesRequest$json = const {
  '1': 'ListLanguagesRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListLanguagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLanguagesRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0TGFuZ3VhZ2VzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listLearnerEvaluationsRequestDescriptor instead')
const ListLearnerEvaluationsRequest$json = const {
  '1': 'ListLearnerEvaluationsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListLearnerEvaluationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listLearnerEvaluationsRequestDescriptor =
    $convert.base64Decode(
        'Ch1MaXN0TGVhcm5lckV2YWx1YXRpb25zUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listMaterialsRequestDescriptor instead')
const ListMaterialsRequest$json = const {
  '1': 'ListMaterialsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListMaterialsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialsRequestDescriptor = $convert.base64Decode(
    'ChRMaXN0TWF0ZXJpYWxzUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listMaterialTopicsRequestDescriptor instead')
const ListMaterialTopicsRequest$json = const {
  '1': 'ListMaterialTopicsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListMaterialTopicsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialTopicsRequestDescriptor =
    $convert.base64Decode(
        'ChlMaXN0TWF0ZXJpYWxUb3BpY3NSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use listMaterialTypesRequestDescriptor instead')
const ListMaterialTypesRequest$json = const {
  '1': 'ListMaterialTypesRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListMaterialTypesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMaterialTypesRequestDescriptor =
    $convert.base64Decode(
        'ChhMaXN0TWF0ZXJpYWxUeXBlc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listOutputsRequestDescriptor instead')
const ListOutputsRequest$json = const {
  '1': 'ListOutputsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListOutputsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOutputsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0T3V0cHV0c1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listTeacherResponsesRequestDescriptor instead')
const ListTeacherResponsesRequest$json = const {
  '1': 'ListTeacherResponsesRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListTeacherResponsesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTeacherResponsesRequestDescriptor =
    $convert.base64Decode(
        'ChtMaXN0VGVhY2hlclJlc3BvbnNlc1JlcXVlc3QSNgoNdXBkYXRlZF9zaW5jZRgBIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSDHVwZGF0ZWRTaW5jZQ==');
@$core.Deprecated('Use listTransformationsRequestDescriptor instead')
const ListTransformationsRequest$json = const {
  '1': 'ListTransformationsRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListTransformationsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listTransformationsRequestDescriptor =
    $convert.base64Decode(
        'ChpMaXN0VHJhbnNmb3JtYXRpb25zUmVxdWVzdBI2Cg11cGRhdGVkX3NpbmNlGAEgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIMdXBkYXRlZFNpbmNl');
@$core.Deprecated('Use listUsersRequestDescriptor instead')
const ListUsersRequest$json = const {
  '1': 'ListUsersRequest',
  '2': const [
    const {
      '1': 'updated_since',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'updatedSince'
    },
  ],
};

/// Descriptor for `ListUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUsersRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0VXNlcnNSZXF1ZXN0EjYKDXVwZGF0ZWRfc2luY2UYASABKAsyES5nb29nbGUudHlwZS5EYXRlUgx1cGRhdGVkU2luY2U=');
@$core.Deprecated('Use materialDescriptor instead')
const Material$json = const {
  '1': 'Material',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'creator_id', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    const {
      '1': 'status',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.Material.Status',
      '10': 'status'
    },
    const {
      '1': 'visibility',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.Material.Visibility',
      '10': 'visibility'
    },
    const {
      '1': 'editability',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.Material.Editability',
      '10': 'editability'
    },
    const {'1': 'title', '3': 6, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 7, '4': 1, '5': 9, '10': 'description'},
    const {
      '1': 'target_audience',
      '3': 8,
      '4': 1,
      '5': 9,
      '10': 'targetAudience'
    },
    const {'1': 'url', '3': 9, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'files', '3': 10, '4': 3, '5': 9, '10': 'files'},
    const {'1': 'language_ids', '3': 11, '4': 3, '5': 9, '10': 'languageIds'},
    const {'1': 'type_ids', '3': 12, '4': 3, '5': 9, '10': 'typeIds'},
    const {'1': 'topics', '3': 13, '4': 3, '5': 9, '10': 'topics'},
    const {
      '1': 'feedbacks',
      '3': 14,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.MaterialFeedback',
      '10': 'feedbacks'
    },
    const {
      '1': 'date_created',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'dateCreated'
    },
    const {
      '1': 'date_updated',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'dateUpdated'
    },
    const {
      '1': 'edit_history',
      '3': 17,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.Edit',
      '10': 'editHistory'
    },
    const {
      '1': 'languages',
      '3': 18,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.Material.LanguagesEntry',
      '10': 'languages'
    },
  ],
  '3': const [Material_LanguagesEntry$json],
  '4': const [
    Material_Status$json,
    Material_Visibility$json,
    Material_Editability$json
  ],
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
final $typed_data.Uint8List materialDescriptor = $convert.base64Decode(
    'CghNYXRlcmlhbBIOCgJpZBgBIAEoCVICaWQSHQoKY3JlYXRvcl9pZBgCIAEoCVIJY3JlYXRvcklkEjUKBnN0YXR1cxgDIAEoDjIdLnNpbC5zdGFyZmlzaC5NYXRlcmlhbC5TdGF0dXNSBnN0YXR1cxJBCgp2aXNpYmlsaXR5GAQgASgOMiEuc2lsLnN0YXJmaXNoLk1hdGVyaWFsLlZpc2liaWxpdHlSCnZpc2liaWxpdHkSRAoLZWRpdGFiaWxpdHkYBSABKA4yIi5zaWwuc3RhcmZpc2guTWF0ZXJpYWwuRWRpdGFiaWxpdHlSC2VkaXRhYmlsaXR5EhQKBXRpdGxlGAYgASgJUgV0aXRsZRIgCgtkZXNjcmlwdGlvbhgHIAEoCVILZGVzY3JpcHRpb24SJwoPdGFyZ2V0X2F1ZGllbmNlGAggASgJUg50YXJnZXRBdWRpZW5jZRIQCgN1cmwYCSABKAlSA3VybBIUCgVmaWxlcxgKIAMoCVIFZmlsZXMSIQoMbGFuZ3VhZ2VfaWRzGAsgAygJUgtsYW5ndWFnZUlkcxIZCgh0eXBlX2lkcxgMIAMoCVIHdHlwZUlkcxIWCgZ0b3BpY3MYDSADKAlSBnRvcGljcxI8CglmZWVkYmFja3MYDiADKAsyHi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxGZWVkYmFja1IJZmVlZGJhY2tzEjQKDGRhdGVfY3JlYXRlZBgPIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSC2RhdGVDcmVhdGVkEjQKDGRhdGVfdXBkYXRlZBgQIAEoCzIRLmdvb2dsZS50eXBlLkRhdGVSC2RhdGVVcGRhdGVkEjUKDGVkaXRfaGlzdG9yeRgRIAMoCzISLnNpbC5zdGFyZmlzaC5FZGl0UgtlZGl0SGlzdG9yeRJDCglsYW5ndWFnZXMYEiADKAsyJS5zaWwuc3RhcmZpc2guTWF0ZXJpYWwuTGFuZ3VhZ2VzRW50cnlSCWxhbmd1YWdlcxo8Cg5MYW5ndWFnZXNFbnRyeRIQCgNrZXkYASABKAlSA2tleRIUCgV2YWx1ZRgCIAEoCVIFdmFsdWU6AjgBIjoKBlN0YXR1cxIWChJVTlNQRUNJRklFRF9TVEFUVVMQABIKCgZBQ1RJVkUQARIMCghJTkFDVElWRRACIlgKClZpc2liaWxpdHkSGgoWVU5TUEVDSUZJRURfVklTSUJJTElUWRAAEhAKDENSRUFUT1JfVklFVxABEg4KCkdST1VQX1ZJRVcQAhIMCghBTExfVklFVxADIkwKC0VkaXRhYmlsaXR5EhsKF1VOU1BFQ0lGSUVEX0VESVRBQklMSVRZEAASEAoMQ1JFQVRPUl9FRElUEAESDgoKR1JPVVBfRURJVBAC');
@$core.Deprecated('Use materialFeedbackDescriptor instead')
const MaterialFeedback$json = const {
  '1': 'MaterialFeedback',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.MaterialFeedback.Type',
      '10': 'type'
    },
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
final $typed_data.Uint8List materialFeedbackDescriptor = $convert.base64Decode(
    'ChBNYXRlcmlhbEZlZWRiYWNrEg4KAmlkGAEgASgJUgJpZBI3CgR0eXBlGAIgASgOMiMuc2lsLnN0YXJmaXNoLk1hdGVyaWFsRmVlZGJhY2suVHlwZVIEdHlwZRIfCgtyZXBvcnRlcl9pZBgDIAEoCVIKcmVwb3J0ZXJJZBIWCgZyZXBvcnQYBCABKAlSBnJlcG9ydBIaCghyZXNwb25zZRgFIAEoCVIIcmVzcG9uc2USHwoLbWF0ZXJpYWxfaWQYBiABKAlSCm1hdGVyaWFsSWQiLwoEVHlwZRIUChBVTlNQRUNJRklFRF9UWVBFEAASEQoNSU5BUFBST1BSSUFURRAB');
@$core.Deprecated('Use materialTopicDescriptor instead')
const MaterialTopic$json = const {
  '1': 'MaterialTopic',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MaterialTopic`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List materialTopicDescriptor = $convert.base64Decode(
    'Cg1NYXRlcmlhbFRvcGljEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1l');
@$core.Deprecated('Use materialTypeDescriptor instead')
const MaterialType$json = const {
  '1': 'MaterialType',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `MaterialType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List materialTypeDescriptor = $convert.base64Decode(
    'CgxNYXRlcmlhbFR5cGUSDgoCaWQYASABKAlSAmlkEhIKBG5hbWUYAiABKAlSBG5hbWU=');
@$core.Deprecated('Use outputDescriptor instead')
const Output$json = const {
  '1': 'Output',
  '2': const [
    const {'1': 'group_id', '3': 1, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    const {
      '1': 'month',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'month'
    },
    const {'1': 'value', '3': 6, '4': 1, '5': 3, '10': 'value'},
    const {
      '1': 'output_marker',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.OutputMarker',
      '10': 'outputMarker'
    },
  ],
};

/// Descriptor for `Output`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outputDescriptor = $convert.base64Decode(
    'CgZPdXRwdXQSGQoIZ3JvdXBfaWQYASABKAlSB2dyb3VwSWQSDgoCaWQYAiABKAlSAmlkEicKBW1vbnRoGAUgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIFbW9udGgSFAoFdmFsdWUYBiABKANSBXZhbHVlEj8KDW91dHB1dF9tYXJrZXIYByABKAsyGi5zaWwuc3RhcmZpc2guT3V0cHV0TWFya2VyUgxvdXRwdXRNYXJrZXI=');
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
final $typed_data.Uint8List outputMarkerDescriptor = $convert.base64Decode(
    'CgxPdXRwdXRNYXJrZXISHQoKcHJvamVjdF9pZBgCIAEoCVIJcHJvamVjdElkEhsKCW1hcmtlcl9pZBgDIAEoCVIIbWFya2VySWQSHwoLbWFya2VyX25hbWUYBCABKAlSCm1hcmtlck5hbWU=');
@$core.Deprecated('Use refreshSessionRequestDescriptor instead')
const RefreshSessionRequest$json = const {
  '1': 'RefreshSessionRequest',
  '2': const [
    const {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'refresh_token', '3': 2, '4': 1, '5': 9, '10': 'refreshToken'},
  ],
};

/// Descriptor for `RefreshSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List refreshSessionRequestDescriptor = $convert.base64Decode(
    'ChVSZWZyZXNoU2Vzc2lvblJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklkEiMKDXJlZnJlc2hfdG9rZW4YAiABKAlSDHJlZnJlc2hUb2tlbg==');
@$core.Deprecated('Use syncErrorDescriptor instead')
const SyncError$json = const {
  '1': 'SyncError',
  '2': const [
    const {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.SyncRequest',
      '10': 'request'
    },
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `SyncError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncErrorDescriptor = $convert.base64Decode(
    'CglTeW5jRXJyb3ISMwoHcmVxdWVzdBgBIAEoCzIZLnNpbC5zdGFyZmlzaC5TeW5jUmVxdWVzdFIHcmVxdWVzdBIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl');
@$core.Deprecated('Use syncRequestMetaDataDescriptor instead')
const SyncRequestMetaData$json = const {
  '1': 'SyncRequestMetaData',
  '2': const [
    const {
      '1': 'get_new_records',
      '3': 1,
      '4': 1,
      '5': 8,
      '10': 'getNewRecords'
    },
    const {
      '1': 'updated_since',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedSince'
    },
    const {
      '1': 'resource_type_whitelist',
      '3': 3,
      '4': 3,
      '5': 14,
      '6': '.sil.starfish.ResourceType',
      '10': 'resourceTypeWhitelist'
    },
    const {
      '1': 'resource_type_blacklist',
      '3': 4,
      '4': 3,
      '5': 14,
      '6': '.sil.starfish.ResourceType',
      '10': 'resourceTypeBlacklist'
    },
  ],
};

/// Descriptor for `SyncRequestMetaData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncRequestMetaDataDescriptor = $convert.base64Decode(
    'ChNTeW5jUmVxdWVzdE1ldGFEYXRhEiYKD2dldF9uZXdfcmVjb3JkcxgBIAEoCFINZ2V0TmV3UmVjb3JkcxI/Cg11cGRhdGVkX3NpbmNlGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIMdXBkYXRlZFNpbmNlElIKF3Jlc291cmNlX3R5cGVfd2hpdGVsaXN0GAMgAygOMhouc2lsLnN0YXJmaXNoLlJlc291cmNlVHlwZVIVcmVzb3VyY2VUeXBlV2hpdGVsaXN0ElIKF3Jlc291cmNlX3R5cGVfYmxhY2tsaXN0GAQgAygOMhouc2lsLnN0YXJmaXNoLlJlc291cmNlVHlwZVIVcmVzb3VyY2VUeXBlQmxhY2tsaXN0');
@$core.Deprecated('Use syncResponseMetaDataDescriptor instead')
const SyncResponseMetaData$json = const {
  '1': 'SyncResponseMetaData',
  '2': const [
    const {
      '1': 'request_time',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'requestTime'
    },
  ],
};

/// Descriptor for `SyncResponseMetaData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncResponseMetaDataDescriptor = $convert.base64Decode(
    'ChRTeW5jUmVzcG9uc2VNZXRhRGF0YRI9CgxyZXF1ZXN0X3RpbWUYASABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgtyZXF1ZXN0VGltZQ==');
@$core.Deprecated('Use syncRequestDescriptor instead')
const SyncRequest$json = const {
  '1': 'SyncRequest',
  '2': const [
    const {
      '1': 'meta_data',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.SyncRequestMetaData',
      '9': 0,
      '10': 'metaData'
    },
    const {
      '1': 'create_material_feedback',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateMaterialFeedbacksRequest',
      '9': 0,
      '10': 'createMaterialFeedback'
    },
    const {
      '1': 'create_update_action',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateActionsRequest',
      '9': 0,
      '10': 'createUpdateAction'
    },
    const {
      '1': 'create_update_action_user',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateActionUserRequest',
      '9': 0,
      '10': 'createUpdateActionUser'
    },
    const {
      '1': 'create_update_group_evaluation',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateGroupEvaluationRequest',
      '9': 0,
      '10': 'createUpdateGroupEvaluation'
    },
    const {
      '1': 'create_update_group',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateGroupsRequest',
      '9': 0,
      '10': 'createUpdateGroup'
    },
    const {
      '1': 'create_update_group_user',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateGroupUsersRequest',
      '9': 0,
      '10': 'createUpdateGroupUser'
    },
    const {
      '1': 'create_update_learner_evaluation',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateLearnerEvaluationRequest',
      '9': 0,
      '10': 'createUpdateLearnerEvaluation'
    },
    const {
      '1': 'create_update_material',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateMaterialsRequest',
      '9': 0,
      '10': 'createUpdateMaterial'
    },
    const {
      '1': 'create_update_output',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateOutputRequest',
      '9': 0,
      '10': 'createUpdateOutput'
    },
    const {
      '1': 'create_update_teacher_response',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateTeacherResponseRequest',
      '9': 0,
      '10': 'createUpdateTeacherResponse'
    },
    const {
      '1': 'create_update_transformation',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateTransformationRequest',
      '9': 0,
      '10': 'createUpdateTransformation'
    },
    const {
      '1': 'create_update_user',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.CreateUpdateUserRequest',
      '9': 0,
      '10': 'createUpdateUser'
    },
    const {
      '1': 'delete_action',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.DeleteActionRequest',
      '9': 0,
      '10': 'deleteAction'
    },
    const {
      '1': 'delete_material',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.DeleteMaterialRequest',
      '9': 0,
      '10': 'deleteMaterial'
    },
    const {
      '1': 'update_current_user',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.UpdateCurrentUserRequest',
      '9': 0,
      '10': 'updateCurrentUser'
    },
    const {
      '1': 'delete_group_user',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.DeleteGroupUserRequest',
      '9': 0,
      '10': 'deleteGroupUser'
    },
  ],
  '8': const [
    const {'1': 'update'},
  ],
};

/// Descriptor for `SyncRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncRequestDescriptor = $convert.base64Decode(
    'CgtTeW5jUmVxdWVzdBJACgltZXRhX2RhdGEYASABKAsyIS5zaWwuc3RhcmZpc2guU3luY1JlcXVlc3RNZXRhRGF0YUgAUghtZXRhRGF0YRJoChhjcmVhdGVfbWF0ZXJpYWxfZmVlZGJhY2sYAiABKAsyLC5zaWwuc3RhcmZpc2guQ3JlYXRlTWF0ZXJpYWxGZWVkYmFja3NSZXF1ZXN0SABSFmNyZWF0ZU1hdGVyaWFsRmVlZGJhY2sSXAoUY3JlYXRlX3VwZGF0ZV9hY3Rpb24YAyABKAsyKC5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlQWN0aW9uc1JlcXVlc3RIAFISY3JlYXRlVXBkYXRlQWN0aW9uEmgKGWNyZWF0ZV91cGRhdGVfYWN0aW9uX3VzZXIYBCABKAsyKy5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlQWN0aW9uVXNlclJlcXVlc3RIAFIWY3JlYXRlVXBkYXRlQWN0aW9uVXNlchJ3Ch5jcmVhdGVfdXBkYXRlX2dyb3VwX2V2YWx1YXRpb24YBSABKAsyMC5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlR3JvdXBFdmFsdWF0aW9uUmVxdWVzdEgAUhtjcmVhdGVVcGRhdGVHcm91cEV2YWx1YXRpb24SWQoTY3JlYXRlX3VwZGF0ZV9ncm91cBgGIAEoCzInLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVHcm91cHNSZXF1ZXN0SABSEWNyZWF0ZVVwZGF0ZUdyb3VwEmYKGGNyZWF0ZV91cGRhdGVfZ3JvdXBfdXNlchgHIAEoCzIrLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVHcm91cFVzZXJzUmVxdWVzdEgAUhVjcmVhdGVVcGRhdGVHcm91cFVzZXISfQogY3JlYXRlX3VwZGF0ZV9sZWFybmVyX2V2YWx1YXRpb24YCCABKAsyMi5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlTGVhcm5lckV2YWx1YXRpb25SZXF1ZXN0SABSHWNyZWF0ZVVwZGF0ZUxlYXJuZXJFdmFsdWF0aW9uEmIKFmNyZWF0ZV91cGRhdGVfbWF0ZXJpYWwYCSABKAsyKi5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlTWF0ZXJpYWxzUmVxdWVzdEgAUhRjcmVhdGVVcGRhdGVNYXRlcmlhbBJbChRjcmVhdGVfdXBkYXRlX291dHB1dBgKIAEoCzInLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVPdXRwdXRSZXF1ZXN0SABSEmNyZWF0ZVVwZGF0ZU91dHB1dBJ3Ch5jcmVhdGVfdXBkYXRlX3RlYWNoZXJfcmVzcG9uc2UYCyABKAsyMC5zaWwuc3RhcmZpc2guQ3JlYXRlVXBkYXRlVGVhY2hlclJlc3BvbnNlUmVxdWVzdEgAUhtjcmVhdGVVcGRhdGVUZWFjaGVyUmVzcG9uc2UScwocY3JlYXRlX3VwZGF0ZV90cmFuc2Zvcm1hdGlvbhgMIAEoCzIvLnNpbC5zdGFyZmlzaC5DcmVhdGVVcGRhdGVUcmFuc2Zvcm1hdGlvblJlcXVlc3RIAFIaY3JlYXRlVXBkYXRlVHJhbnNmb3JtYXRpb24SVQoSY3JlYXRlX3VwZGF0ZV91c2VyGA0gASgLMiUuc2lsLnN0YXJmaXNoLkNyZWF0ZVVwZGF0ZVVzZXJSZXF1ZXN0SABSEGNyZWF0ZVVwZGF0ZVVzZXISSAoNZGVsZXRlX2FjdGlvbhgOIAEoCzIhLnNpbC5zdGFyZmlzaC5EZWxldGVBY3Rpb25SZXF1ZXN0SABSDGRlbGV0ZUFjdGlvbhJOCg9kZWxldGVfbWF0ZXJpYWwYECABKAsyIy5zaWwuc3RhcmZpc2guRGVsZXRlTWF0ZXJpYWxSZXF1ZXN0SABSDmRlbGV0ZU1hdGVyaWFsElgKE3VwZGF0ZV9jdXJyZW50X3VzZXIYESABKAsyJi5zaWwuc3RhcmZpc2guVXBkYXRlQ3VycmVudFVzZXJSZXF1ZXN0SABSEXVwZGF0ZUN1cnJlbnRVc2VyElIKEWRlbGV0ZV9ncm91cF91c2VyGBIgASgLMiQuc2lsLnN0YXJmaXNoLkRlbGV0ZUdyb3VwVXNlclJlcXVlc3RIAFIPZGVsZXRlR3JvdXBVc2VyQggKBnVwZGF0ZQ==');
@$core.Deprecated('Use syncResponseDescriptor instead')
const SyncResponse$json = const {
  '1': 'SyncResponse',
  '2': const [
    const {
      '1': 'action',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Action',
      '9': 0,
      '10': 'action'
    },
    const {
      '1': 'country',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Country',
      '9': 0,
      '10': 'country'
    },
    const {
      '1': 'evaluation_category',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.EvaluationCategory',
      '9': 0,
      '10': 'evaluationCategory'
    },
    const {
      '1': 'group',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Group',
      '9': 0,
      '10': 'group'
    },
    const {
      '1': 'group_evaluation',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.GroupEvaluation',
      '9': 0,
      '10': 'groupEvaluation'
    },
    const {
      '1': 'language',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Language',
      '9': 0,
      '10': 'language'
    },
    const {
      '1': 'learner_evaluation',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.LearnerEvaluation',
      '9': 0,
      '10': 'learnerEvaluation'
    },
    const {
      '1': 'material',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Material',
      '9': 0,
      '10': 'material'
    },
    const {
      '1': 'material_topic',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.MaterialTopic',
      '9': 0,
      '10': 'materialTopic'
    },
    const {
      '1': 'material_type',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.MaterialType',
      '9': 0,
      '10': 'materialType'
    },
    const {
      '1': 'output',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Output',
      '9': 0,
      '10': 'output'
    },
    const {
      '1': 'teacher_response',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.TeacherResponse',
      '9': 0,
      '10': 'teacherResponse'
    },
    const {
      '1': 'transformation',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.Transformation',
      '9': 0,
      '10': 'transformation'
    },
    const {
      '1': 'user',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.User',
      '9': 0,
      '10': 'user'
    },
    const {
      '1': 'deleted_record',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.DeletedResource',
      '9': 0,
      '10': 'deletedRecord'
    },
    const {
      '1': 'meta_data',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.SyncResponseMetaData',
      '9': 0,
      '10': 'metaData'
    },
    const {
      '1': 'error',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.SyncError',
      '9': 0,
      '10': 'error'
    },
  ],
  '8': const [
    const {'1': 'value'},
  ],
};

/// Descriptor for `SyncResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncResponseDescriptor = $convert.base64Decode(
    'CgxTeW5jUmVzcG9uc2USLgoGYWN0aW9uGAEgASgLMhQuc2lsLnN0YXJmaXNoLkFjdGlvbkgAUgZhY3Rpb24SMQoHY291bnRyeRgCIAEoCzIVLnNpbC5zdGFyZmlzaC5Db3VudHJ5SABSB2NvdW50cnkSUwoTZXZhbHVhdGlvbl9jYXRlZ29yeRgDIAEoCzIgLnNpbC5zdGFyZmlzaC5FdmFsdWF0aW9uQ2F0ZWdvcnlIAFISZXZhbHVhdGlvbkNhdGVnb3J5EisKBWdyb3VwGAQgASgLMhMuc2lsLnN0YXJmaXNoLkdyb3VwSABSBWdyb3VwEkoKEGdyb3VwX2V2YWx1YXRpb24YBSABKAsyHS5zaWwuc3RhcmZpc2guR3JvdXBFdmFsdWF0aW9uSABSD2dyb3VwRXZhbHVhdGlvbhI0CghsYW5ndWFnZRgHIAEoCzIWLnNpbC5zdGFyZmlzaC5MYW5ndWFnZUgAUghsYW5ndWFnZRJQChJsZWFybmVyX2V2YWx1YXRpb24YCCABKAsyHy5zaWwuc3RhcmZpc2guTGVhcm5lckV2YWx1YXRpb25IAFIRbGVhcm5lckV2YWx1YXRpb24SNAoIbWF0ZXJpYWwYCSABKAsyFi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxIAFIIbWF0ZXJpYWwSRAoObWF0ZXJpYWxfdG9waWMYCiABKAsyGy5zaWwuc3RhcmZpc2guTWF0ZXJpYWxUb3BpY0gAUg1tYXRlcmlhbFRvcGljEkEKDW1hdGVyaWFsX3R5cGUYCyABKAsyGi5zaWwuc3RhcmZpc2guTWF0ZXJpYWxUeXBlSABSDG1hdGVyaWFsVHlwZRIuCgZvdXRwdXQYDCABKAsyFC5zaWwuc3RhcmZpc2guT3V0cHV0SABSBm91dHB1dBJKChB0ZWFjaGVyX3Jlc3BvbnNlGA0gASgLMh0uc2lsLnN0YXJmaXNoLlRlYWNoZXJSZXNwb25zZUgAUg90ZWFjaGVyUmVzcG9uc2USRgoOdHJhbnNmb3JtYXRpb24YDiABKAsyHC5zaWwuc3RhcmZpc2guVHJhbnNmb3JtYXRpb25IAFIOdHJhbnNmb3JtYXRpb24SKAoEdXNlchgPIAEoCzISLnNpbC5zdGFyZmlzaC5Vc2VySABSBHVzZXISRgoOZGVsZXRlZF9yZWNvcmQYECABKAsyHS5zaWwuc3RhcmZpc2guRGVsZXRlZFJlc291cmNlSABSDWRlbGV0ZWRSZWNvcmQSQQoJbWV0YV9kYXRhGBEgASgLMiIuc2lsLnN0YXJmaXNoLlN5bmNSZXNwb25zZU1ldGFEYXRhSABSCG1ldGFEYXRhEi8KBWVycm9yGBIgASgLMhcuc2lsLnN0YXJmaXNoLlN5bmNFcnJvckgAUgVlcnJvckIHCgV2YWx1ZQ==');
@$core.Deprecated('Use syncWebRequestDescriptor instead')
const SyncWebRequest$json = const {
  '1': 'SyncWebRequest',
  '2': const [
    const {
      '1': 'request_data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.SyncRequest',
      '10': 'requestData'
    },
  ],
};

/// Descriptor for `SyncWebRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncWebRequestDescriptor = $convert.base64Decode(
    'Cg5TeW5jV2ViUmVxdWVzdBI8CgxyZXF1ZXN0X2RhdGEYASADKAsyGS5zaWwuc3RhcmZpc2guU3luY1JlcXVlc3RSC3JlcXVlc3REYXRh');
@$core.Deprecated('Use syncWebResponseDescriptor instead')
const SyncWebResponse$json = const {
  '1': 'SyncWebResponse',
  '2': const [
    const {
      '1': 'response_data',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.SyncResponse',
      '10': 'responseData'
    },
  ],
};

/// Descriptor for `SyncWebResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncWebResponseDescriptor = $convert.base64Decode(
    'Cg9TeW5jV2ViUmVzcG9uc2USPwoNcmVzcG9uc2VfZGF0YRgBIAMoCzIaLnNpbC5zdGFyZmlzaC5TeW5jUmVzcG9uc2VSDHJlc3BvbnNlRGF0YQ==');
@$core.Deprecated('Use teacherResponseDescriptor instead')
const TeacherResponse$json = const {
  '1': 'TeacherResponse',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'learner_id', '3': 2, '4': 1, '5': 9, '10': 'learnerId'},
    const {'1': 'teacher_id', '3': 3, '4': 1, '5': 9, '10': 'teacherId'},
    const {'1': 'group_id', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {
      '1': 'month',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'month'
    },
    const {'1': 'response', '3': 6, '4': 1, '5': 9, '10': 'response'},
  ],
};

/// Descriptor for `TeacherResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List teacherResponseDescriptor = $convert.base64Decode(
    'Cg9UZWFjaGVyUmVzcG9uc2USDgoCaWQYASABKAlSAmlkEh0KCmxlYXJuZXJfaWQYAiABKAlSCWxlYXJuZXJJZBIdCgp0ZWFjaGVyX2lkGAMgASgJUgl0ZWFjaGVySWQSGQoIZ3JvdXBfaWQYBCABKAlSB2dyb3VwSWQSJwoFbW9udGgYBSABKAsyES5nb29nbGUudHlwZS5EYXRlUgVtb250aBIaCghyZXNwb25zZRgGIAEoCVIIcmVzcG9uc2U=');
@$core.Deprecated('Use transformationDescriptor instead')
const Transformation$json = const {
  '1': 'Transformation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    const {'1': 'group_id', '3': 3, '4': 1, '5': 9, '10': 'groupId'},
    const {
      '1': 'month',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.type.Date',
      '10': 'month'
    },
    const {'1': 'impact_story', '3': 5, '4': 1, '5': 9, '10': 'impactStory'},
    const {'1': 'files', '3': 6, '4': 3, '5': 9, '10': 'files'},
  ],
};

/// Descriptor for `Transformation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transformationDescriptor = $convert.base64Decode(
    'Cg5UcmFuc2Zvcm1hdGlvbhIOCgJpZBgBIAEoCVICaWQSFwoHdXNlcl9pZBgCIAEoCVIGdXNlcklkEhkKCGdyb3VwX2lkGAMgASgJUgdncm91cElkEicKBW1vbnRoGAQgASgLMhEuZ29vZ2xlLnR5cGUuRGF0ZVIFbW9udGgSIQoMaW1wYWN0X3N0b3J5GAUgASgJUgtpbXBhY3RTdG9yeRIUCgVmaWxlcxgGIAMoCVIFZmlsZXM=');
@$core.Deprecated('Use updateCurrentUserRequestDescriptor instead')
const UpdateCurrentUserRequest$json = const {
  '1': 'UpdateCurrentUserRequest',
  '2': const [
    const {
      '1': 'user',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sil.starfish.User',
      '10': 'user'
    },
    const {
      '1': 'update_mask',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '10': 'updateMask'
    },
  ],
};

/// Descriptor for `UpdateCurrentUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateCurrentUserRequestDescriptor =
    $convert.base64Decode(
        'ChhVcGRhdGVDdXJyZW50VXNlclJlcXVlc3QSJgoEdXNlchgBIAEoCzISLnNpbC5zdGFyZmlzaC5Vc2VyUgR1c2VyEjsKC3VwZGF0ZV9tYXNrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza1IKdXBkYXRlTWFzaw==');
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
    const {
      '1': 'groups',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.GroupUser',
      '10': 'groups'
    },
    const {
      '1': 'actions',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sil.starfish.ActionUser',
      '10': 'actions'
    },
    const {
      '1': 'selected_actions_tab',
      '3': 9,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.ActionTab',
      '10': 'selectedActionsTab'
    },
    const {
      '1': 'selected_results_tab',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.ResultsTab',
      '10': 'selectedResultsTab'
    },
    const {
      '1': 'phone_country_id',
      '3': 11,
      '4': 1,
      '5': 9,
      '10': 'phoneCountryId'
    },
    const {'1': 'dialling_code', '3': 12, '4': 1, '5': 9, '10': 'diallingCode'},
    const {
      '1': 'status',
      '3': 13,
      '4': 1,
      '5': 14,
      '6': '.sil.starfish.User.Status',
      '10': 'status'
    },
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
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgJUgJpZBISCgRuYW1lGAIgASgJUgRuYW1lEhQKBXBob25lGAMgASgJUgVwaG9uZRIfCgtjb3VudHJ5X2lkcxgEIAMoCVIKY291bnRyeUlkcxIhCgxsYW5ndWFnZV9pZHMYBSADKAlSC2xhbmd1YWdlSWRzEh8KC2xpbmtfZ3JvdXBzGAYgASgIUgpsaW5rR3JvdXBzEi8KBmdyb3VwcxgHIAMoCzIXLnNpbC5zdGFyZmlzaC5Hcm91cFVzZXJSBmdyb3VwcxIyCgdhY3Rpb25zGAggAygLMhguc2lsLnN0YXJmaXNoLkFjdGlvblVzZXJSB2FjdGlvbnMSSQoUc2VsZWN0ZWRfYWN0aW9uc190YWIYCSABKA4yFy5zaWwuc3RhcmZpc2guQWN0aW9uVGFiUhJzZWxlY3RlZEFjdGlvbnNUYWISSgoUc2VsZWN0ZWRfcmVzdWx0c190YWIYCiABKA4yGC5zaWwuc3RhcmZpc2guUmVzdWx0c1RhYlISc2VsZWN0ZWRSZXN1bHRzVGFiEigKEHBob25lX2NvdW50cnlfaWQYCyABKAlSDnBob25lQ291bnRyeUlkEiMKDWRpYWxsaW5nX2NvZGUYDCABKAlSDGRpYWxsaW5nQ29kZRIxCgZzdGF0dXMYDSABKA4yGS5zaWwuc3RhcmZpc2guVXNlci5TdGF0dXNSBnN0YXR1cxIdCgpjcmVhdG9yX2lkGA4gASgJUgljcmVhdG9ySWQiQQoGU3RhdHVzEhYKElNUQVRVU19VTlNQRUNJRklFRBAAEgoKBkFDVElWRRABEhMKD0FDQ09VTlRfUEVORElORxAC');
