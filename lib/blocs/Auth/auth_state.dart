// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AuthState {}

class AuthInitial extends AuthState {}


class LoginScreenLoadingState extends AuthState {}

class LoginScreenInitialState extends AuthState {}

class LoginScreenLoadedState extends AuthState {}

class LoginScreenErrorState extends AuthState {
  String error;
  LoginScreenErrorState({
    required this.error,
  });
}

class PhoneAuthCodeSentSuccess extends AuthState {
  final String verificationId;

  PhoneAuthCodeSentSuccess({required this.verificationId});
}

class SignUpScreenOtpSuccessState extends AuthState{
  
}
