import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class AudioplayPage extends StatefulWidget {
  const AudioplayPage({super.key});

  @override
  State<AudioplayPage> createState() => _AudioplayPageState();
}

class _AudioplayPageState extends State<AudioplayPage> {
  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: deviceheight,
          width: devicewidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.audioPlayColor,
                AppColors.buttonColor1,
                AppColors.audioPlayColor
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(deviceheight * 0.0294),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.kwhiteColor),
                      onPressed: () {},
                    ),
                    Text('The wind in the willows',
                        style: theme.textTheme.displaySmall!.copyWith(
                            color: AppColors.textColorWhite,
                            fontWeight: FontWeight.w800)),
                    SizedBox(height: deviceheight * 0.0147),
                    Text('4 m playtime',
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: AppColors.kwhiteColor)),
                    SizedBox(height: deviceheight * 0.0294),
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.textColorWhite,
                            AppColors.textColorWhite.withOpacity(0.7),
                            Colors.transparent,
                          ],
                        ).createShader(bounds),
                        child: SingleChildScrollView(
                          child: Text(
                              '''The Wind in the Willows is a classic children's novel by the British novelist Kenneth Grahame, first published in 1908. It details the story of Mole, Ratty, and Badger as they try to help Mr. Toad, after he becomes obsessed with motorcars and gets into trouble. \n\n It also details short stories about them that are disconnected from the main narrative. The novel was based on bedtime stories Grahame told his son Alastair. It has been adapted numerous times for both stage and screen.''',
                              style: theme.textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceheight * 0.0147),
                    Column(
                      children: [
                        const Row(
                          children: [
                            Text(
                              '0:00',
                              style: TextStyle(color: AppColors.kwhiteColor),
                            ),
                            Spacer(),
                            Text(
                              '4:22',
                              style: TextStyle(color: AppColors.kwhiteColor),
                            ),
                          ],
                        ),
                        SizedBox(height: deviceheight * 0.0147),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Stack(children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient:
                            RadialGradient(colors: [AppColors.buttonColor1]),
                      ),
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.purpleAccent,
                  child: const Icon(Icons.pause, color: Colors.white),
                ),
                ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: <Color>[
                          AppColors.audioPlayColor,
                          AppColors.likeButtonColor
                        ],
                      ).createShader(bounds);
                    },
                    child: const Icon(Icons.favorite_border)),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
