import 'package:starfish/db/hive_group_user.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/src/generated/starfish.pbenum.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';

class InviteContact {
  String? displayName;
  String? givenName;
  // Contact contact;
  GroupUser_Role role;
  bool isSelected;
  String phoneNumber;
  String? dialCode;

  String get id => UuidGenerator.uuid();

  InviteContact(
      {this.displayName,
      this.givenName,
      required this.phoneNumber,
      this.dialCode,
      this.role = GroupUser_Role.LEARNER,
      this.isSelected = false});

  HiveUser createHiveUser() {
    return HiveUser(
      id: id,
      name: this.displayName,
      phone: phoneNumber,
      diallingCode: dialCode,
    );
  }
}
