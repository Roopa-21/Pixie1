import 'package:go_router/go_router.dart';
import 'package:pixieapp/error%20page/error_page.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/pages/createStory/createStory_page.dart';
import 'package:pixieapp/pages/home/home_page.dart';

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
      builder: (context, state) => const AddCharacter(),
    ),
  ],
  errorBuilder: (context, state) => const ErrorPage(),
);
