import 'package:uuid/uuid.dart';

class UuidGenerator {
  static String uuid() {
    return Uuid().v4();
  }
}
