import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
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
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back,
                          size: 24, color: AppColors.buttonblue)),
                  SizedBox(
                    width: 20,
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.textColorGrey,
                        AppColors.textColorSettings,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      "Feedback",
                      style: theme.textTheme.headlineMedium!.copyWith(
                          fontSize: 24, color: AppColors.textColorWhite),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        )),
      ),
    );
  }
}
