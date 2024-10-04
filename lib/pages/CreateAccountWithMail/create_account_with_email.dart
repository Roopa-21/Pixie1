import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/blocs/Auth/auth_bloc.dart';
import 'package:pixieapp/blocs/Auth/auth_event.dart';
import 'package:pixieapp/blocs/Auth/auth_state.dart';
import 'package:pixieapp/widgets/loading_widget.dart';

class CreateAccountWithEmail extends StatefulWidget {
  const CreateAccountWithEmail({super.key});

  @override
  State<CreateAccountWithEmail> createState() => _CreateAccountWithEmailState();
}

class _CreateAccountWithEmailState extends State<CreateAccountWithEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
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
            context.push('/HomePage');
          } else if (state is AuthError) {
            context.pop();
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/createaccountsmily.png'),
                    Text(
                      'Create an account',
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
                    TextFormField(
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
                      validator: _validateEmail,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      cursorColor: AppColors.kpurple,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: " Create a password",
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
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;

                            context.read<AuthBloc>().add(
                                  AuthEmailSignUpRequested(
                                    email: email,
                                    password: password,
                                  ),
                                );
                          }
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
                      child: InkWell(
                        onTap: () => context.pop(),
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
                              Text(
                                "Sign Up with Mobile number",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.backgrountdarkpurple),
                              ),
                              const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        onTap: () => context
                            .read<AuthBloc>()
                            .add(AuthGoogleSignInRequested()),
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
                                        "assets/images/googleimg.png")),
                              ),
                              Text(
                                "Login with Google",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.backgrountdarkpurple),
                              ),
                              const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
