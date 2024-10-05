import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_bloc.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_event.dart';
import 'package:pixieapp/blocs/Navbar_Bloc/navbar_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/introduction/introduction_bloc.dart';
import 'package:pixieapp/firebase_options.dart';
import 'package:pixieapp/repositories/story_repository.dart';
import 'package:pixieapp/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              AuthBloc(FirebaseAuth.instance)..add(AuthCheckAuthState()),
        ),
        BlocProvider<NavBarBloc>(
          create: (_) => NavBarBloc(),
        ),
        BlocProvider<AddCharacterBloc>(
          create: (_) => AddCharacterBloc(),
        ),
        BlocProvider(
  create: (context) => TextBloc(),
    ),
  
        BlocProvider<StoryBloc>(
          create: (_) => StoryBloc(storyRepository: StoryRepository()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Pixie App',
        theme: ThemeData(),
      ),
    );
  }
}
