import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/createaccountbackground.png')),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
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
                    const TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: " Mobile number",
                        hintStyle: TextStyle(
                            color: AppColors.textColorblue,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            strokeAlign: 5,
                            color: AppColors.textpurplelite,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textpurplelite,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textpurplelite,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("OR"),
                    const SizedBox(
                      height: 10,
                    ),
                    const TextField(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: " Email address",
                        hintStyle: TextStyle(
                            color: AppColors.textColorblue,
                            fontWeight: FontWeight.w400),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            strokeAlign: 5,
                            color: AppColors.textpurplelite,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textpurplelite,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.textpurplelite,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/HomePage');
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // foregroundColor: const Color.fromARGB(20, 120, 128, 51),
                          backgroundColor: const Color.fromARGB(
                              48, 105, 105, 105), // Text (foreground) color
                        ),
                        child: Text("Register via email",
                            style: theme.textTheme.bodyMedium!.copyWith(
                                color: AppColors.textColorWhite,
                                fontSize: 17,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'We will send an email to verify your account.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium!.copyWith(),
                    ),
                    const SizedBox(height: 20),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.kwhiteColor,
                            borderRadius: BorderRadius.circular(12)),
                        width: MediaQuery.of(context).size.width * .8,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/googleimg.png"),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Login with Google",
                                  style: theme.textTheme.bodyMedium,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
