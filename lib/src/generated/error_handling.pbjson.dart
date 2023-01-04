///
//  Generated code. Do not modify.
//  source: error_handling.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use errorDescriptor instead')
const Error$json = const {
  '1': 'Error',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    const {'1': 'stacktrace', '3': 3, '4': 3, '5': 9, '10': 'stacktrace'},
    const {'1': 'app_version', '3': 4, '4': 1, '5': 9, '10': 'appVersion'},
  ],
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode('CgVFcnJvchISCgR0eXBlGAEgASgJUgR0eXBlEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2USHgoKc3RhY2t0cmFjZRgDIAMoCVIKc3RhY2t0cmFjZRIfCgthcHBfdmVyc2lvbhgEIAEoCVIKYXBwVmVyc2lvbg==');
@$core.Deprecated('Use reportErrorResponseDescriptor instead')
const ReportErrorResponse$json = const {
  '1': 'ReportErrorResponse',
};

/// Descriptor for `ReportErrorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportErrorResponseDescriptor = $convert.base64Decode('ChNSZXBvcnRFcnJvclJlc3BvbnNl');
