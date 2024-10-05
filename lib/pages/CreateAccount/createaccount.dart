import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_bloc.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_event.dart';
import 'package:pixieapp/blocs/Auth_bloc/auth_state.dart';
import 'package:pixieapp/const/Countries.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/loading_widget.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

TextEditingController countrycodetextEditingController =
    TextEditingController();
TextEditingController mobileNumberController = TextEditingController();

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: LoadingWidget());
            },
          );
        }
        if (state is PhoneAuthCodeSentSuccess) {
          print('...++....${state.verificationId}');
          context.go('/OtpVerification/${state.verificationId}');
        } else if (state is AuthError) {
          context.pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/createaccountbackground.png',
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/createaccountsmily.png',
                        width: width * .2,
                      ),
                      Text(
                        'Create an account',
                        style: theme.textTheme.displayLarge!.copyWith(
                            fontSize: 34, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: height * .02),
                      Text(
                        'Your profile and created stories will be saved to your account.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(),
                      ),
                      SizedBox(height: height * .025),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.kwhiteColor,
                            border: Border.all(
                                color: const Color.fromARGB(102, 152, 92, 221)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "Country/Region",
                                style: theme.textTheme.bodySmall!
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                            TypeAheadField<Country>(
                              builder: (context, controller, focusNode) {
                                return TextField(
                                  cursorColor: AppColors.kpurple,
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: AppColors.kgreyColor,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(0, 152, 92, 221),
                                            width: 2.0),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                0, 152, 92, 221)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                0, 152, 92, 221)),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10)),
                                      ),
                                      hintText: '🇮🇳 India (+91)',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400)),
                                );
                              },
                              controller: countrycodetextEditingController,
                              suggestionsCallback: (search) {
                                return countries
                                    .where((country) => country.name
                                        .toLowerCase()
                                        .contains(search.toLowerCase()))
                                    .toList();
                              },
                              itemBuilder: (context, Country country) {
                                return ListTile(
                                    leading: Text(
                                      country.flag,
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          child: Center(
                                            child: Text(
                                              country.code,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        const Text(" -  "),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(country.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                              onSelected: (Country country) {
                                countrycodetextEditingController.text =
                                    "${country.flag}  ${country.code}  -  ${country.name}";
                              },
                            ),
                            const Divider(
                                color: Color.fromARGB(102, 152, 92, 221)),
                            TextField(
                              cursorColor: AppColors.kpurple,
                              controller: mobileNumberController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: " Mobile number",
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    strokeAlign: 5,
                                    color: Color.fromARGB(0, 158, 158, 158),
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(0, 158, 158, 158),
                                  ),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(0, 158, 158, 158),
                                      width: 2.0),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * .06),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            final phoneNumber =
                                mobileNumberController.text.trim();
                            print('.........$phoneNumber');
                            BlocProvider.of<AuthBloc>(context).add(
                              SendOtpToPhoneEvent(
                                phoneNumber: '+91$phoneNumber',

                                //  phoneNumber: "+918547062699",
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
                      SizedBox(height: height * .02),
                      Text(
                        'Or',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium!.copyWith(),
                      ),
                      SizedBox(height: height * .02),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          onTap: () => context.push('/CreateAccountWithEmail'),
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
                                          "assets/images/mail.png")),
                                ),
                                Text(
                                  "Sign Up with Email Address",
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
        );
      },
    );
  }
}
