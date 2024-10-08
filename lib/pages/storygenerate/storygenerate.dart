import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar2.dart';

class StoryGeneratePage extends StatelessWidget {
  final Map<String, String> story; // Accept the story text

  const StoryGeneratePage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: deviceheight * 0.3,
            leadingWidth: devicewidth,
            collapsedHeight: deviceheight * 0.1,
            pinned: true,
            floating: false,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                bool isCollapsed = top <= kToolbarHeight + 30;

                return FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  title: Text(
                    story["title"] ?? "No data",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.textColorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: isCollapsed ? 5 : 20,
                    ),
                  ),
                  background: Image.asset(
                    'assets/images/sliverApp.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.go('/HomePage');
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 5,
                  left: deviceheight * 0.0294,
                  right: deviceheight * 0.0294,
                  bottom: deviceheight * 0.0294),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textColorGrey,
                        fontWeight: FontWeight.w400),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TyperAnimatedText(
                          story["story"] ?? "No data",
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                  // Text(body,
                  //     style: theme.textTheme.bodyLarge!.copyWith(
                  //         color: AppColors.textColorGrey,
                  //         fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavBar2(),
    );
  }
}
