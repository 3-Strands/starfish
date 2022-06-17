import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:starfish/db/hive_file.dart';

Future<void> downloadMaterial(HiveFile hiveFile) =>
    Future.error(Exception("Download not supported"));

Future<void> uploadMaterials(Iterable<HiveFile> hiveFiles) =>
    Future.error(Exception("Upload not supported"));

Future<void> openFile(String filepath) => Future.error("Open file not supported");

/// On Mobile, calls `Hive.init` with the application's document directory.
Future<void> initHive() async {}

class File {
  final String path;

  File(this.path);

  static Future<File> fromFilename(String filename) async {
    return File(filename);
  }

  Widget getImagePreview({
    BoxFit? fit,
    double? width,
    double? height,
  }) => SizedBox(height: height, width: width);

  int get size => 0;

  Future<void> createWithContent(Uint8List buffer) async {
    throw Exception('Cannot create/write file');
  }
}
