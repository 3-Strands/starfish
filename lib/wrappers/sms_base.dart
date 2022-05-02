import 'package:starfish/models/invite_contact.dart';

class SMS {
  static const canSendMessage = false;
  static send(String message, String phoneNumber) async {
    throw Exception('Cannot send SMS message');
  }
}

Future<List<InviteContact>> getAllContacts() => Future.value([]);

Future<bool> hasContactAccess({bool shouldAskIfUnknown = false}) => Future.value(false);
Future<bool> canRequestContactAccess() => Future.value(false);
