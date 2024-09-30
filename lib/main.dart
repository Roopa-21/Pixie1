import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Navbar_Bloc/navbar_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/const/textstyle.dart';
import 'package:pixieapp/firebase_options.dart';
import 'package:pixieapp/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavBarBloc>(
          create: (_) => NavBarBloc(),
        ),
        BlocProvider<AddCharacterBloc>(
          create: (_) => AddCharacterBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Pixie',
        debugShowCheckedModeBanner: false,
        theme: appTheme(context),
        routerConfig: router,
      ),
    );
  }
}
