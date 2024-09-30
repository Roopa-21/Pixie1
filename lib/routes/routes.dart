import 'package:go_router/go_router.dart';
import 'package:pixieapp/pages/AllStories/all_stories.dart';
import 'package:pixieapp/pages/IntroductionPages/introduction_pages.dart';


import 'package:pixieapp/pages/CreateAccountWithMail/create_account_with_email.dart';

import 'package:pixieapp/pages/Library/Library.dart';
import 'package:pixieapp/pages/SettingsPage/settings_page.dart';
import 'package:pixieapp/pages/SplashScreen/splash_screen.dart';
import 'package:pixieapp/pages/SplashScreen/story_confirmtion_page.dart';
import 'package:pixieapp/pages/error%20page/error_page.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/pages/audioPlay/audioplay_page.dart';
import 'package:pixieapp/pages/createStory/createStory_page.dart';
import 'package:pixieapp/pages/home/home_page.dart';
import 'package:pixieapp/pages/onboardingPages/onboarding_page.dart';
import 'package:pixieapp/pages/questions_intro_page.dart';
import 'package:pixieapp/pages/storygenerate/storygenerate.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',

      builder: (context, state) => const HomePage(),

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
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: HomePage(),
          );
        }),
    GoRoute(
        path: '/Library',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: Library(),
          );
        }),
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

      path: '/g',

      path: '/storyconfirmationstory',

      builder: (context, state) => const StoryConfirmationPage(),
    ),
    GoRoute(
        path: '/SettingsPage',
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: SettingsPage(),
          );
        }),
  ],
  errorBuilder: (context, state) => const ErrorPage(),
);
