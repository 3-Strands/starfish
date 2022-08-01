import 'dart:async';

import 'package:starfish/models/file_reference.dart';
// import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

Future<void> downloadFile(FileReference file,
    {required void Function(List<int> chunk) onData}) async {
  // final responseStream = await MaterialRepository()
  //   .apiProvider
  //   .downloadFile(
  //     Stream.value(
  //       DownloadRequest(
  //         entityId: file.entityId,
  //         entityType: EntityType.valueOf(file.entityType!),
  //         filenames: <String>[file.filename],
  //       ),
  //     ),
  //   );

  // await for (final fileData in responseStream) {
  //   if (fileData.hasMetaData()) {
  //     // print("META DATA: ${fileData.metaData}");
  //   } else if (fileData.hasChunk()) {
  //     // print("FILE CHUNK: ${fileData.chunk.length}");
  //     onData(fileData.chunk);
  //   }
  // }
}

Future<void> uploadFile(
    {required FutureOr<void> Function(StreamController<FileData> controller)
        readStream}) async {
  // final controller = StreamController<FileData>();

  // final responseStream = await MaterialRepository()
  //     .apiProvider
  //     .uploadFile(controller.stream);

  // await readStream(controller);

  // // await controller.close();

  // await for (final uploadStatus in responseStream) {
  //   if (uploadStatus.status == UploadStatus_Status.OK) {
  //     await controller.close();
  //     return;
  //   } else if (uploadStatus.status == UploadStatus_Status.FAILED) {
  //     throw Exception('Upload failed');
  //   }
  // }
}
