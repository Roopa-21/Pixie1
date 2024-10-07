import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar.dart';

class SetProfileLanding extends StatefulWidget {
  const SetProfileLanding({super.key});

  @override
  State<SetProfileLanding> createState() => _SetProfileLandingState();
}

class _SetProfileLandingState extends State<SetProfileLanding> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 196, 242),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 253, 249, 181),
              Color.fromARGB(255, 253, 249, 181),
              Color.fromARGB(255, 241, 222, 170),
              Color.fromARGB(255, 200, 188, 240),
              Color.fromARGB(255, 200, 188, 240),
            ],
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Image.asset(
                    'assets/images/Ellipse 14.png',
                    fit: BoxFit.fill,
                  )),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/star.png"),
                  ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              AppColors.textColor1,
                              AppColors.textColor2
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                            Rect.fromLTWH(
                                0.0, 0.0, bounds.width, bounds.height),
                          ),
                      child: Text('Good \n Morning',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displayLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800))),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * .8,
                    child: ElevatedButton(
                      onPressed: () async {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor:
                            Colors.white, // Text (foreground) color
                      ),
                      child: Text("Continue",
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color: AppColors.textColorblue,
                              fontSize: 20,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}
