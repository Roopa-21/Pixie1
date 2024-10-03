import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;
  String? _verificationId;

  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<AuthPhoneSignInRequested>(_onPhoneSignInRequested);
    on<AuthPhoneVerificationRequested>(_onPhoneVerificationRequested);
    on<AuthEmailSignInRequested>(_onEmailSignInRequested);
    on<AuthEmailSignUpRequested>(_onEmailSignUpRequested);
    on<AuthLogOutRequested>(_onLogOutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthCheckAuthState>(
        _onCheckAuthState); // New handler for auth state check
  }

  // Listen to Firebase auth state changes asynchronously
  Future<void> _onCheckAuthState(
      AuthCheckAuthState event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Emit loading state initially
    try {
      // Listening to Firebase auth state changes
      _firebaseAuth.authStateChanges().listen((User? user) {
        if (emit.isDone) return; // Check if the emit is done before proceeding

        if (user != null) {
          emit(AuthAuthenticated(userId: user.uid));
        } else {
          emit(AuthUnauthenticated());
        }
      });
    } catch (e) {
      if (!emit.isDone) {
        emit(AuthError(
            message: 'Error checking authentication state: ${e.toString()}'));
      }
    }
  }

  // Handle phone number sign-in (sending OTP)
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
          _verificationId = verificationId;
          emit(AuthPhoneVerificationCodeSentState(
              verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle OTP verification after the code is sent
  Future<void> _onPhoneVerificationRequested(
      AuthPhoneVerificationRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      if (_verificationId == null) {
        emit(AuthError(message: 'Verification ID is null.'));
        return;
      }

      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: event.otpCode,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        emit(AuthAuthenticated(userId: userCredential.user!.uid));
      } else {
        emit(AuthError(message: 'User not found after verification.'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // Handle email sign-in
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

  // Handle email sign-up
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

  // Handle log out
  Future<void> _onLogOutRequested(
      AuthLogOutRequested event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut();
    emit(AuthUnauthenticated());
  }

  // Check current authentication status
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
