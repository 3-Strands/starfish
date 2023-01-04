import 'dart:io';

import '_fs.dart';

Future<void> main() async {
  goToRoot();
  final results = await Future.wait([
    runProto('file_transfer'),
    runProto('error_handling'),
    runProto('starfish'),
  ]);

  for (final result in results) {
    if (result.exitCode != 0) {
      print(result.stderr);
    }
  }
}

Future<ProcessResult> runProto(String proto) => Process.run('protoc', [
      '--dart_out=grpc:lib/src/generated',
      '--proto_path=lib/src/generated/google',
      '-Iprotos',
      'protos/$proto.proto',
    ]);
