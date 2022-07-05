import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:starfish/db/hive_user.dart';
import 'package:starfish/models/invite_contact.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/platform_native.dart';
import 'package:telephony/telephony.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';
//import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class SMS {
  static bool? _permissionGranted;

  static get canSendMessage => Platform.isAndroid;

  static send(String message, String phoneNumber) async {
    if (_permissionGranted == null) {
      // We haven't yet checked. Get permission!
      _permissionGranted =
          await Telephony.instance.requestSmsPermissions ?? false;
    }
    if (!_permissionGranted!) {
      return false;
    }

    await Telephony.instance.sendSms(
        to: phoneNumber,
        message: message,
        statusListener: (sendStatus) {
          debugPrint(
              'Status of Invitation Send to [$phoneNumber]: $sendStatus');
        },
        isMultipart: true);

    return true;
  }
}

Future<List<HiveUser>> getAllContacts() async {
  final contactList = await FlutterContacts.getContacts(
    withThumbnail: false,
    withPhoto: false,
    withProperties: true,
  );
  List<HiveUser> contactsWithNumber = [];

  await Future.wait(contactList.map((contact) async {
    final phones = contact.phones;
    if (phones.isEmpty) {
      return contactsWithNumber;
    }

    phones.forEach((Phone element) async {
      final rawNumber = element.number;
      var dialCode, phoneNumber;
      try {
        final parsedNumber = PhoneNumber.fromRaw(rawNumber);
        dialCode = parsedNumber.countryCode;
        phoneNumber = parsedNumber.nsn;
      } catch (e) {
        dialCode = null;
        phoneNumber = rawNumber.replaceAll(RegExp("[-()\\s]"), "");
      }
      contactsWithNumber.add(HiveUser(
          id: UuidGenerator.uuid(),
          diallingCode: dialCode,
          phone: phoneNumber,
          name: contact.displayName,
          //givenName: contact.givenName,
          status: User_Status.STATUS_UNSPECIFIED.value));
    });
  }));

  return contactsWithNumber;
}

Future<bool> hasContactAccess({bool shouldAskIfUnknown = false}) async {
  var permission = await Permission.contacts.status;
  if (shouldAskIfUnknown &&
      !permission.isGranted &&
      !permission.isPermanentlyDenied) {
    permission = await Permission.contacts.request();
  }
  return permission.isGranted;
}

Future<bool> canRequestContactAccess() =>
    Permission.contacts.status.isPermanentlyDenied;
