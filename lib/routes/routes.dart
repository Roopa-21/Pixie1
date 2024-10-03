import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/Auth/auth_bloc.dart';
import 'package:pixieapp/blocs/Auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/pages/AllStories/all_stories.dart';
import 'package:pixieapp/pages/CreateAccount/createaccount.dart';
import 'package:pixieapp/pages/CreateAccountWithMail/create_account_with_email.dart';
import 'package:pixieapp/pages/IntroductionPages/introduction_pages.dart';
import 'package:pixieapp/pages/Library/Library.dart';
import 'package:pixieapp/pages/Otp_Verification/otp_verification.dart';
import 'package:pixieapp/pages/SettingsPage/settings_page.dart';
import 'package:pixieapp/pages/SplashScreen/splash_screen.dart';
import 'package:pixieapp/pages/SplashScreen/story_confirmtion_page.dart';
import 'package:pixieapp/pages/audioPlay/audioplay_page.dart';
import 'package:pixieapp/pages/createStory/createStory_page.dart';
import 'package:pixieapp/pages/error%20page/error_page.dart';
import 'package:pixieapp/pages/home/home_page.dart';
import 'package:pixieapp/pages/login_page/login_page.dart';
import 'package:pixieapp/pages/onboardingPages/onboarding_page.dart';
import 'package:pixieapp/pages/questions_intro_page.dart';
import 'package:pixieapp/pages/storygenerate/storygenerate.dart';

bool isUserAuthenticated(BuildContext context) {
  final authState = context.read<AuthBloc>().state;
  return authState is AuthAuthenticated;
}

bool isAuthStateChecked(BuildContext context) {
  final authState = context.read<AuthBloc>().state;
  return authState
      is! AuthInitial; // Make sure auth state is not in initial state
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        final authState = context.watch<AuthBloc>().state;

        if (authState is AuthInitial) {
          return const SplashScreen(); // Show splash screen while checking auth state
        } else if (authState is AuthAuthenticated) {
          return const HomePage(); // Redirect to home page if authenticated
        } else {
          return const OnboardingPage(); // Redirect to onboarding if not authenticated
        }
      },
    ),
    GoRoute(
      path: '/OtpVerification',
      builder: (context, state) => const OtpVerification(
        verificationId: "",
      ),
    ),
    GoRoute(
      path: '/CreateStoryPage',
      builder: (context, state) => const CreateStoryPage(),
    ),
    GoRoute(
      path: '/AddCharacter',
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: AddCharacter(),
        );
      },
    ),
    GoRoute(
      path: '/AudioplayPage',
      builder: (context, state) => const AudioplayPage(),
    ),
    GoRoute(
      path: '/CreateAccount',
      builder: (context, state) => const CreateAccount(),
    ),
    GoRoute(
      path: '/Loginpage',
      builder: (context, state) => const Loginpage(),
    ),
    GoRoute(
      path: '/CreateAccountWithEmail',
      builder: (context, state) => const CreateAccountWithEmail(),
    ),
    GoRoute(
      path: '/StoryGeneratePage',
      builder: (context, state) => const StoryGeneratePage(),
    ),
    GoRoute(
      path: '/HomePage',
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: HomePage(),
        );
      },
    ),
    GoRoute(
      path: '/Library',
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: Library(),
        );
      },
    ),
    GoRoute(
      path: '/AllStories',
      builder: (context, state) => const AllStories(),
    ),
    GoRoute(
      path: '/questionIntroPage',
      builder: (context, state) => const QuestionsIntroPage(),
    ),
    GoRoute(
      path: '/introductionPages',
      builder: (context, state) => const IntroductionPage(),
    ),
    GoRoute(
      path: '/splashScreen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/storyconfirmationstory',
      builder: (context, state) => const StoryConfirmationPage(),
    ),
    GoRoute(
      path: '/SettingsPage',
      pageBuilder: (context, state) {
        return const NoTransitionPage(
          child: SettingsPage(),
        );
      },
    ),
  ],
  redirect: (context, state) {
    final authState = context.read<AuthBloc>().state;

    // Wait until auth state is checked before redirecting
    if (authState is AuthInitial) {
      return '/'; // Stay on the splash screen until auth is checked
    }

    final loggedIn = authState is AuthAuthenticated;
    final loggingIn =
        state.uri.toString() == '/' || state.uri.toString() == '/Loginpage';

    if (loggedIn && loggingIn) {
      return '/HomePage'; // Redirect to home if logged in and accessing login pages
    }

    final protectedRoutes = [
      '/HomePage',
      '/Library',
      '/SettingsPage',
    ];

    if (!loggedIn && protectedRoutes.contains(state.uri.toString())) {
      return '/'; // Redirect to login if trying to access protected routes without being logged in
    }

    return null; // Proceed with navigation if no redirect is needed
  },
);
