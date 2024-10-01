abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String userId;

  AuthAuthenticated({required this.userId});
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

class AuthPhoneVerificationCodeSentState extends AuthState {
  final String verificationId;

  AuthPhoneVerificationCodeSentState({required this.verificationId});
}

class AuthPhoneVerificationCompleted extends AuthState {
  final String userId;

  AuthPhoneVerificationCompleted({required this.userId});
}
