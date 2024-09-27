import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';

class CreateAccountWithEmail extends StatefulWidget {
  const CreateAccountWithEmail({super.key});

  @override
  State<CreateAccountWithEmail> createState() => _CreateAccountWithEmailState();
}

class _CreateAccountWithEmailState extends State<CreateAccountWithEmail> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/createaccountbackground.png'),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
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
                const TextField(
                  autofocus: true,
                  decoration: InputDecoration(
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
                          color: Color.fromARGB(130, 152, 92, 221), width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                const TextField(
                  autofocus: true,
                  decoration: InputDecoration(
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
                          color: Color.fromARGB(130, 152, 92, 221), width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/OtpVerification');
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
                              child:
                                  Image.asset("assets/images/smartphone.png")),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          child: Text(
                            "Sign Up with Mobile number",
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
    );
  }
}
