import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/name_character_bottomsheet.dart';

class QuestionsIntroPage extends StatelessWidget {
  const QuestionsIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceheight = MediaQuery.of(context).size.height;
    final devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          width: devicewidth,
          height: deviceheight,
          child: Image.asset(
            'assets/images/background.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            left: deviceheight * 0.1179,
            top: deviceheight * 0.2064,
            child: Stack(children: [
              Container(
                child: Image.asset(
                  'assets/images/tooltip.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                  top: deviceheight * 0.0442,
                  left: deviceheight * 0.0147,
                  right: deviceheight * 0.0147,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Just 3 steps before we can create stories together',
                      textAlign: TextAlign.center,
                    ),
                  ))
            ])),
        Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Share a few details now! You can update them anytime in your profile!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall!.copyWith(
                        color: AppColors.textColorblack,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.85,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
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
            ))
      ]),
    );
  }
}
