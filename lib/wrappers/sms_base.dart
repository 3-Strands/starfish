import 'package:starfish/src/grpc_extensions.dart';

class SMS {
  static const canSendMessage = false;
  static Future<bool> send(String message, String phoneNumber) async {
    // throw Exception('Cannot send SMS message');
    print('Message: $message');
    print('Sent to: $phoneNumber');
    return false;
  }
}

Future<List<User>> getAllContacts() => Future.value([]);

Future<bool> hasContactAccess({bool shouldAskIfUnknown = false}) =>
    Future.value(false);
const mightBeAbleToAccessContacts = false;
