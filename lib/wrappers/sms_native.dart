import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_number/phone_number.dart';
import 'package:starfish/db/hive_user.dart';
import 'package:starfish/models/invite_contact.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/platform_native.dart';
import 'package:telephony/telephony.dart';
import 'package:contacts_service/contacts_service.dart';

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
  final contactList = await ContactsService.getContacts(
    withThumbnails: false,
    photoHighResolution: false,
  );
  List<HiveUser> contactsWithNumber = [];

  await Future.wait(contactList.map((contact) async {
    final phones = contact.phones;
    if (phones == null) {
      return contactsWithNumber;
    }

    phones.forEach((element) async {
      final rawNumber = element.value;
      if (rawNumber != null) {
        var dialCode, phoneNumber;
        try {
          final parsedNumber =
              await PhoneNumberUtil().parse(rawNumber, regionCode: null);
          dialCode = parsedNumber.countryCode;
          phoneNumber = parsedNumber.nationalNumber;
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
      }
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
