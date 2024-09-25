import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/bottomsheet.dart';
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

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        height: deviceheight,
        width: devicewidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 231, 201, 249),
              Color.fromARGB(255, 248, 244, 187),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .43,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/Ellipse 13 (2).png',
                                  width: 450,
                                  height: 450,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SafeArea(
                              child: Center(
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
                                          Color.fromARGB(90, 97, 42, 206),
                                          Color.fromARGB(100, 97, 42, 206),
                                          Color.fromARGB(90, 97, 42, 206),
                                          Color.fromARGB(70, 97, 42, 206),
                                          Color.fromARGB(80, 147, 117, 206),
                                          Color.fromARGB(80, 147, 112, 206),
                                          Color.fromARGB(110, 147, 152, 205),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ).createShader(
                                        Rect.fromLTWH(0.0, 0.0, bounds.width,
                                            bounds.height),
                                      ),
                                      child: Transform.rotate(
                                        angle: -.05,
                                        child: Text(
                                          'Create\nStory',
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.displayLarge!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 96),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SafeArea(
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: AppColors.iconColor),
                                onPressed: () {
                                  context.pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20), // For better spacing
                      cardForOptions(context, 'Loved ones', 'Dad'),
                      cardForOptions(
                          context, 'Characters', 'Elephant, Cat, Dog, Puppy'),
                      cardForOptions(context, 'Theme', 'Bedtime Story'),
                      cardForOptions(
                          context, 'Vocation', 'Select up to five loved ones.'),
                    ],
                  ),
                ),
              ),
            ),
            PixieButton(
              text: 'Create Your Story',
              onPressed: () {
                context.push('/StoryGeneratePage');
              },
              color1: AppColors.buttonColor1,
              color2: AppColors.buttonColor2,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardForOptions(BuildContext context, String title, String value) {
    final devicewidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: devicewidth * 0.044),
      padding: EdgeInsets.symmetric(
          vertical: devicewidth * 0.044, horizontal: devicewidth * 0.044),
      decoration: BoxDecoration(
        color: const Color.fromARGB(188, 236, 236, 236),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(100, 206, 190, 251),
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
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.kgreyColor,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(value,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.iconColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.iconColor),
            onPressed: () async {
              await showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Padding(
                      padding: MediaQuery.viewInsetsOf(context),
                      child: const BottomSheetWidget(
                        text: "Select your\nloved ones",
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
