import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/widgets/pixie_button.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          height: deviceheight,
          width: devicewidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryColor,
                AppColors.primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        child: Image.asset(
                          'assets/images/Ellipse 13 (2).png',
                          width: 300,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/star.png',
                              width: devicewidth * 0.1388,
                              height: devicewidth * 0.1388,
                            ),
                            ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        AppColors.textColor1,
                                        AppColors.iconColor
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ).createShader(
                                      Rect.fromLTWH(0.0, 0.0, bounds.width,
                                          bounds.height),
                                    ),
                                child: Text('Create \n Story',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.displayLarge!
                                        .copyWith(color: Colors.white)))
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: AppColors.iconColor),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          cardForOptions(context, 'Loved ones', 'Dad'),
                          cardForOptions(context, 'Characters',
                              'Elephant, Cat, Dog, Puppy'),
                          cardForOptions(context, 'Theme', 'Bedtime Story'),
                          cardForOptions(context, 'Vocation',
                              'Select upto five loved ones.'),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            PixieButton(
              text: 'Create Your Story',
              onPressed: () {},
              color1: AppColors.buttonColor1,
              color2: AppColors.buttonColor2,
              //  color:
            )
          ]),
        ),
      ),
    );
  }

  Widget cardForOptions(BuildContext context, String title, String value) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: devicewidth * 0.044),
      padding: EdgeInsets.symmetric(
          vertical: devicewidth * 0.044, horizontal: devicewidth * 0.044),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.secondaryColor,
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.kgreyColor)),
                const SizedBox(height: 4),
                Text(value,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: AppColors.iconColor)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.iconColor),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
