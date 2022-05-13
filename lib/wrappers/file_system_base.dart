import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/src/generated/file_transfer.pb.dart';

typedef void DoneCallback<T>(T filePath);
typedef FutureOr<Null> ErrorCallback(Object error, StackTrace stackTrace);

downloadMaterial(HiveFile hiveFile, { required DoneCallback<String> onDone, required ErrorCallback onError })
  => Future.error("Download not supported").catchError(onError);

uploadMaterial(HiveFile hiveFile, StreamController<FileData> controller,
  { required DoneCallback<FileMetaData> onDone, required ErrorCallback onError })
  => Future.error("Upload not supported").catchError(onError);

Future<void> openFile(String filepath) => Future.error("Open file not supported");

/// On Mobile, calls `Hive.init` with the application's document directory.
Future<void> initHive() async {}

class File {
  final String path;

  File(this.path);

  Widget getImagePreview({
    BoxFit? fit,
    double? width,
    double? height,
  }) => SizedBox();

  Future<Uint8List> readAsBytes() => throw Exception('Cannot read file');
  Uint8List readAsBytesSync() => throw Exception('Cannot read file');

  Future<void> createWithContent(List<int> buffer) async {
    throw Exception('Cannot create/write file');
  }
}
