import 'package:contacts_service/contacts_service.dart';

class InviteContact {
  Contact contact;
  bool isSelected;

  InviteContact({required this.contact, this.isSelected = false});
}
