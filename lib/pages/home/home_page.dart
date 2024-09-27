import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 196, 242),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                  height: MediaQuery.of(context).size.height * .16,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * .7,
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
                                width: 40,
                                height: 40,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Create Story",
                                style: theme.textTheme.headlineLarge!.copyWith(
                                    fontSize: 24, color: AppColors.kwhiteColor),
                              )
                            ],
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
                    height: MediaQuery.of(context).size.height * .21,
                    width: MediaQuery.of(context).size.width,
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
                    height: MediaQuery.of(context).size.height * .21,
                    width: MediaQuery.of(context).size.width,
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
                  child: Text(
                    'Give feedback',
                    style: theme.textTheme.headlineLarge!.copyWith(
                        color: AppColors.textColorblue,
                        fontSize: 17,
                        fontWeight: FontWeight.w400),
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
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: AppColors.textColorblue,
                    fontSize: 21,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
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
