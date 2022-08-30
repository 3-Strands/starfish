// import 'package:grpc/grpc_or_grpcweb.dart';
// import 'package:starfish/db/hive_user.dart';
// import 'package:starfish/db/providers/user_provider.dart';
// import 'package:starfish/src/generated/starfish.pb.dart';
// import 'package:starfish/utils/services/api_provider.dart';

// class UserRepository {
//   final dbProvider = UserProvider();
//   // final apiProvider = ApiProvider();

//   // Future<AuthenticateResponse> authenticate(String jwtToken, String userName) =>
//   //     apiProvider.authenticate(jwtToken, userName);

//   // Future<ResponseStream<User>> getUsers() => apiProvider.getUsers();

//   /*Future<CreateUpdateUserResponse> createUpdateUsers(
//           User user, List<String> fieldMaskPaths) =>
//       apiProvider.createUpdateUsers(user, fieldMaskPaths);*/

//   // Future<ResponseStream<CreateUpdateUserResponse>> createUpdateUsers(
//   //         Stream<CreateUpdateUserRequest> request) =>
//   //     apiProvider.createUpdateUsersWithStream(request);

//   Future<List<HiveUser>> getUsersFromDB() => dbProvider.getUsers();

//   Future<void> createUpdateUserInDB(HiveUser user) =>
//       dbProvider.createUpdateUser(user);

//   /*Future<void> deleteUserFromDB(HiveUser user) =>
//       dbProvider.deleteUserFromDB(user);*/
// }
