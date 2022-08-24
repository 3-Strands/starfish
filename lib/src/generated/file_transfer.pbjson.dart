///
//  Generated code. Do not modify.
//  source: file_transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use entityTypeDescriptor instead')
const EntityType$json = const {
  '1': 'EntityType',
  '2': const [
    const {'1': 'ENTITY_UNSPECIFIED', '2': 0},
    const {'1': 'MATERIAL', '2': 1},
    const {'1': 'TRANSFORMATION', '2': 2},
  ],
};

/// Descriptor for `EntityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List entityTypeDescriptor = $convert.base64Decode('CgpFbnRpdHlUeXBlEhYKEkVOVElUWV9VTlNQRUNJRklFRBAAEgwKCE1BVEVSSUFMEAESEgoOVFJBTlNGT1JNQVRJT04QAg==');
@$core.Deprecated('Use fileDataDescriptor instead')
const FileData$json = const {
  '1': 'FileData',
  '2': const [
    const {'1': 'meta_data', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.FileMetaData', '9': 0, '10': 'metaData'},
    const {'1': 'chunk', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'chunk'},
  ],
  '8': const [
    const {'1': 'data'},
  ],
};

/// Descriptor for `FileData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileDataDescriptor = $convert.base64Decode('CghGaWxlRGF0YRI5CgltZXRhX2RhdGEYASABKAsyGi5zaWwuc3RhcmZpc2guRmlsZU1ldGFEYXRhSABSCG1ldGFEYXRhEhYKBWNodW5rGAIgASgMSABSBWNodW5rQgYKBGRhdGE=');
@$core.Deprecated('Use fileMetaDataDescriptor instead')
const FileMetaData$json = const {
  '1': 'FileMetaData',
  '2': const [
    const {'1': 'entity_id', '3': 1, '4': 1, '5': 9, '10': 'entityId'},
    const {'1': 'filename', '3': 2, '4': 1, '5': 9, '10': 'filename'},
    const {'1': 'size', '3': 3, '4': 1, '5': 3, '10': 'size'},
    const {'1': 'md5_checksum', '3': 4, '4': 1, '5': 9, '10': 'md5Checksum'},
    const {'1': 'entity_type', '3': 5, '4': 1, '5': 14, '6': '.sil.starfish.EntityType', '10': 'entityType'},
  ],
};

/// Descriptor for `FileMetaData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fileMetaDataDescriptor = $convert.base64Decode('CgxGaWxlTWV0YURhdGESGwoJZW50aXR5X2lkGAEgASgJUghlbnRpdHlJZBIaCghmaWxlbmFtZRgCIAEoCVIIZmlsZW5hbWUSEgoEc2l6ZRgDIAEoA1IEc2l6ZRIhCgxtZDVfY2hlY2tzdW0YBCABKAlSC21kNUNoZWNrc3VtEjkKC2VudGl0eV90eXBlGAUgASgOMhguc2lsLnN0YXJmaXNoLkVudGl0eVR5cGVSCmVudGl0eVR5cGU=');
@$core.Deprecated('Use uploadStatusDescriptor instead')
const UploadStatus$json = const {
  '1': 'UploadStatus',
  '2': const [
    const {'1': 'file_meta_data', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.FileMetaData', '10': 'fileMetaData'},
    const {'1': 'status', '3': 2, '4': 1, '5': 14, '6': '.sil.starfish.UploadStatus.Status', '10': 'status'},
    const {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
  ],
  '4': const [UploadStatus_Status$json],
};

@$core.Deprecated('Use uploadStatusDescriptor instead')
const UploadStatus_Status$json = const {
  '1': 'Status',
  '2': const [
    const {'1': 'UNKNOWN', '2': 0},
    const {'1': 'OK', '2': 1},
    const {'1': 'FAILED', '2': 2},
  ],
};

/// Descriptor for `UploadStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadStatusDescriptor = $convert.base64Decode('CgxVcGxvYWRTdGF0dXMSQAoOZmlsZV9tZXRhX2RhdGEYASABKAsyGi5zaWwuc3RhcmZpc2guRmlsZU1ldGFEYXRhUgxmaWxlTWV0YURhdGESOQoGc3RhdHVzGAIgASgOMiEuc2lsLnN0YXJmaXNoLlVwbG9hZFN0YXR1cy5TdGF0dXNSBnN0YXR1cxIYCgdtZXNzYWdlGAMgASgJUgdtZXNzYWdlIikKBlN0YXR1cxILCgdVTktOT1dOEAASBgoCT0sQARIKCgZGQUlMRUQQAg==');
@$core.Deprecated('Use downloadErrorDescriptor instead')
const DownloadError$json = const {
  '1': 'DownloadError',
  '2': const [
    const {'1': 'request', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.DownloadRequest', '10': 'request'},
    const {'1': 'file_meta_data', '3': 2, '4': 1, '5': 11, '6': '.sil.starfish.FileMetaData', '10': 'fileMetaData'},
    const {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `DownloadError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadErrorDescriptor = $convert.base64Decode('Cg1Eb3dubG9hZEVycm9yEjcKB3JlcXVlc3QYASABKAsyHS5zaWwuc3RhcmZpc2guRG93bmxvYWRSZXF1ZXN0UgdyZXF1ZXN0EkAKDmZpbGVfbWV0YV9kYXRhGAIgASgLMhouc2lsLnN0YXJmaXNoLkZpbGVNZXRhRGF0YVIMZmlsZU1ldGFEYXRhEhQKBWVycm9yGAMgASgJUgVlcnJvcg==');
@$core.Deprecated('Use downloadRequestDescriptor instead')
const DownloadRequest$json = const {
  '1': 'DownloadRequest',
  '2': const [
    const {'1': 'entity_type', '3': 1, '4': 1, '5': 14, '6': '.sil.starfish.EntityType', '10': 'entityType'},
    const {'1': 'entity_id', '3': 2, '4': 1, '5': 9, '10': 'entityId'},
    const {'1': 'filenames', '3': 3, '4': 3, '5': 9, '10': 'filenames'},
  ],
};

/// Descriptor for `DownloadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadRequestDescriptor = $convert.base64Decode('Cg9Eb3dubG9hZFJlcXVlc3QSOQoLZW50aXR5X3R5cGUYASABKA4yGC5zaWwuc3RhcmZpc2guRW50aXR5VHlwZVIKZW50aXR5VHlwZRIbCgllbnRpdHlfaWQYAiABKAlSCGVudGl0eUlkEhwKCWZpbGVuYW1lcxgDIAMoCVIJZmlsZW5hbWVz');
@$core.Deprecated('Use downloadResponseDescriptor instead')
const DownloadResponse$json = const {
  '1': 'DownloadResponse',
  '2': const [
    const {'1': 'meta_data', '3': 1, '4': 1, '5': 11, '6': '.sil.starfish.FileMetaData', '9': 0, '10': 'metaData'},
    const {'1': 'chunk', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'chunk'},
    const {'1': 'error', '3': 3, '4': 1, '5': 11, '6': '.sil.starfish.DownloadError', '9': 0, '10': 'error'},
  ],
  '8': const [
    const {'1': 'response'},
  ],
};

/// Descriptor for `DownloadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadResponseDescriptor = $convert.base64Decode('ChBEb3dubG9hZFJlc3BvbnNlEjkKCW1ldGFfZGF0YRgBIAEoCzIaLnNpbC5zdGFyZmlzaC5GaWxlTWV0YURhdGFIAFIIbWV0YURhdGESFgoFY2h1bmsYAiABKAxIAFIFY2h1bmsSMwoFZXJyb3IYAyABKAsyGy5zaWwuc3RhcmZpc2guRG93bmxvYWRFcnJvckgAUgVlcnJvckIKCghyZXNwb25zZQ==');
