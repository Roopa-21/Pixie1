import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff9f3cd),
      body: Container(
        height: height,
        width: width,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 145,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: () => context.push('/AddCharacter'),
                          child: Container(
                            width: width * .7,
                            height: 68,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffAF52DE),
                                      Color(0xff5600FF),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter),
                                borderRadius: BorderRadius.circular(109)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/plus_icon.svg',
                                  width: 35,
                                  height: 35,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  "Create Story",
                                  style: theme.textTheme.headlineLarge!
                                      .copyWith(
                                          fontSize: width * .06,
                                          color: AppColors.kwhiteColor),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image.asset(
                          "assets/images/star.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Stories you created',
                    style: theme.textTheme.headlineLarge!.copyWith(
                        color: AppColors.textColorblue,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    height: height * .21,
                    width: width,
                    child: ListView.builder(
                      itemBuilder: (context, index) => storyCard(
                        theme: theme,
                        title: 'Thomas, believes in brushing',
                      ),
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Suggested stories',
                    style: theme.textTheme.headlineLarge!.copyWith(
                        color: AppColors.textColorblue,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SizedBox(
                    height: height * .21,
                    width: width,
                    child: ListView.builder(
                      itemBuilder: (context, index) => storyCard(
                        theme: theme,
                        title: 'Thomas, believes in brushing',
                      ),
                      itemCount: 8,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Text('Give feedback',
                        style: theme.textTheme.headlineLarge!.copyWith(
                            color: AppColors.textColorblue,
                            fontSize: 17,
                            fontWeight: FontWeight.w400)),
                    onPressed: () => context.push('/feedbackPage'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget storyCard({required String title, required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * .37,
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Color(0xffF0E9FF), width: 11)),
          color: AppColors.kwhiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(11),
              bottomRight: Radius.circular(26)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: AppColors.textColorblue,
                    fontSize: MediaQuery.of(context).size.width * .04,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * .03),
                  child: SvgPicture.asset(
                    'assets/images/play_story.svg',
                    width: 26,
                    height: 26,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
