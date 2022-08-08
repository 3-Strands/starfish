import 'package:starfish/src/grpc_extensions.dart';

import 'tokens.dart';

class Session {
  final Tokens tokens;
  final User user;
  final bool needsProfileCreation;

  const Session(this.tokens, this.user, {this.needsProfileCreation = false});
}
