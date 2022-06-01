import 'dart:async';
import 'dart:io' as io show File, RandomAccessFile, FileMode;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'file_system_shared.dart' as shared;

// TODO:
Future<String> _getFilePath(String filename) async {
  final appDocumentsPath = await getApplicationDocumentsDirectory();
  String filePath = '${appDocumentsPath.path}/$filename';
  print("FILE PATH: $filePath");
  return filePath;
}

// TODO: don't download the file again if already downloaded.
downloadMaterial(HiveFile hiveFile) async {
  String filePath = await _getFilePath(hiveFile.filename);

  io.File file = io.File(filePath);
  await file.create();
  io.RandomAccessFile randomAccessFile = await file.open(mode: io.FileMode.write);

  await shared.downloadFile(hiveFile,
    onData: (chunk) => randomAccessFile.writeFromSync(chunk));
  await randomAccessFile.close();

  hiveFile.filepath = file.path;
}

Future<void> uploadMaterials(Iterable<HiveFile> hiveFiles) =>
  shared.uploadFile(
    readStream: (controller) async {
      for (final hiveFile in hiveFiles) {
        final file = io.File(hiveFile.filepath!);
        final metaData = FileMetaData(
          entityId: hiveFile.entityId!,
          filename: hiveFile.filename,
          entityType: EntityType.MATERIAL,
        );

        controller.add(FileData(metaData: metaData));

        Stream<List<int>> inputStream = file.openRead();
        await for (final data in inputStream) {
          controller.add(FileData(chunk: data));
        }
      }
    }
  );

Future<void> openFile(String filepath) async {
  await OpenFile.open(filepath);
}

Future<void> initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
}

class File {
  final io.File _ioFile;

  File(String path) : _ioFile = io.File(path);

  String get path => _ioFile.path;

  Widget getImagePreview({
    BoxFit? fit,
    double? width,
    double? height,
  }) => Image.file(
    _ioFile,
    fit: fit,
    width: width,
    height: height,
  );

  Future<Uint8List> readAsBytes() => _ioFile.readAsBytes();

  Uint8List readAsBytesSync() => _ioFile.readAsBytesSync();

  Future<void> createWithContent(List<int> buffer) async {
     _ioFile.create(recursive: true);

    final _randomAccessFile =
        await _ioFile.open(mode: io.FileMode.write);

    _randomAccessFile.writeFromSync(buffer);

    _randomAccessFile.closeSync();
  }
}
