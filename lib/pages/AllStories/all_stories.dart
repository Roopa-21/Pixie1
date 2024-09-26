import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/widgets/navbar.dart';

class AllStories extends StatefulWidget {
  const AllStories({super.key});

  @override
  State<AllStories> createState() => _AllStoriesState();
}

class _AllStoriesState extends State<AllStories> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundpurple,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundpurple,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back)),
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
      body: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          storyCard(title: "Bedtime \n Stories", theme: theme),
          storyCard(title: "Dragon tales of\nAdventure", theme: theme),
          storyCard(title: "Funtime \n Stories", theme: theme),
          storyCard(title: "Bedtime \n Stories", theme: theme)
        ],
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget storyCard({required String title, required ThemeData theme}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.kwhiteColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(7),
              bottomLeft: Radius.circular(11),
              bottomRight: Radius.circular(26)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            title,
            style: theme.textTheme.headlineMedium!
                .copyWith(color: AppColors.textColorblue, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
