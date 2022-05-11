import 'dart:async';
import 'dart:io' as io show File, RandomAccessFile, FileMode;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:starfish/db/hive_file.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/file_transfer.pbgrpc.dart';
import 'file_system_base.dart' show DoneCallback, ErrorCallback;

// TODO: don't download the file again if already downloaded.
downloadMaterial(HiveFile hiveFile, { required DoneCallback<String> onDone, required ErrorCallback onError }) async {
  //String entityId, String remoteFilename) async {
  String filePath = await getFilePath(hiveFile.filename!);

  io.File file = io.File(filePath);
  await file.create();
  io.RandomAccessFile randomAccessFile = await file.open(mode: io.FileMode.write);

  MaterialRepository()
      .apiProvider
      .downloadFile(Stream.value(DownloadRequest(
          entityId: hiveFile.entityId,
          entityType: EntityType.valueOf(hiveFile.entityType!),
          filenames: [hiveFile.filename!].toList())))
      .then((responseStream) {
    responseStream.listen((DownloadResponse fileData) async {
      //print("DATA Received: $fileData");
      if (fileData.hasMetaData()) {
        print("META DATA: ${fileData.metaData}");
      } else if (fileData.hasChunk()) {
        //print("FILE CHUNK:");
        randomAccessFile.writeFromSync(fileData.chunk);
      }
    }, onDone: () {
      print("FILE Transfer DONE");
      randomAccessFile.closeSync();
      onDone(file.path);
    }, onError: (error, stackTrace) {
      print("FILE Transfer ERROR:: $error");
      onError(error, stackTrace);
    }, cancelOnError: true);
  }).onError(onError);
}

// TODO:
Future<String> getFilePath(String filename) async {
  /*List<Directory>? directories =
      await getExternalStorageDirectories(type: StorageDirectory.downloads);
  if (directories == null || directories.length == 0) {
    return null;
  }
  String appDocumentsPath = directories.first.path;

  String filePath = '$appDocumentsPath/$filename';
  */

  final appDocumentsPath = await getApplicationDocumentsDirectory();
  String filePath = '${appDocumentsPath.path}/$filename';
  print("FILE PATH: $filePath");
  return filePath;
}

uploadMaterial(HiveFile hiveFile, StreamController<FileData> controller,
  { required DoneCallback<FileMetaData> onDone, required ErrorCallback onError }) async {
  String entityId = hiveFile.entityId!;
  io.File file = io.File(hiveFile.filepath!);
  FileMetaData metaData = FileMetaData(
    entityId: entityId,
    filename: file.path.split("/").last,
    entityType: EntityType.MATERIAL,
  );
  FileData fileMetaData = FileData(metaData: metaData);

  /*ResponseStream<UploadStatus> responseStream =
      client.upload(controller.stream);*/

  MaterialRepository()
      .apiProvider
      .uploadFile(controller.stream)
      .then((responseStream) {
    responseStream.listen((UploadStatus uploadStatus) {
      //print("File UploadStatus: $uploadStatus");
      if (uploadStatus.status == UploadStatus_Status.OK) {
        onDone(uploadStatus.fileMetaData);
      } else if (uploadStatus.status == UploadStatus_Status.FAILED) {
        //controller.done;
      }
    });
  }).onError(onError);

  controller.add(fileMetaData);

  Stream<List<int>> inputStream = file.openRead();
  inputStream.listen((event) {
    controller.add(FileData(chunk: event));
  }, onDone: () {
    print("DONE");
    //controller.sink.add(fileMetaData);
    controller.close();
  }, onError: (error) {
    print("ERROR: $error");
  });

  /*final semicolon = ';'.codeUnitAt(0);
  RandomAccessFile randomAccessFile = file.openSync(mode: FileMode.read);
  //final result = <int>[];
  while (true) {
    final byte = await randomAccessFile.readByte();
    //result.add(byte);
    controller.sink.add(FileData(chunk: [byte].toList()));
    if (byte == semicolon) {
      //print(String.fromCharCodes(result));
      controller.sink.add(fileMetaData);
      //controller.sink.done;
      //controller.close();
      await randomAccessFile.close();
      break;
    }
  }*/
}

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

  Future<void> createWithContent(List<int> buffer) async {
     _ioFile.create(recursive: true);

    final _randomAccessFile =
        await _ioFile.open(mode: io.FileMode.write);

    _randomAccessFile.writeFromSync(buffer);

    _randomAccessFile.closeSync();
  }
}
