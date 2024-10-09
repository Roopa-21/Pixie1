import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoryGeneratePage extends StatefulWidget {
  final Map<String, String> story;
  final String storytype;

  const StoryGeneratePage({
    super.key,
    required this.story,
    required this.storytype,
  });

  @override
  _StoryGeneratePageState createState() => _StoryGeneratePageState();
}

class _StoryGeneratePageState extends State<StoryGeneratePage> {
  bool isFavorited = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // _checkIfFavorited();
  }

  // Future<void> _checkIfFavorited() async {
  //   final snapshot = await _firestore
  //       .collection('fav_storys')
  //       .doc(widget.story['title'])
  //       .get();
  //   setState(() {
  //     isFavorited = snapshot.exists;
  //   });
  // }

  Future<void> _toggleFavorite() async {
    final String title = widget.story['title'] ?? 'Untitled';
    final String audioFile = ''; // Placeholder for the audio file URL
    final String storyContent = widget.story['story'] ?? 'No story';

    if (isFavorited) {
      // Remove the story from favorites
      await _firestore.collection('fav_storys').doc(title).delete();
      print('Story removed from favorites');
    } else {
      // Add the story to favorites
      await _firestore.collection('fav_storys').add({
        'storytype': widget.storytype,
        'title': title,
        'audiofile': audioFile, // Add the audio file link here
        'story': storyContent,
      });
      print('Story added to favorites');
    }
    // _checkIfFavorited(); // Refresh the favorite state
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: deviceHeight * 0.3,
            leadingWidth: deviceWidth,
            collapsedHeight: deviceHeight * 0.1,
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
                    widget.story["title"] ?? "No data",
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
                onPressed: () async {
                  context.read<AddCharacterBloc>().add(ResetStateEvent());
                  context.go('/HomePage');
                },
              ),
              // IconButton(
              //   icon: Icon(isFavorited
              //       ? Icons.favorite
              //       : Icons.favorite_border), // Heart icon
              //   onPressed: ,
              // ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: deviceHeight * 0.0294,
                right: deviceHeight * 0.0294,
                bottom: deviceHeight * 0.0294,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: AppColors.textColorGrey,
                      fontWeight: FontWeight.w400,
                    ),
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TyperAnimatedText(
                          widget.story["story"] ?? "No data",
                        ),
                      ],
                      onTap: () {
                        print("Tap Event");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar2(ontap: _toggleFavorite),
    );
  }
}
