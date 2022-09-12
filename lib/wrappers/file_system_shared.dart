import 'dart:async';

import 'package:starfish/models/file_reference.dart';
// import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

Future<FileMetaData> downloadFile(FileReference file, FileTransferClient client,
    {required void Function(List<int> chunk) onData}) async {
  final responseStream = client.download(
    Stream.value(
      DownloadRequest(
        entityId: file.entityId,
        entityType: EntityType.valueOf(file.entityType),
        filenames: <String>[file.filename],
      ),
    ),
  );

  FileMetaData? metaData;

  await for (final fileData in responseStream) {
    if (fileData.hasMetaData()) {
      print('Meta data: ${fileData.metaData}');
      metaData = fileData.metaData;
    } else if (fileData.hasChunk()) {
      print('Chunk of length ${fileData.chunk.length}');
      onData(fileData.chunk);
    }
  }

  return metaData ?? FileMetaData();
}

Future<void> uploadFiles(
  Iterable<FileReference> fileReferences,
  FileTransferClient client, {
  required FutureOr<void> Function(
    StreamController<FileData> controller,
    FileReference fileReference,
  )
      readStream,
}) async {
  final controller = StreamController<FileData>();

  final responseStream = client.upload(controller.stream);

  for (final fileReference in fileReferences) {
    await readStream(controller, fileReference);
  }

  controller.close();

  await for (final uploadStatus in responseStream) {
    if (uploadStatus.status == UploadStatus_Status.OK) {
      for (final file in fileReferences) {
        file.isUploaded = true;
        file.save();
      }
      return;
    } else if (uploadStatus.status == UploadStatus_Status.FAILED) {
      final message = uploadStatus.message;
      throw Exception(
          'Upload failed: ${message.isEmpty ? 'unknown error' : message}');
    }
  }
}
