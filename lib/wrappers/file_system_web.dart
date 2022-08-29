import 'dart:async';
import 'dart:typed_data';

import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:starfish/models/file_reference.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'file_system_shared.dart' as shared;

final _fs = Map<String, String>();

Future<Uint8List> _fetchData(String url) async {
  final xhr = html.HttpRequest()
    ..open('GET', url, async: true)
    ..responseType = 'arraybuffer';

  final completer = Completer<Uint8List>();

  unawaited(xhr.onLoad.first.then((_) {
    final body = (xhr.response as ByteBuffer).asUint8List();
    completer.complete(body);
  }));

  unawaited(xhr.onError.first.then((_) {
    completer.completeError(
        Exception('XMLHttpRequest error.'), StackTrace.current);
  }));

  xhr.send();

  return completer.future;
}

Future<void> downloadMaterial(
    FileReference fileReference, FileTransferClient client) async {
  final buffer = <List<int>>[];

  await shared.downloadFile(fileReference, client,
      onData: (chunk) => buffer.add(chunk));

  final file = await File.fromFilename(fileReference.filename);

  await file._createFromBlob(html.Blob(buffer));

  fileReference.filepath = file.path;
}

Future<void> uploadMaterials(Iterable<FileReference> fileReferences) =>
    shared.uploadFile(readStream: (controller) async {
      for (final fileReference in fileReferences) {
        final metaData = FileMetaData(
          entityId: fileReference.entityId,
          filename: fileReference.filename,
          entityType: EntityType.MATERIAL,
        );

        controller.add(FileData(metaData: metaData));
        final objectUrl = _fs[fileReference.filepath]!;
        final chunk = await _fetchData(objectUrl);
        debugPrint("Uploading file of size: ${chunk.length}");
        controller.add(FileData(chunk: chunk));
      }
    });

Future<void> openFile(String filepath) async {
  html.AnchorElement(href: _fs[filepath]!)
    ..setAttribute("download", filepath.split('/').last)
    ..click();
}

class File {
  final String path;
  int? _size;

  File(this.path);

  static Future<File> fromFilename(String filename) async {
    return File('${UuidGenerator.uuid()}/$filename');
  }

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
      child: Text(extension.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold)),
    );
    if (fit != null) {
      widget = FittedBox(
        fit: fit,
        child: widget,
      );
    }
    return widget;
  }

  int get size {
    assert(_size != null);
    return _size!;
  }

  Future<void> createWithContent(Uint8List buffer) async {
    _size = buffer.lengthInBytes;
    _fs[path] = html.Url.createObjectUrlFromBlob(html.Blob([buffer]));
  }

  Future<void> _createFromBlob(html.Blob blob) async {
    _size = blob.size;
    _fs[path] = html.Url.createObjectUrlFromBlob(blob);
  }
}
