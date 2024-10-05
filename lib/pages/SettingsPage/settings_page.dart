import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_bloc.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_event.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_state.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/widgets/navbar.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xfff9f3cd),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            // Navigate to the login or onboarding page when the user is logged out
            context.go('/Loginpage'); // Or whichever page you want after logout
          }
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffead4f9),
                Color(0xfff7f1d1),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Settings",
                    style:
                        theme.textTheme.headlineMedium!.copyWith(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      profilelistCard(
                        title: 'Profile',
                        ontap: () {},
                        icon_path: 'assets/images/profile.svg',
                        theme: theme,
                      ),
                      profilelistCard(
                        title: 'Feedback',
                        ontap: () {},
                        icon_path: 'assets/images/feedbacak.svg',
                        theme: theme,
                      ),
                      profilelistCard(
                        title: 'About',
                        ontap: () {},
                        icon_path: 'assets/images/about.svg',
                        theme: theme,
                      ),
                      profilelistCard(
                        title: 'Logout',
                        ontap: () {
                          context.read<AuthBloc>().add(AuthLogOutRequested());
                          context.read<AddCharacterBloc>().add(Pagechange(0));
                        },
                        icon_path: 'assets/images/logout.svg',
                        theme: theme,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget profilelistCard({
    required ThemeData theme,
    required String title,
    required String icon_path,
    required void Function() ontap,
  }) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Row(
            children: [
              SvgPicture.asset(
                icon_path,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
