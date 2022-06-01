import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/src/generated/file_transfer.pb.dart';

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

  Widget getImagePreview({
    BoxFit? fit,
    double? width,
    double? height,
  }) {
    final index = path.lastIndexOf('.');
    final extension = index == -1 ? 'UNK' : path.substring(index + 1);
    Widget widget = SizedBox(
      width: width,
      height: height,
      child: Text(extension.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
    );
    if (fit != null) {
      widget = FittedBox(
        fit: fit,
        child: widget,
      );
    }
    return widget;
  }

  Future<Uint8List> readAsBytes() => throw Exception('Cannot read file');
  Uint8List readAsBytesSync() => throw Exception('Cannot read file');

  Future<void> createWithContent(List<int> buffer) async {
    throw Exception('Cannot create/write file');
  }
}
