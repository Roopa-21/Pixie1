import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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
    on<TogglePasswordVisibilityEvent>(_onAuthShowPassword);
    // Handle phone number sign-in
    on<SendOtpToPhoneEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
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
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(event.credential);

        String userId = userCredential.user!.uid;
        String? phone = userCredential.user!.phoneNumber;
        String? displayName = userCredential.user!.displayName;
        String? photoURL = userCredential.user!.photoURL;
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'phone': phone,
          'createdAt': DateTime.now(),
          'userId': userId,
          'displayName': displayName,
          'photoURL': photoURL,
          'newUser': true
        });
        emit(SignUpScreenOtpSuccessState());
        // emit(LoginScreenLoadedState());
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
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      // Get user id
      String userId = userCredential.user!.uid;
      print(userId);

      // Create user collection in Firestore

      await FirebaseFirestore.instance.collection('users').doc('userId').set({
        'email': event.email,
        'createdAt': DateTime.now(),
        'userId': userId,
      });
      print('creted');
      // Emit authenticated state after successful sign-up and Firestore operation
      emit(AuthAuthenticated(userId: userId));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequested(
      AuthGoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Emit loading state

    try {
      // Create GoogleSignIn instance
      final GoogleSignIn googleSignIn = GoogleSignIn();

      // Try signing in
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // If googleUser is null, sign-in was aborted
      if (googleUser == null) {
        emit(AuthError(message: 'Google sign-in aborted.'));
        return; // Stop execution here
      }

      // Obtain authentication details from the googleUser
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // If accessToken or idToken is null, something went wrong
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        emit(
            AuthError(message: 'Google authentication failed: missing token.'));
        return; // Stop execution here
      }

      // Create an AuthCredential from googleAuth
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential to Firebase
      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Get the user ID and other user details
      String userId = userCredential.user!.uid;
      String? email = userCredential.user!.email;
      String? displayName = userCredential.user!.displayName;
      String? photoURL = userCredential.user!.photoURL;

      // Check if the user already exists in Firestore
      // DocumentSnapshot userDoc = await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .get();

      // If the user doesn't exist, create a new document
      // if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': 'email',
        'displayName': 'displayName',
        'photoURL': 'photoURL',
        'createdAt': 'Timestamp.now',
        'userId': 'userId',
      });
      // }

      // Emit the Authenticated state with the user's UID
      emit(AuthAuthenticated(userId: userId));
    } on PlatformException catch (e) {
      print(e);
      // Emit AuthError to stop loading and show the error
      emit(AuthError(message: 'PlatformException: ${e.message}'));
    } catch (e) {
      // General error handling
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

  Future<void> _onAuthShowPassword(
      TogglePasswordVisibilityEvent event, Emitter<AuthState> emit) async {
    final currentVisibility = state is PasswordVisibilityState
        ? (state as PasswordVisibilityState).isPasswordVisible
        : false;
    emit(PasswordVisibilityState(!currentVisibility));
  }
}
