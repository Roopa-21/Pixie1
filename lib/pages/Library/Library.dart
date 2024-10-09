import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pixieapp/blocs/Library_bloc/library_bloc.dart';
import 'package:pixieapp/blocs/Library_bloc/library_event.dart';
import 'package:pixieapp/blocs/Library_bloc/library_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/loading_widget.dart';
import 'package:pixieapp/widgets/navbar.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<FetchStoryBloc>().add(FetchStories(user.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<FetchStoryBloc, StoryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xfff9f3cd),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "My Stories",
                      style: theme.textTheme.headlineMedium!
                          .copyWith(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: SizedBox(
                      width: width,
                      height: 45,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            filterChoicechip(
                                ontap: () async {
                                  context.read<FetchStoryBloc>().add(
                                      const AddfilterEvent(filter: 'Bedtime'));
                                  print(state);
                                },
                                title: 'Bedtime',
                                theme: theme,
                                selected:
                                    state.filter == 'Bedtime' ? true : false),
                            filterChoicechip(
                                ontap: () => context.read<FetchStoryBloc>().add(
                                    const AddfilterEvent(filter: 'Playtime')),
                                title: 'Playtime',
                                theme: theme,
                                selected:
                                    state.filter == 'Playtime' ? true : false),
                            filterChoicechip(
                                ontap: () => context
                                    .read<FetchStoryBloc>()
                                    .add(const AddfilterEvent(filter: 'Liked')),
                                title: 'Liked',
                                theme: theme,
                                selected:
                                    state.filter == 'Liked' ? true : false),
                            filterChoicechip(
                                ontap: () => context.read<FetchStoryBloc>().add(
                                    const AddfilterEvent(filter: 'English')),
                                title: 'English',
                                theme: theme,
                                selected:
                                    state.filter == 'English' ? true : false),
                            filterChoicechip(
                                ontap: () => context
                                    .read<FetchStoryBloc>()
                                    .add(const AddfilterEvent(filter: 'Hindi')),
                                title: 'Hindi',
                                theme: theme,
                                selected:
                                    state.filter == 'Hindi' ? true : false)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/updownarrow.svg'),
                        const SizedBox(width: 10),
                        Text(
                          'Recents',
                          style:
                              theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  // Handle different states here
                  Expanded(
                    child: _buildStoryContent(state, theme),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const NavBar(),
        );
      },
    );
  }

  Widget filterChoicechip({
    required ThemeData theme,
    required bool selected,
    required String title,
    required void Function() ontap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ElevatedButton(
        onPressed: ontap,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          minimumSize: const Size(50, 32),
          maximumSize: const Size(200, 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          foregroundColor: selected ? AppColors.kpurple : AppColors.kwhiteColor,
          backgroundColor: selected ? AppColors.kpurple : AppColors.kwhiteColor,
        ),
        child: Text(
          title,
          style: theme.textTheme.bodySmall!.copyWith(
              color: selected ? AppColors.kwhiteColor : AppColors.kblackColor,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget _buildStoryContent(StoryState state, ThemeData theme) {
    if (state is StoryLoading) {
      return const Center(child: LoadingWidget());
    } else if (state is StoryLoaded) {
      List<Map<String, dynamic>> filteredStories = state.stories.where((story) {
        if (state.filter == 'English' || state.filter == 'Hindi') {
          return story['language'] == state.filter;
        } else if (state.filter == 'Bedtime' || state.filter == 'Playtime') {
          return story['storytype'] == state.filter;
        } else if (state.filter == 'Liked') {
          return story['isfav'] == true;
        }
        return true; // If no filter, return all stories
      }).toList();

      if (filteredStories.isEmpty) {
        return const Center(child: Text("No stories found"));
      }

      return ListView.builder(
        itemCount: filteredStories.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: storylistCard(
            theme: theme,
            title: filteredStories[index]['title'],
            storytype: filteredStories[index]['storytype'],
            duration: filteredStories[index]['audiofile'],
            image: '',
            ontap: () {},
          ),
        ),
      );
    } else if (state is StoryError) {
      return Center(child: Text(state.error));
    }

    return const SizedBox();
  }

  Widget storylistCard({
    required ThemeData theme,
    required String title,
    required String storytype,
    required String duration,
    required String image,
    required void Function() ontap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    Text(storytype, style: theme.textTheme.bodyMedium),
                    const Text(
                      ' - ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(duration, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(flex: 1, child: Icon(Icons.ios_share_rounded)),
        ],
      ),
    );
  }
}
