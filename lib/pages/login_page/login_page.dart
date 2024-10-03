import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/blocs/Auth/auth_bloc.dart';
import 'package:pixieapp/blocs/Auth/auth_event.dart';
import 'package:pixieapp/blocs/Auth/auth_state.dart';
import 'package:pixieapp/const/loading_widget.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(child: LoadingWidget());
              },
            );
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pop();
            context.go('/HomePage');
          } else if (state is AuthError) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Container(
          width: deviceWidth,
          height: deviceHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/createaccountbackground.png'),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/createaccountsmily.png'),
                  Text(
                    'Login to your account',
                    style: theme.textTheme.displayLarge!
                        .copyWith(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Your profile and created stories will be saved to your account.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    cursorColor: AppColors.kpurple,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: " Enter your email ",
                      hintStyle: TextStyle(
                          color: AppColors.textColorblue,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          strokeAlign: 5,
                          color: Color.fromARGB(130, 152, 92, 221),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(130, 152, 92, 221),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(130, 152, 92, 221),
                            width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    cursorColor: AppColors.kpurple,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: " Enter your password",
                      hintStyle: TextStyle(
                          color: AppColors.textColorblue,
                          fontWeight: FontWeight.w400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          strokeAlign: 5,
                          color: Color.fromARGB(130, 152, 92, 221),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(130, 152, 92, 221),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(130, 152, 92, 221),
                            width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        context.read<AuthBloc>().add(
                              AuthEmailSignInRequested(
                                email: email,
                                password: password,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.backgrountdarkpurple,
                      ),
                      child: Text(
                        "Next",
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Or',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      width: MediaQuery.of(context).size.width * .8,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                                width: 40,
                                child: Image.asset(
                                    "assets/images/smartphone.png")),
                          ),
                          TextButton(
                            onPressed: () => context.push('/CreateAccount'),
                            child: Text(
                              "Login with Mobile number",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.backgrountdarkpurple),
                            ),
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      width: MediaQuery.of(context).size.width * .8,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                                width: 40,
                                child:
                                    Image.asset("assets/images/googleimg.png")),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Login with Google",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.backgrountdarkpurple),
                            ),
                          ),
                          const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}