import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class StoryConfirmationPage extends StatefulWidget {
  const StoryConfirmationPage({super.key});

  @override
  State<StoryConfirmationPage> createState() => _StoryConfirmationPageState();
}

class _StoryConfirmationPageState extends State<StoryConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceheight = MediaQuery.of(context).size.height;

    final devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: devicewidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 248, 244, 187),
              Color.fromARGB(255, 231, 201, 249),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Positioned(
                child: Image.asset(
                  'assets/images/Ellipse 14.png',
                  height: 300,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Transform.rotate(
                    angle: .2,
                    child: Image.asset(
                      'assets/images/star.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                ),
              ),
            ]),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.kwhiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.buttonColor1,
                        Color(0xff7995B4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      'Welcome to new adventures!',
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.kwhiteColor,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 10),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.buttonColor1,
                        Color(0xff7995B4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      'Do you want to create your first story now?',
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.kwhiteColor,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: AppColors.kwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Yes'),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: AppColors.kwhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'No',
                      style: TextStyle(
                        color: Color(0xFF7E57C2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
