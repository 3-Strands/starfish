///
//  Generated code. Do not modify.
//  source: file_transfer.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'file_transfer.pbenum.dart';

export 'file_transfer.pbenum.dart';

enum FileData_Data {
  metaData, 
  chunk, 
  notSet
}

class FileData extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, FileData_Data> _FileData_DataByTag = {
    1 : FileData_Data.metaData,
    2 : FileData_Data.chunk,
    0 : FileData_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<FileMetaData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaData', subBuilder: FileMetaData.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chunk', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  FileData._() : super();
  factory FileData({
    FileMetaData? metaData,
    $core.List<$core.int>? chunk,
  }) {
    final _result = create();
    if (metaData != null) {
      _result.metaData = metaData;
    }
    if (chunk != null) {
      _result.chunk = chunk;
    }
    return _result;
  }
  factory FileData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileData clone() => FileData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileData copyWith(void Function(FileData) updates) => super.copyWith((message) => updates(message as FileData)) as FileData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileData create() => FileData._();
  FileData createEmptyInstance() => create();
  static $pb.PbList<FileData> createRepeated() => $pb.PbList<FileData>();
  @$core.pragma('dart2js:noInline')
  static FileData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileData>(create);
  static FileData? _defaultInstance;

  FileData_Data whichData() => _FileData_DataByTag[$_whichOneof(0)]!;
  void clearData() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  FileMetaData get metaData => $_getN(0);
  @$pb.TagNumber(1)
  set metaData(FileMetaData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMetaData() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetaData() => clearField(1);
  @$pb.TagNumber(1)
  FileMetaData ensureMetaData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get chunk => $_getN(1);
  @$pb.TagNumber(2)
  set chunk($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChunk() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunk() => clearField(2);
}

class FileMetaData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'FileMetaData', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityId')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filename')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'size')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'md5Checksum')
    ..e<EntityType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityType', $pb.PbFieldType.OE, defaultOrMaker: EntityType.ENTITY_UNSPECIFIED, valueOf: EntityType.valueOf, enumValues: EntityType.values)
    ..hasRequiredFields = false
  ;

  FileMetaData._() : super();
  factory FileMetaData({
    $core.String? entityId,
    $core.String? filename,
    $fixnum.Int64? size,
    $core.String? md5Checksum,
    EntityType? entityType,
  }) {
    final _result = create();
    if (entityId != null) {
      _result.entityId = entityId;
    }
    if (filename != null) {
      _result.filename = filename;
    }
    if (size != null) {
      _result.size = size;
    }
    if (md5Checksum != null) {
      _result.md5Checksum = md5Checksum;
    }
    if (entityType != null) {
      _result.entityType = entityType;
    }
    return _result;
  }
  factory FileMetaData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FileMetaData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FileMetaData clone() => FileMetaData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FileMetaData copyWith(void Function(FileMetaData) updates) => super.copyWith((message) => updates(message as FileMetaData)) as FileMetaData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static FileMetaData create() => FileMetaData._();
  FileMetaData createEmptyInstance() => create();
  static $pb.PbList<FileMetaData> createRepeated() => $pb.PbList<FileMetaData>();
  @$core.pragma('dart2js:noInline')
  static FileMetaData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FileMetaData>(create);
  static FileMetaData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entityId => $_getSZ(0);
  @$pb.TagNumber(1)
  set entityId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEntityId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get filename => $_getSZ(1);
  @$pb.TagNumber(2)
  set filename($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFilename() => $_has(1);
  @$pb.TagNumber(2)
  void clearFilename() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get size => $_getI64(2);
  @$pb.TagNumber(3)
  set size($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSize() => $_has(2);
  @$pb.TagNumber(3)
  void clearSize() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get md5Checksum => $_getSZ(3);
  @$pb.TagNumber(4)
  set md5Checksum($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMd5Checksum() => $_has(3);
  @$pb.TagNumber(4)
  void clearMd5Checksum() => clearField(4);

  @$pb.TagNumber(5)
  EntityType get entityType => $_getN(4);
  @$pb.TagNumber(5)
  set entityType(EntityType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEntityType() => $_has(4);
  @$pb.TagNumber(5)
  void clearEntityType() => clearField(5);
}

class UploadStatus extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'UploadStatus', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<FileMetaData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileMetaData', subBuilder: FileMetaData.create)
    ..e<UploadStatus_Status>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: UploadStatus_Status.UNKNOWN, valueOf: UploadStatus_Status.valueOf, enumValues: UploadStatus_Status.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  UploadStatus._() : super();
  factory UploadStatus({
    FileMetaData? fileMetaData,
    UploadStatus_Status? status,
    $core.String? message,
  }) {
    final _result = create();
    if (fileMetaData != null) {
      _result.fileMetaData = fileMetaData;
    }
    if (status != null) {
      _result.status = status;
    }
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory UploadStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UploadStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UploadStatus clone() => UploadStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UploadStatus copyWith(void Function(UploadStatus) updates) => super.copyWith((message) => updates(message as UploadStatus)) as UploadStatus; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UploadStatus create() => UploadStatus._();
  UploadStatus createEmptyInstance() => create();
  static $pb.PbList<UploadStatus> createRepeated() => $pb.PbList<UploadStatus>();
  @$core.pragma('dart2js:noInline')
  static UploadStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadStatus>(create);
  static UploadStatus? _defaultInstance;

  @$pb.TagNumber(1)
  FileMetaData get fileMetaData => $_getN(0);
  @$pb.TagNumber(1)
  set fileMetaData(FileMetaData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFileMetaData() => $_has(0);
  @$pb.TagNumber(1)
  void clearFileMetaData() => clearField(1);
  @$pb.TagNumber(1)
  FileMetaData ensureFileMetaData() => $_ensure(0);

  @$pb.TagNumber(2)
  UploadStatus_Status get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(UploadStatus_Status v) { setField(2, v); }
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

class DownloadError extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadError', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..aOM<DownloadRequest>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'request', subBuilder: DownloadRequest.create)
    ..aOM<FileMetaData>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileMetaData', subBuilder: FileMetaData.create)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error')
    ..hasRequiredFields = false
  ;

  DownloadError._() : super();
  factory DownloadError({
    DownloadRequest? request,
    FileMetaData? fileMetaData,
    $core.String? error,
  }) {
    final _result = create();
    if (request != null) {
      _result.request = request;
    }
    if (fileMetaData != null) {
      _result.fileMetaData = fileMetaData;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DownloadError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadError clone() => DownloadError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadError copyWith(void Function(DownloadError) updates) => super.copyWith((message) => updates(message as DownloadError)) as DownloadError; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadError create() => DownloadError._();
  DownloadError createEmptyInstance() => create();
  static $pb.PbList<DownloadError> createRepeated() => $pb.PbList<DownloadError>();
  @$core.pragma('dart2js:noInline')
  static DownloadError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadError>(create);
  static DownloadError? _defaultInstance;

  @$pb.TagNumber(1)
  DownloadRequest get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(DownloadRequest v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => clearField(1);
  @$pb.TagNumber(1)
  DownloadRequest ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  FileMetaData get fileMetaData => $_getN(1);
  @$pb.TagNumber(2)
  set fileMetaData(FileMetaData v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileMetaData() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileMetaData() => clearField(2);
  @$pb.TagNumber(2)
  FileMetaData ensureFileMetaData() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
}

class DownloadRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..e<EntityType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityType', $pb.PbFieldType.OE, defaultOrMaker: EntityType.ENTITY_UNSPECIFIED, valueOf: EntityType.valueOf, enumValues: EntityType.values)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'entityId')
    ..pPS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'filenames')
    ..hasRequiredFields = false
  ;

  DownloadRequest._() : super();
  factory DownloadRequest({
    EntityType? entityType,
    $core.String? entityId,
    $core.Iterable<$core.String>? filenames,
  }) {
    final _result = create();
    if (entityType != null) {
      _result.entityType = entityType;
    }
    if (entityId != null) {
      _result.entityId = entityId;
    }
    if (filenames != null) {
      _result.filenames.addAll(filenames);
    }
    return _result;
  }
  factory DownloadRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadRequest clone() => DownloadRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadRequest copyWith(void Function(DownloadRequest) updates) => super.copyWith((message) => updates(message as DownloadRequest)) as DownloadRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadRequest create() => DownloadRequest._();
  DownloadRequest createEmptyInstance() => create();
  static $pb.PbList<DownloadRequest> createRepeated() => $pb.PbList<DownloadRequest>();
  @$core.pragma('dart2js:noInline')
  static DownloadRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadRequest>(create);
  static DownloadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  EntityType get entityType => $_getN(0);
  @$pb.TagNumber(1)
  set entityType(EntityType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasEntityType() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntityType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get entityId => $_getSZ(1);
  @$pb.TagNumber(2)
  set entityId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEntityId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEntityId() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get filenames => $_getList(2);
}

enum DownloadResponse_Response {
  metaData, 
  chunk, 
  error, 
  notSet
}

class DownloadResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, DownloadResponse_Response> _DownloadResponse_ResponseByTag = {
    1 : DownloadResponse_Response.metaData,
    2 : DownloadResponse_Response.chunk,
    3 : DownloadResponse_Response.error,
    0 : DownloadResponse_Response.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'sil.starfish'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<FileMetaData>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'metaData', subBuilder: FileMetaData.create)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chunk', $pb.PbFieldType.OY)
    ..aOM<DownloadError>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'error', subBuilder: DownloadError.create)
    ..hasRequiredFields = false
  ;

  DownloadResponse._() : super();
  factory DownloadResponse({
    FileMetaData? metaData,
    $core.List<$core.int>? chunk,
    DownloadError? error,
  }) {
    final _result = create();
    if (metaData != null) {
      _result.metaData = metaData;
    }
    if (chunk != null) {
      _result.chunk = chunk;
    }
    if (error != null) {
      _result.error = error;
    }
    return _result;
  }
  factory DownloadResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadResponse clone() => DownloadResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadResponse copyWith(void Function(DownloadResponse) updates) => super.copyWith((message) => updates(message as DownloadResponse)) as DownloadResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadResponse create() => DownloadResponse._();
  DownloadResponse createEmptyInstance() => create();
  static $pb.PbList<DownloadResponse> createRepeated() => $pb.PbList<DownloadResponse>();
  @$core.pragma('dart2js:noInline')
  static DownloadResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadResponse>(create);
  static DownloadResponse? _defaultInstance;

  DownloadResponse_Response whichResponse() => _DownloadResponse_ResponseByTag[$_whichOneof(0)]!;
  void clearResponse() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  FileMetaData get metaData => $_getN(0);
  @$pb.TagNumber(1)
  set metaData(FileMetaData v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMetaData() => $_has(0);
  @$pb.TagNumber(1)
  void clearMetaData() => clearField(1);
  @$pb.TagNumber(1)
  FileMetaData ensureMetaData() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get chunk => $_getN(1);
  @$pb.TagNumber(2)
  set chunk($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChunk() => $_has(1);
  @$pb.TagNumber(2)
  void clearChunk() => clearField(2);

  @$pb.TagNumber(3)
  DownloadError get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(DownloadError v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);
  @$pb.TagNumber(3)
  DownloadError ensureError() => $_ensure(2);
}

