abstract class AuthEvent {}

class AuthPhoneSignInRequested extends AuthEvent {
  final String phoneNumber;
  final String otpCode;

  AuthPhoneSignInRequested({required this.phoneNumber, required this.otpCode});
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

class AuthPhoneVerificationCodeSent extends AuthEvent {
  final String verificationId;

  AuthPhoneVerificationCodeSent({required this.verificationId});
}

class AuthLogOutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}
