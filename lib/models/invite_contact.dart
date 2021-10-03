import 'package:contacts_service/contacts_service.dart';
import 'package:starfish/src/generated/starfish.pbenum.dart';

class InviteContact {
  Contact contact;
  GroupUser_Role role;
  bool isSelected;

  InviteContact(
      {required this.contact,
      this.role = GroupUser_Role.LEARNER,
      this.isSelected = false});
}
