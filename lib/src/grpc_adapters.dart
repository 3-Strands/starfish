import 'package:hive/hive.dart';
import 'package:protobuf/protobuf.dart';
import 'package:starfish/src/generated/starfish.pb.dart';

part 'grpc_adapters.g.dart';

abstract class _GrpcAdapter<Model extends GeneratedMessage>
    extends TypeAdapter<Model> {
  Model create();

  @override
  Model read(BinaryReader reader) {
    return create()..mergeFromBuffer(reader.readByteList());
  }

  @override
  void write(BinaryWriter writer, Model obj) {
    writer.writeByteList(obj.writeToBuffer());
  }
}
