import 'package:grpc/grpc_web.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/db/providers/user_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class UserRepository {
  final dbProvider = UserProvider();
  final apiProvider = ApiProvider();

  Future<ResponseStream<User>> getUsers() => apiProvider.getUsers();

  Future<List<HiveUser>> getUsersFromDB() => dbProvider.getUsers();
}
