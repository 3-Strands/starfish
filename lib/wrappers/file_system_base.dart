import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

Future<void> downloadMaterial(FileReference file, FileTransferClient client) =>
    Future.error(Exception("Download not supported"));

Future<void> uploadMaterials(Iterable<FileReference> files) =>
    Future.error(Exception("Upload not supported"));

Future<void> openFile(String filepath) =>
    Future.error("Open file not supported");

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
  }) =>
      SizedBox(height: height, width: width);

  int get size => 0;

  Future<void> createWithContent(Uint8List buffer) async {
    throw Exception('Cannot create/write file');
  }
}
