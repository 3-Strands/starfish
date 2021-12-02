///
//  Generated code. Do not modify.
//  source: file_transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class EntityType extends $pb.ProtobufEnum {
  static const EntityType ENTITY_UNSPECIFIED = EntityType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ENTITY_UNSPECIFIED');
  static const EntityType MATERIAL = EntityType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MATERIAL');

  static const $core.List<EntityType> values = <EntityType> [
    ENTITY_UNSPECIFIED,
    MATERIAL,
  ];

  static final $core.Map<$core.int, EntityType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static EntityType? valueOf($core.int value) => _byValue[value];

  const EntityType._($core.int v, $core.String n) : super(v, n);
}

class UploadStatus_Status extends $pb.ProtobufEnum {
  static const UploadStatus_Status UNKNOWN = UploadStatus_Status._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const UploadStatus_Status OK = UploadStatus_Status._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OK');
  static const UploadStatus_Status FAILED = UploadStatus_Status._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FAILED');

  static const $core.List<UploadStatus_Status> values = <UploadStatus_Status> [
    UNKNOWN,
    OK,
    FAILED,
  ];

  static final $core.Map<$core.int, UploadStatus_Status> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UploadStatus_Status? valueOf($core.int value) => _byValue[value];

  const UploadStatus_Status._($core.int v, $core.String n) : super(v, n);
}

