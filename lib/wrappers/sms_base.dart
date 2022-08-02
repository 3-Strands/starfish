import 'package:starfish/src/grpc_extensions.dart';

class SMS {
  static const canSendMessage = false;
  static send(String message, String phoneNumber) async {
    throw Exception('Cannot send SMS message');
  }
}

Future<List<User>> getAllContacts() => Future.value([]);

Future<bool> hasContactAccess({bool shouldAskIfUnknown = false}) =>
    Future.value(false);
const mightBeAbleToAccessContacts = false;
