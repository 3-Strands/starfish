import 'package:starfish/apis/local_storage_api.dart';
import 'package:starfish/models/session.dart';
import 'package:starfish/src/generated/starfish.pbgrpc.dart';

extension SessionFromAuthenticationResponse on Future<AuthenticateResponse> {
  Future<Session> toSession() => then((response) => Session(
    accessToken: response.userToken,
    refreshToken: response.refreshToken,
    userId: response.userId,
  ));
}

class SessionRepository {
  final StarfishClient client;
  final LocalStorageApi localStorageApi;

  SessionRepository({
    required this.client,
    required this.localStorageApi,
  });

  Future<Session> authenticate(
      String jwtToken, String userName) {
    var request =
        AuthenticateRequest(firebaseJwt: jwtToken, userName: userName);
    return client.authenticate(request).toSession();
  }

  Future<void> cacheTokens(Session session) async {
    await Future.wait([
      localStorageApi.setLoginStatus(true),
      localStorageApi.setAccessToken(session.accessToken),
      localStorageApi.setRefreshToken(session.refreshToken),
      localStorageApi.setSessionUserId(session.userId),
    ]);
  }

  Future<void> removeTokens() async {
    await Future.wait([
      localStorageApi.setLoginStatus(false),
      localStorageApi.setAccessToken(''),
      localStorageApi.setRefreshToken(''),
      localStorageApi.setSessionUserId(''),
    ]);
  }

  Future<Session?> retrieveCurrentSession() async {
    final items = await Future.wait<dynamic>([
      localStorageApi.isUserLoggedIn(),
      localStorageApi.getAccessToken(),
      localStorageApi.getRefreshToken(),
      localStorageApi.getSessionUserId(),
    ]);
    final bool isLoggedIn = items[0];
    if (isLoggedIn) {
      return Session(
        accessToken: items[1],
        refreshToken: items[2],
        userId: items[3],
      );
    }
    return null;
  }

  Future<Session> refreshSession(Session session) {
    final request = RefreshSessionRequest(
      userId: session.userId,
      refreshToken: session.refreshToken,
    );
    return client.refreshSession(request).toSession();
  }
}
