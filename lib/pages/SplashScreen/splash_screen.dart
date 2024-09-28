import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceheight = MediaQuery.of(context).size.height;
    // print(deviceheight);
    final devicewidth = MediaQuery.of(context).size.width;

    Timer(Duration(seconds: 3), () {
      context.push('/storyconfirmationstory');
    });

    return Scaffold(
      body: Stack(children: [
        Container(
          height: deviceheight,
          width: devicewidth,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            bottom: deviceheight * 0.35,
            left: deviceheight * 0.18,
            child: Transform.rotate(
              angle: -0.1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [Color(0xffb0b3f8), Color(0xffe3aeff)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                height: 86,
                width: 200,
                child: Center(
                  child: Text(
                    '''Hi! I'm Pixie''',
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textColorWhite,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
