import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/services.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/src/generated/starfish.pbenum.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:phone_number/phone_number.dart';

class InviteContact {
  Contact contact;
  GroupUser_Role role;
  bool isSelected;
  String? phoneNumber;
  String? dialCode;

  InviteContact(
      {required this.contact,
      this.role = GroupUser_Role.LEARNER,
      this.isSelected = false}) {
    init();
  }

  HiveUser createHiveUser() {
    return HiveUser(
      id: UuidGenerator.uuid(),
      name: this.contact.displayName,
      phone: phoneNumber,
      diallingCode: dialCode,
    );
  }

  String? phoneNumberString() {
    return this.contact.phones != null && this.contact.phones!.length > 0
        ? this.contact.phones!.first.value!
        : null;
  }

  void init() {
    String? _number = phoneNumberString();
    if (_number == null) {
      dialCode = null;
      phoneNumber = null;
    } else {
      PhoneNumberUtil().parse(_number, regionCode: null).then(
          (PhoneNumber _phoneNumber) {
        dialCode = _phoneNumber.countryCode;
        phoneNumber = _phoneNumber.nationalNumber;
      }, onError: (e) {
        dialCode = null;
        phoneNumber = _number.replaceAll(RegExp("[-()\\s]"), "");
      });
    }
  }
}
