import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/routes/routes.dart';
import 'package:pixieapp/widgets/navbar.dart';

class MyStories extends StatefulWidget {
  const MyStories({super.key});

  @override
  State<MyStories> createState() => _MyStoriesState();
}

class _MyStoriesState extends State<MyStories> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.kwhiteColor,
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * .4,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "My Stories",
                style: theme.textTheme.headlineMedium!.copyWith(fontSize: 24),
              ),
              Text(
                "All your stories",
                style: theme.textTheme.bodySmall!.copyWith(
                    color: AppColors.textColorblack,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            storyCard(title: "Bedtime \n Stories", count: 12, theme: theme),
            storyCard(
                title: "Dragon tales of\nAdventure", count: 4, theme: theme),
            storyCard(title: "Funtime \n Stories", count: 7, theme: theme),
            storyCard(title: "Bedtime \n Stories", count: 23, theme: theme)
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget storyCard(
      {required String title, required int count, required ThemeData theme}) {
    return GestureDetector(
      onTap: () => router.push('/AllStories'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .2,
          decoration: BoxDecoration(
            color: AppColors.backgroundpurple,
            borderRadius: BorderRadius.circular(19),
          ),
          child: Padding(
            padding: const EdgeInsets.all(29),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.headlineMedium!
                      .copyWith(color: AppColors.kwhiteColor, fontSize: 24),
                ),
                Text(
                  count.toString(),
                  style: theme.textTheme.headlineMedium!
                      .copyWith(color: AppColors.kwhiteColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
