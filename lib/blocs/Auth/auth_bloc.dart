import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pixieapp/repositories/authModel.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth;

  String loginResult = '';
  Authmodel authModel = Authmodel();
  UserCredential? userCredential;
  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<AuthEmailSignInRequested>(_onEmailSignInRequested);
    on<AuthEmailSignUpRequested>(_onEmailSignUpRequested);
    on<AuthGoogleSignInRequested>(_onGoogleSignInRequested);
    on<AuthLogOutRequested>(_onLogOutRequested);
    on<AuthCheckStatus>(_onCheckStatus);
    on<AuthCheckAuthState>(_onCheckAuthState);
    // Handle phone number sign-in
    on<SendOtpToPhoneEvent>((event, emit) async {
      emit(LoginScreenLoadingState());

      try {
        await authModel.loginWithPhone(
            phoneNumber: event.phoneNumber,
            verificationCompleted: (PhoneAuthCredential credential) {
              add(OnPhoneAuthVerificationCompletedEvent(
                  credential: credential));
            },
            verificationFailed: (FirebaseAuthException e) {
              add(OnPhoneAuthErrorEvent(error: e.toString()));
            },
            codeSent: (String verificationId, int? refreshToken) {
              add(OnPhoneOtpSend(
                  verificationId: verificationId, token: refreshToken!));
            },
            codeAutoRetrievalTimeout: (String verificatioId) {});
      } catch (e) {
        emit(LoginScreenErrorState(error: e.toString()));
      }
    });

    on<OnPhoneOtpSend>((event, emit) {
      emit(PhoneAuthCodeSentSuccess(verificationId: event.verificationId));
    });

    on<VerifySentOtp>(
      (event, emit) {
        try {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: event.verificationId, smsCode: event.otpCode);
          add(OnPhoneAuthVerificationCompletedEvent(credential: credential));
        } catch (e) {
          emit(LoginScreenErrorState(error: e.toString()));
        }
      },
    );

    on<OnPhoneAuthErrorEvent>((event, emit) {
      emit(LoginScreenErrorState(error: event.error.toString()));
    });
    on<OnPhoneAuthVerificationCompletedEvent>((event, emit) async {
      try {
        await authModel.authentication.signInWithCredential(event.credential);
        emit(SignUpScreenOtpSuccessState());
        emit(LoginScreenLoadedState());
      } catch (e) {
        emit(LoginScreenErrorState(error: e.toString()));
      }
    });
  }

  // Listen to Firebase auth state changes asynchronously
  Future<void> _onCheckAuthState(
      AuthCheckAuthState event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Emit loading state initially
    try {
      // Listening to Firebase auth state changes
      _firebaseAuth.authStateChanges().listen((User? user) {
        if (emit.isDone) return;
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

  // Handle google signin
  Future<void> _onGoogleSignInRequested(
      AuthGoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthError(message: 'Google sign-in aborted.'));
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      emit(AuthAuthenticated(userId: userCredential.user!.uid));
    } catch (e) {
      emit(AuthError(message: 'Google Sign-In Failed: ${e.toString()}'));
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
