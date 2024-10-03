import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}



class SendOtpToPhoneEvent extends AuthEvent {
  final String phoneNumber;


  SendOtpToPhoneEvent({required this.phoneNumber});


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

class OnPhoneOtpSend extends AuthEvent {
  final String verificationId;
  final int token;

  OnPhoneOtpSend({required this.verificationId, required this.token});
}

class VerifySentOtp extends AuthEvent {
  final String otpCode;
  final String verificationId;

  VerifySentOtp({required this.otpCode, required this.verificationId});
}


class OnPhoneAuthErrorEvent extends AuthEvent {
  final String error;

  OnPhoneAuthErrorEvent({required this.error});
}

class OnPhoneAuthVerificationCompletedEvent extends AuthEvent {
  final AuthCredential credential;

  OnPhoneAuthVerificationCompletedEvent({required this.credential});
  
}

class AuthLogOutRequested extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

class AuthCheckAuthState
    extends AuthEvent {}  // New event to check auth state on app start
