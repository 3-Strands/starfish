import 'package:starfish/models/tokens.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

extension TokensFromAuthenticationResponse on Future<AuthenticateResponse> {
  Future<Tokens> toTokens() => then((response) => Tokens(
    accessToken: response.userToken,
    refreshToken: response.refreshToken,
    userId: response.userId,
  ));
}

class GrpcAuthenticationApi {
  final StarfishClient client;

  GrpcAuthenticationApi({
    required this.client,
  });

  Future<Tokens> authenticate(
      String jwtToken, String userName) {
    var request =
        AuthenticateRequest(firebaseJwt: jwtToken, userName: userName);
    return client.authenticate(request).toTokens();
  }

  Future<Tokens> refreshTokens(Tokens tokens) {
    final request = RefreshSessionRequest(
      userId: tokens.userId,
      refreshToken: tokens.refreshToken,
    );
    return client.refreshTokens(request).toTokens();
  }
}
