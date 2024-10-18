import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:go_router/go_router.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.sliderColor,
                              size: 23,
                            ),
                          ),
                          const SizedBox(width: 20),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                AppColors.textColorGrey,
                                AppColors.textColorSettings,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(
                              Rect.fromLTWH(
                                  0.0, 0.0, bounds.width, bounds.height),
                            ),
                            child: Text(
                              "About",
                              style: theme.textTheme.headlineMedium!.copyWith(
                                  fontSize: 24,
                                  color: AppColors.textColorWhite),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            )));
  }
}
