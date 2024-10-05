import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar2.dart';

class StoryGeneratePage extends StatelessWidget {
  final String story; // Accept the story text

  const StoryGeneratePage({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    // Split the story into title and body
    List<String> storyLines =
        story.split('\n'); // Split story into lines by new line
    String title = storyLines.isNotEmpty
        ? storyLines[0]
        : "Generated Story"; // First line is title
    String body = storyLines.length > 1
        ? storyLines.sublist(1).join('\n') // Rest of the lines are body
        : "No content available."; // Default message if there's no body

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
                // Get the current height of the SliverAppBar
                var top = constraints.biggest.height;
                bool isCollapsed = top <= kToolbarHeight + 30;

                return FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  title: Text(
                    title,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.textColorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: isCollapsed
                          ? 5
                          : 20, // Adjust font size based on collapse
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
                  // Display the rest of the story as body text
                  Text(body,
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textColorGrey,
                          fontWeight: FontWeight.w400)),
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
