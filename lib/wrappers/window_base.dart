import 'dart:typed_data';

import 'package:starfish/db/hive_file.dart';
// import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

void removeSplashScreen() {}

Future<void> triggerDownload(HiveFile hiveFile) =>
  Future.error(Exception('Cannot trigger a download.'));

abstract class Uploader {
  void addFile(HiveFile hiveFile, Uint8List bytes);
  Future<void> get done;
}

// Future<FileMetaData> triggerUpload(HiveFile hiveFile, Uint8List bytes) =>
//   Future.error(Exception('Cannot trigger an upload.'));
