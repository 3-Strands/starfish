import 'package:contacts_service/contacts_service.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/src/generated/starfish.pbenum.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:uuid/uuid.dart';

class InviteContact {
  Contact contact;
  GroupUser_Role role;
  bool isSelected;

  InviteContact(
      {required this.contact,
      this.role = GroupUser_Role.LEARNER,
      this.isSelected = false});

  HiveUser createHiveUser() {
    return HiveUser(
      id: UuidGenerator.uuid(),
      name: this.contact.displayName,
      phone: this.contact.phones != null && this.contact.phones!.length > 0
          ? this.contact.phones!.first.value!.replaceAll("[-() ]", "")
          : '',
    );
  }
}
