// import 'package:hive/hive.dart';
// import 'package:collection/collection.dart';
// import 'package:starfish/db/hive_database.dart';
// import 'package:starfish/db/hive_user.dart';

// class UserProvider {
//   late Box<HiveUser> _userBox;

//   UserProvider() {
//     _userBox = Hive.box<HiveUser>(HiveDatabase.USER_BOX);
//   }

//   Future<List<HiveUser>> getUsers() async {
//     return _userBox.values.toList();
//   }

//   HiveUser? getUserById(String userId) {
//     return _userBox.values.firstWhereOrNull((element) => element.id == userId);
//   }

//   List<HiveUser> getLocalUserByPhone(String diallingCode, String phone) {
//     return _userBox.values
//         .where((element) =>
//             element.diallingCode == diallingCode &&
//             element.phone == phone &&
//             element.isNew)
//         .toList();
//   }

//   Future<void> createUpdateUser(HiveUser user) async {
//     int _currentIndex = -1;
//     _userBox.values.toList().asMap().forEach((key, hiveUser) {
//       if (hiveUser.id == user.id) {
//         _currentIndex = key;
//       }
//     });

//     if (_currentIndex > -1) {
//       return _userBox.putAt(_currentIndex, user);
//     } else {
//       _userBox.add(user);
//     }
//   }

//   void deleteUser(HiveUser user) {
//     _userBox.values
//         .where((element) =>
//             element.diallingCode == user.diallingCode &&
//             element.phone == user.phone)
//         .forEach((_hiveUser) {
//       _hiveUser.delete();
//     });
//   }

//   String getName(String userId) {
//     HiveUser? _user =
//         _userBox.values.firstWhereOrNull((element) => element.id == userId);
//     return _user != null ? _user.name ?? userId : userId;
//   }

//   String getPhone(String userId) {
//     HiveUser? _user =
//         _userBox.values.firstWhereOrNull((element) => element.id == userId);
//     return _user != null ? _user.phone ?? '' : '';
//   }

//   String getDiallingCode(String userId) {
//     HiveUser? _user =
//         _userBox.values.firstWhereOrNull((element) => element.id == userId);
//     return _user != null ? _user.diallingCode ?? '' : '';
//   }

//   String getPhoneWithDialingCode(String userId) {
//     HiveUser? _user =
//         _userBox.values.firstWhereOrNull((element) => element.id == userId);
//     return _user != null ? _user.phoneWithDialingCode : '';
//   }

//   Future<void> updateLocalUser(HiveUser localUser, HiveUser _remoteUser) async {
//     int _currentIndex = -1;
//     _userBox.values.toList().asMap().forEach((key, hiveUser) {
//       if (hiveUser.id == localUser.id) {
//         _currentIndex = key;
//       }
//     });

//     if (_currentIndex > -1) {
//       _userBox
//           .deleteAt(_currentIndex)
//           .then((value) => _userBox.add(_remoteUser));
//     }
//   }
// }
