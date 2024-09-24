import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor, // End color
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 70,
              child: Image.asset('assets/images/purplecircle.png'),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/star.png"),
                  ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
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
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
