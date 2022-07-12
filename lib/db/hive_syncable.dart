import 'hive_grpc_compatible.dart';

abstract class HiveSyncable<T> implements HiveGrpcCompatible<T> {
  bool get isUpdated;
  bool get isNew;
  bool get isDirty;

  T toGrpcCompatible();

  bool matches(Object other);
}
