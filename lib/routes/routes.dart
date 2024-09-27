import 'package:go_router/go_router.dart';
import 'package:pixieapp/pages/AllStories/all_stories.dart';
import 'package:pixieapp/pages/CreateAccountWithMail/create_account_with_email.dart';
import 'package:pixieapp/pages/MyStories/mystories.dart';
import 'package:pixieapp/pages/Otp_Verification/otp_verification.dart';
import 'package:pixieapp/pages/SetPeofileLanding/set_profile_landing.dart';
import 'package:pixieapp/pages/error%20page/error_page.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/pages/CreateAccount/createaccount.dart';
import 'package:pixieapp/pages/audioPlay/audioplay_page.dart';
import 'package:pixieapp/pages/createStory/createStory_page.dart';
import 'package:pixieapp/pages/home/home_page.dart';
import 'package:pixieapp/pages/onboardingPages/onboarding_page.dart';
import 'package:pixieapp/pages/storygenerate/storygenerate.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/CreateStoryPage',
      builder: (context, state) => const CreateStoryPage(),
    ),
    GoRoute(
      path: '/AddCharacter',
      // builder: (context, state) => const AddCharacter(),
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
      path: '/StoryGeneratePage',
      builder: (context, state) => const StoryGeneratePage(),
    ),
    GoRoute(
        path: '/HomePage',
        // builder: (context, state) => const HomePage(),
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: HomePage(),
          );
        }),
    GoRoute(
        path: '/MyStories',
        // builder: (context, state) => const MyStories(),
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: MyStories(),
          );
        }),
    GoRoute(
      path: '/AllStories',
      builder: (context, state) => const AllStories(),
    ),
    GoRoute(
      path: '/CreateAccount',
      builder: (context, state) => const CreateAccount(),
    ),
    GoRoute(
      path: '/OtpVerification',
      builder: (context, state) => const OtpVerification(),
    ),
    GoRoute(
      path: '/SetProfileLanding',
      builder: (context, state) => const SetProfileLanding(),
    ),
    GoRoute(
      path: '/CreateAccountWithEmail',
      builder: (context, state) => const CreateAccountWithEmail(),
    ),
  ],
  errorBuilder: (context, state) => const ErrorPage(),
);
