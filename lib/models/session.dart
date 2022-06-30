class Session {
  final String userId;
  final String accessToken;
  final String refreshToken;

  Session({required this.userId, required this.accessToken, required this.refreshToken});
}
