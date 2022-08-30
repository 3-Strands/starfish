// import 'package:rxdart/subjects.dart';
// import 'package:starfish/db/hive_user.dart';
// import 'package:starfish/repository/user_repository.dart';

// class DeprecatedUserBloc extends Object {
//   final UserRepository repository = UserRepository();
//   late BehaviorSubject<List<HiveUser>> _users;

//   DeprecatedUserBloc() {
//     //initializes the subject with element already
//     _users = new BehaviorSubject<List<HiveUser>>();
//   }

//   Future<void> createUpdateUser(HiveUser user) async {
//     return repository.createUpdateUserInDB(user);
//   }
// }
