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
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
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
                      Text(
                        'Privacy Policy',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textColorblack,
                            fontWeight: FontWeight.w600),
                      ),
                      Text('''

1. Introduction

Pixie respects your privacy and is committed to protecting the personal information of our app users. This Privacy Policy outlines our practices regarding the collection, use, and safeguarding of your personal information through our mobile applications.

2. Information Collection

2.1 Personal Information: We collect personal information such as your name, email address when you register, or interact with our app.

3.Contact Us

For queries,
Contact number: + 91-9643221767
Email id: fabletronic@gmail.com.
'''),
                    ]),
              ),
            )));
  }
}
