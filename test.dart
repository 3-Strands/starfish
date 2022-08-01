import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:starfish/src/grpc_adapters.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:protobuf/protobuf.dart';

extension MaterialExt on Material {
  String get key => id;
}

void main() async {
  // final m = GroupUser();

  // for (final field in m.info_.fieldInfo.values) {
  //   final type = field.type == PbFieldType.OS
  //       ? 'String'
  //       : field.isEnum
  //           ? field.enumValues![0].runtimeType.toString()
  //           : 'dynamic';
  //   print('$type? ${field.name}');
  // }

  // Hive.registerAdapter(MaterialAdapter());

  dynamic item = ['testing'];
  testFn(item);

  // const id = '12345';

  // final material = Material(
  //   id: id,
  //   title: 'My material title',
  // );

  // final box = await Hive.openBox('test', bytes: Uint8List(0));
  // box.put(material.key, material);

  // final m = box.get(id);
  // print(m);
}

void testFn(String test) {
  print(test.length);
}
