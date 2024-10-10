import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/loading_widget.dart';
import 'package:pixieapp/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Fetch the list of story DocumentReferences from Firebase
  Future<List<DocumentSnapshot>> _fetchStories() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('fav_storys')
        .where('user_ref', isEqualTo: user.uid)
        .get();

    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> _fetchsuggestedStories() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final snapshot =
        await FirebaseFirestore.instance.collection('Suggestedstories').get();

    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
                const SizedBox(height: 20),
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
                FutureBuilder<List<DocumentSnapshot>>(
                    future: _fetchStories(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: LoadingWidget());
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return SizedBox(
                            height: height * .21,
                            child:
                                const Center(child: Text('No stories found')));
                      }

                      List<DocumentSnapshot> stories = snapshot.data!;

                      return Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: SizedBox(
                          height: height * .21,
                          width: width,
                          child: ListView.builder(
                            itemCount: stories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DocumentSnapshot storyDoc = stories[index];
                              Map<String, dynamic> storyData =
                                  storyDoc.data() as Map<String, dynamic>;

                              return storyCard(
                                theme: theme,
                                title: storyData['title'] ?? 'No Title',
                                onTap: () {
                                  // Pass the DocumentReference to the Firebasestory page
                                  context.push('/Firebasestory',
                                      extra: storyDoc.reference);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }),
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
                FutureBuilder<List<DocumentSnapshot>>(
                    future: _fetchsuggestedStories(),
                    builder: (context, snapshots) {
                      if (snapshots.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: LoadingWidget());
                      }

                      if (!snapshots.hasData || snapshots.data!.isEmpty) {
                        return SizedBox(
                          height: height * .21,
                          child: const Center(child: Text('No stories found')),
                        );
                      }

                      List<DocumentSnapshot> suggestedstories = snapshots.data!;
                      return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SizedBox(
                            height: height * .21,
                            width: width,
                            child: ListView.builder(
                              itemCount: suggestedstories.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                DocumentSnapshot storyDoc =
                                    suggestedstories[index];
                                Map<String, dynamic> storyData =
                                    storyDoc.data() as Map<String, dynamic>;

                                return storyCard(
                                  theme: theme,
                                  title: storyData['title'] ?? 'No Title',
                                  onTap: () {
                                    context.push('/Firebasestory',
                                        extra: storyDoc.reference);
                                  },
                                );
                              },
                            ),
                          ));
                    }),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => context.push('/feedbackPage'),
                    child: Text(
                      'Give feedback',
                      style: theme.textTheme.headlineLarge!.copyWith(
                          color: AppColors.textColorblue,
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget storyCard({
    required String title,
    required ThemeData theme,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * .37,
          decoration: const BoxDecoration(
            border:
                Border(left: BorderSide(color: Color(0xffF0E9FF), width: 11)),
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
      ),
    );
  }
}
