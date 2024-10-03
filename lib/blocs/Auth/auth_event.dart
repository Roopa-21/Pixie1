abstract class AuthEvent {}

class AuthPhoneSignInRequested extends AuthEvent {
  final String phoneNumber;

  AuthPhoneSignInRequested({required this.phoneNumber});
}

class AuthPhoneVerificationRequested extends AuthEvent {
  final String verificationId;
  final String otpCode;

  AuthPhoneVerificationRequested({
    required this.verificationId,
    required this.otpCode,
  });
}

class AuthEmailSignInRequested extends AuthEvent {
  final String email;
  final String password;

  AuthEmailSignInRequested({required this.email, required this.password});
}

class AuthEmailSignUpRequested extends AuthEvent {
  final String email;
  final String password;

  AuthEmailSignUpRequested({required this.email, required this.password});
}

class AuthLogOutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

class AuthCheckAuthState
    extends AuthEvent {}  // New event to check auth state on app start