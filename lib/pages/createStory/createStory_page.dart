import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.secondaryBackgroundColor,
      body: SingleChildScrollView(
      child: Column(children: [
        Stack(
          children: [
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
              
              
              child: Text('Create',style: theme.textTheme.headlineLarge,))
          ],
        )
      ],),
      ),
    );
  }
}