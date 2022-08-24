import 'dart:async';
import 'dart:io' as io show File, RandomAccessFile, FileMode;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'file_system_shared.dart' as shared;

// TODO: don't download the file again if already downloaded.
downloadMaterial(FileReference fileReference) async {
  String filePath = await File._filepathFromFilename(fileReference.filename);

  io.File file = io.File(filePath);
  await file.create();
  io.RandomAccessFile randomAccessFile =
      await file.open(mode: io.FileMode.write);

  await shared.downloadFile(fileReference,
      onData: (chunk) => randomAccessFile.writeFromSync(chunk));
  await randomAccessFile.close();

  fileReference.filepath = file.path;
}

Future<void> uploadMaterials(Iterable<FileReference> fileReferences) =>
    shared.uploadFile(readStream: (controller) async {
      for (final fileReference in fileReferences) {
        final file = io.File(fileReference.filepath!);
        final metaData = FileMetaData(
          entityId: fileReference.entityId,
          filename: fileReference.filename,
          entityType: EntityType.MATERIAL,
        );

        controller.add(FileData(metaData: metaData));

        Stream<List<int>> inputStream = file.openRead();
        await for (final data in inputStream) {
          controller.add(FileData(chunk: data));
        }
      }
    });

Future<void> openFile(String filepath) async {
  await OpenFile.open(filepath);
}

class File {
  final io.File _ioFile;

  File(String path) : _ioFile = io.File(path);

  static Future<String> _filepathFromFilename(String filename) async {
    final appDocumentsPath = await getApplicationDocumentsDirectory();
    return '${appDocumentsPath.path}/$filename';
  }

  static Future<File> fromFilename(String filename) async {
    return File(await _filepathFromFilename(filename));
  }

  String get path => _ioFile.path;

  Widget getImagePreview({
    BoxFit? fit,
    double? width,
    double? height,
  }) =>
      Image.file(
        _ioFile,
        fit: fit,
        width: width,
        height: height,
      );

  int get size => _ioFile.statSync().size;

  Future<void> createWithContent(Uint8List buffer) async {
    _ioFile.create(recursive: true);

    final _randomAccessFile = await _ioFile.open(mode: io.FileMode.write);

    await _randomAccessFile.writeFrom(buffer);

    await _randomAccessFile.close();
  }
}
