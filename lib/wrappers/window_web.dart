// import 'dart:async';
// import 'dart:convert';
import 'dart:html' show window;
// import 'dart:typed_data';

// import 'package:starfish/db/hive_file.dart';
// import 'package:starfish/wrappers/file_system_web.dart';
// import 'package:starfish/repository/materials_repository.dart';
// import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';

void removeSplashScreen() {
  window.document.getElementById('splash-img')?.remove();
}

// Future<void> triggerDownload(HiveFile hiveFile) async {
//   if (hiveFile.content == null) {
//     await downloadMaterial(hiveFile);
//     hiveFile.isSynced = true;
//     await hiveFile.save();
//   }

//   final content = base64Encode(hiveFile.content!);
//   AnchorElement(
//       href: "data:application/octet-stream;charset=utf-16le;base64,$content")
//     ..setAttribute("download", hiveFile.filename)
//     ..click();
// }

// Future<FileMetaData> triggerUpload(HiveFile hiveFile, Uint8List bytes) async {
//   final metaData = FileMetaData(
//     entityId: hiveFile.entityId!,
//     filename: hiveFile.filename,
//     entityType: EntityType.MATERIAL,
//   );
//   final fileMetaData = FileData(metaData: metaData);

//   final controller = StreamController<FileData>();

//   final responseStream = await MaterialRepository()
//       .apiProvider
//       .uploadFile(controller.stream);

//   controller.add(fileMetaData);
//   controller.add(FileData(chunk: List<int>.from(bytes)));

//   controller.close();

//   UploadStatus? finalUploadStatus;

//   await for (final uploadStatus in responseStream) {
//     finalUploadStatus = uploadStatus;
//   }

//   if (finalUploadStatus?.status == UploadStatus_Status.OK) {
//     hiveFile.isSynced = true;
//     return finalUploadStatus!.fileMetaData;
//   // } else if (finalUploadStatus?.status == UploadStatus_Status.FAILED) {
//   } else {
//     print(finalUploadStatus);
//     throw Exception('Failed to upload');
//   }
// }
