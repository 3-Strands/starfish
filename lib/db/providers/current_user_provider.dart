// import 'package:hive/hive.dart';
// import 'package:collection/collection.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_user.dart';
// import 'package:starfish/models/user.dart';

// class CurrentUserProvider {
//   late Box<AppUser> _currentUserBox;

//   CurrentUserProvider() {
//     _currentUserBox = Hive.box<AppUser>(HiveDatabase.CURRENT_USER_BOX);
//   }

//   Future<AppUser> getUser() async {
//     return _currentUserBox.values.first;
//   }

//   @Deprecated("Use 'getCurrentUserSync' instead")
//   AppUser getUserSync() {
//     return _currentUserBox.values.first;
//   }

//   AppUser? getCurrentUserSync() {
//     return _currentUserBox.values.firstOrNull;
//   }

//   bool hasCurrentUser() {
//     return _currentUserBox.values.firstOrNull != null;
//   }

//   /*Future<int> updateUser(AppUser user) async {
//     return _currentUserBox.add(user);
//   }*/

//   @Deprecated("Use 'createUpdate' instead")
//   void updateUser(AppUser _AppUser) {
//     _currentUserBox.putAt(0, _AppUser);
//   }

//   Future<void> createUpdate(AppUser _AppUser) {
//     return _currentUserBox.isEmpty
//         ? _currentUserBox.add(_AppUser)
//         : _currentUserBox.putAt(0, _AppUser);
//   }
// }

// // extension CurrentUserProviderExt on CurrentUserProvider {
// //   HiveUser get user {
// //     return HiveUser.fromCurrentUser(_currentUserBox.values.first);
// //   }
// // }
