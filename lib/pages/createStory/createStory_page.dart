// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/Story_bloc/story_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_event.dart';
import 'package:pixieapp/blocs/Story_bloc/story_state.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/LovedonceBottomsheet.dart';
import 'package:pixieapp/widgets/character_bottomsheet.dart';
import 'package:pixieapp/widgets/genre_bottomsheet.dart';
import 'package:pixieapp/widgets/laguage_bottomsheet.dart';
import 'package:pixieapp/widgets/lesson_bottomsheet.dart';
import 'package:pixieapp/widgets/loading_widget.dart';
import 'package:pixieapp/widgets/music_and_speed_bottomsheet.dart';
import 'package:pixieapp/widgets/pixie_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateStoryPage extends StatefulWidget {
  const CreateStoryPage({super.key});

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
  Future<Map<String, dynamic>> _fetchChildDetailsFromFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }

    // Fetch user data from Firebase
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!userDoc.exists) {
      throw Exception('User data not found');
    }

    // Extract child details
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    String childName = userData['child_name'] ?? 'No Name';
    String gender = userData['gender'] ?? 'Unknown';
    int birthYear = (userData['dob'].toDate()).year;
    int currentYear = DateTime.now().year;

    int ageInYears = currentYear - birthYear;
    print(userData['dob'].toString());
    String age = ageInYears.toString();

    return {
      'child_name': childName,
      'gender': gender,
      'age': age,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;

    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
        builder: (context, builderstate) => Scaffold(
              backgroundColor: AppColors.primaryColor,
              body: BlocConsumer<StoryBloc, StoryState>(
                listener: (context, state) {
                  if (state is StorySuccess) {
                    context.push(
                      '/StoryGeneratePage?storytype=${builderstate.musicAndSpeed}&language=${builderstate.language.name}}',
                      extra: state.story,
                    );
                  } else if (state is StoryFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
                builder: (context, state) {
                  return Container(
                    height: deviceheight,
                    width: devicewidth,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 231, 201, 249),
                          Color.fromARGB(255, 248, 244, 187),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .388,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  'assets/images/Ellipse 13 (2).png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SafeArea(
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/star.png',
                                                      width:
                                                          devicewidth * 0.1388,
                                                      height:
                                                          devicewidth * 0.1388,
                                                    ),
                                                    ShaderMask(
                                                      shaderCallback: (bounds) =>
                                                          const LinearGradient(
                                                        colors: [
                                                          Color.fromARGB(
                                                              90, 97, 42, 206),
                                                          Color.fromARGB(
                                                              100, 97, 42, 206),
                                                          Color.fromARGB(
                                                              90, 97, 42, 206),
                                                          Color.fromARGB(
                                                              70, 97, 42, 206),
                                                          Color.fromARGB(80,
                                                              147, 117, 206),
                                                          Color.fromARGB(80,
                                                              147, 112, 206),
                                                          Color.fromARGB(110,
                                                              147, 152, 205),
                                                        ],
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                      ).createShader(
                                                        Rect.fromLTWH(
                                                            0.0,
                                                            0.0,
                                                            bounds.width,
                                                            bounds.height),
                                                      ),
                                                      child: Transform.rotate(
                                                        angle: -.05,
                                                        child: Stack(
                                                          children: [
                                                            Text(
                                                              'Create',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: theme
                                                                  .textTheme
                                                                  .displayLarge!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          96),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top:
                                                                          75.0),
                                                              child: Text(
                                                                '  Story',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: theme
                                                                    .textTheme
                                                                    .displayLarge!
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            96),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      cardForOptions(
                                        context,
                                        'Music and speed ',
                                        builderstate.musicAndSpeed,
                                        ontap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const MusicAndSpeedBottomsheet(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      cardForOptions(
                                        context,
                                        'Characters',
                                        builderstate.charactorname ??
                                            'Not added',
                                        ontap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const CharacterBottomsheet(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      cardForOptions(
                                        context,
                                        'Loved ones',
                                        builderstate.lovedOnce?.relation ??
                                            "Not added",
                                        ontap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const LovedonceBottomsheet(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      cardForOptions(
                                        context,
                                        'Lesson',
                                        builderstate.lessons ?? 'Not added',
                                        ontap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const LessonBottomsheet(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      cardForOptions(
                                        context,
                                        'Genre',
                                        builderstate.genre,
                                        ontap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const GenreBottomsheet(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      cardForOptions(
                                        context,
                                        'Language',
                                        builderstate.language.name,
                                        ontap: () async {
                                          await showModalBottomSheet(
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            enableDrag: false,
                                            context: context,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                child: Padding(
                                                  padding:
                                                      MediaQuery.viewInsetsOf(
                                                          context),
                                                  child:
                                                      const LaguageBottomsheet(),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (state is StoryLoading)
                              const Center(child: LoadingWidget())
                            else
                              PixieButton(
                                text: 'Create Your Story',
                                onPressed: () => _createStory(context),
                                color1: AppColors.buttonColor1,
                                color2: AppColors.buttonColor2,
                              ),
                          ],
                        ),
                        Positioned(
                          top: 10,
                          left: 10,
                          child: SafeArea(
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: AppColors.iconColor),
                              onPressed: () {
                                context.pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ));
  }

  Widget cardForOptions(BuildContext context, String title, String value,
      {required VoidCallback ontap}) {
    final devicewidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: devicewidth * 0.04),
      padding: EdgeInsets.symmetric(
          vertical: devicewidth * 0.07, horizontal: devicewidth * 0.05),
      decoration: BoxDecoration(
        color: const Color.fromARGB(188, 236, 236, 236),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(100, 206, 190, 251),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.kgreyColor,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(value,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.iconColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.edit, color: AppColors.iconColor),
              onPressed: ontap),
        ],
      ),
    );
  }

  Future<void> _createStory(BuildContext context) async {
    try {
      Map<String, dynamic> childDetails =
          await _fetchChildDetailsFromFirebase();

      context.read<StoryBloc>().add(GenerateStoryEvent(
            event: context.read<AddCharacterBloc>().state.musicAndSpeed,
            age: childDetails['age'],
            topic: context.read<AddCharacterBloc>().state.charactorname ?? '',
            childName: childDetails['child_name'],
            gender: childDetails['gender'],
            relation:
                context.read<AddCharacterBloc>().state.lovedOnce?.relation ??
                    '',
            relativeName:
                context.read<AddCharacterBloc>().state.lovedOnce?.name ?? '',
            genre: context.read<AddCharacterBloc>().state.genre,
            lessons: context.read<AddCharacterBloc>().state.lessons ?? '',
            length: context.read<AddCharacterBloc>().state.musicAndSpeed ==
                    'Bedtime'
                ? '5min'
                : '10min',
            language: context.read<AddCharacterBloc>().state.language.name,
          ));
      context.read<AddCharacterBloc>().add(const PageChangeEvent(0));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching child details: $e')),
      );
    }
  }
}
