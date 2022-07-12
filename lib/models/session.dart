import 'tokens.dart';
import 'user.dart';

class Session {
  final Tokens tokens;
  final AppUser user;
  final bool needsProfileCreation;

  const Session(this.tokens, this.user, {this.needsProfileCreation = false});
}