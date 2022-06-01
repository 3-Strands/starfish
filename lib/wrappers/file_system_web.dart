import 'package:starfish/db/hive_file.dart';
import 'file_system_shared.dart' as shared;

export 'file_system_base.dart' show openFile, initHive, File;

Future<void> downloadMaterial(HiveFile hiveFile) async {
  final buffer = <int>[];

  await shared.downloadFile(hiveFile, onData: (chunk) => buffer.addAll(chunk));

  hiveFile.content = buffer;
  // final content = base64Encode(buffer);
  // AnchorElement(
  //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //   ..setAttribute("download", hiveFile.filename!)
  //   ..click();
}
