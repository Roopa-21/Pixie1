import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixieapp/blocs/Auth/auth_event.dart';
import 'package:pixieapp/blocs/Auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<AuthPhoneSignInRequested>(_onPhoneSignInRequested);
    on<AuthEmailSignInRequested>(_onEmailSignInRequested);
    on<AuthEmailSignUpRequested>(_onEmailSignUpRequested);
    on<AuthLogOutRequested>(_onLogOutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
  }

  Future<void> _onPhoneSignInRequested(
      AuthPhoneSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          try {
            UserCredential userCredential =
                await _firebaseAuth.signInWithCredential(credential);
            if (userCredential.user != null) {
              emit(AuthAuthenticated(userId: userCredential.user!.uid));
            } else {
              emit(AuthError(message: 'User not found after verification.'));
            }
          } catch (e) {
            emit(AuthError(
                message: 'Failed to sign in with credential: ${e.toString()}'));
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthError(
              message: e.message ?? 'Phone number verification failed.'));
        },
        codeSent: (String verificationId, int? resendToken) {
          if (verificationId.isNotEmpty) {
            emit(AuthPhoneVerificationCodeSentState(
                verificationId: verificationId));
          } else {
            emit(AuthError(message: "Failed to send verification code."));
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(AuthError(
              message: "Verification code auto-retrieval timed out."));
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onEmailSignInRequested(
      AuthEmailSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(userId: userCredential.user!.uid));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onEmailSignUpRequested(
      AuthEmailSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated(userId: userCredential.user!.uid));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onLogOutRequested(
      AuthLogOutRequested event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckStatus(
      AuthCheckStatus event, Emitter<AuthState> emit) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(userId: user.uid));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
