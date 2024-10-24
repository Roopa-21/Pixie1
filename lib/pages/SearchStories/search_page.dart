import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/blocs/Library_bloc/library_bloc.dart';
import 'package:pixieapp/blocs/Library_bloc/library_event.dart';
import 'package:pixieapp/blocs/Library_bloc/library_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchcontroller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchcontroller.text;
    context.read<FetchStoryBloc>().add(SearchStoryEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
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
            IconButton(
              onPressed: () {
                context.go('/Library');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.sliderColor,
                size: 23,
              ),
            ),
            const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _searchcontroller,
                decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        'assets/images/search.svg',
                        width: 10,
                        height: 10,
                      ),
                    ),
                    hintText: 'Search',
                    hintStyle: theme.textTheme.bodySmall!.copyWith(
                        color: AppColors.kblackColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                    contentPadding: const EdgeInsets.only(left: 15),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.kpurple)),
                    fillColor: AppColors.kwhiteColor,
                    focusColor: AppColors.textColorblue,
                    filled: true),
              ),
            ),
            Expanded(
              child: BlocBuilder<FetchStoryBloc, StoryState>(
                builder: (context, state) {
                  if (state is StoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StoryError) {
                    return const Center(child: Text('Error'));
                  } else if (state is StoryLoaded) {
                    final stories = state.filteredStories;
                    if (stories.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Couldn't find",
                              style: theme.textTheme.headlineMedium!.copyWith(
                                  fontSize: 24,
                                  color: AppColors.textColorblack,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Try again using a different spelling\n or keyword.',
                              style: theme.textTheme.bodySmall!.copyWith(
                                  color: AppColors.kblackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: stories.length,
                      itemBuilder: (context, index) {
                        final story = stories[index];
                        final DocumentReference storyRef = story['reference'];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: storylistCard(
                            theme: theme,
                            title: story['title'],
                            storytype: story['storytype'],
                            duration: _formatCreatedTime(story['createdTime']),
                            image: '',
                            storyRef: storyRef,
                            ontap: () {
                              context.push('/Firebasestory', extra: storyRef);
                            },
                          ),
                        );

                        // return ListTile(
                        //   title: Text(story['title']),
                        //   onTap: () {
                        //     context.push('/Firebasestory', extra: storyRef);
                        //   },
                        // );
                      },
                    );
                  }
                  return const Center(child: Text('No stories found.'));
                },
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget storylistCard({
    required ThemeData theme,
    required String title,
    required String storytype,
    required String duration,
    required String image,
    required DocumentReference storyRef,
    required void Function() ontap,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 70,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: AppColors.kwhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.kgreyColor.withOpacity(0.4),
                      blurRadius: 7,
                      spreadRadius: 0.5,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Image.asset('assets/images/star.png'),
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
            // Expanded(
            //   flex: 1,
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: SvgPicture.asset(
            //       'assets/images/share.svg',
            //       width: 25,
            //       height: 25,
            //       color: AppColors.kblackColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

String _formatCreatedTime(Timestamp? timestamp) {
  if (timestamp == null) return 'Unknown Date'; // Handle null gracefully

  final DateTime dateTime = timestamp.toDate();
  final Duration difference = DateTime.now().difference(dateTime);

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inMinutes == 1) {
    return '1 min ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} mins ago';
  } else if (difference.inHours == 1) {
    return '1 hr ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hrs ago';
  } else if (difference.inDays == 1) {
    return '1 day ago';
  } else {
    return '${difference.inDays} days ago';
  }
}
