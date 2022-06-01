import 'dart:async';

import 'package:starfish/db/hive_file.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

Future<void> downloadFile(HiveFile hiveFile, {required void Function(List<int> chunk) onData}) async {
  final responseStream = await MaterialRepository()
    .apiProvider
    .downloadFile(
      Stream.value(
        DownloadRequest(
          entityId: hiveFile.entityId,
          entityType: EntityType.valueOf(hiveFile.entityType!),
          filenames: <String>[hiveFile.filename],
        ),
      ),
    );

  await for (final fileData in responseStream) {
    if (fileData.hasMetaData()) {
      // print("META DATA: ${fileData.metaData}");
    } else if (fileData.hasChunk()) {
      // print("FILE CHUNK: ${fileData.chunk.length}");
      onData(fileData.chunk);
    }
  }
}

Future<void> uploadFile({required FutureOr<void> Function(StreamController<FileData> controller) readStream}) async {
  final controller = StreamController<FileData>();

  final responseStream = await MaterialRepository()
      .apiProvider
      .uploadFile(controller.stream);

  await readStream(controller);

  await controller.close();

  await for (final uploadStatus in responseStream) {
    if (uploadStatus.status == UploadStatus_Status.OK) {
      return;
    } else if (uploadStatus.status == UploadStatus_Status.FAILED) {
      throw Exception('Upload failed');
    }
  }
}
