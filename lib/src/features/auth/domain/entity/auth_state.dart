class AuthState {
  final String userId;
  final String userEmail;
  final String sessionId;

  AuthState({
    required this.userId,
    required this.sessionId,
    required this.userEmail,
  });
}
