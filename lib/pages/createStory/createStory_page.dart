import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/Story_bloc/story_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_event.dart';
import 'package:pixieapp/blocs/Story_bloc/story_state.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/models/story_model.dart';
import 'package:pixieapp/widgets/LovedonceBottomsheet.dart';
import 'package:pixieapp/widgets/genre_bottomsheet.dart';
import 'package:pixieapp/widgets/laguage_bottomsheet.dart';
import 'package:pixieapp/widgets/lesson_bottomsheet.dart';
import 'package:pixieapp/widgets/loading_widget.dart';
import 'package:pixieapp/widgets/music_and_speed_bottomsheet.dart';
import 'package:pixieapp/widgets/pixie_button.dart';

class CreateStoryPage extends StatefulWidget {
  // StoryModal storydata;
  CreateStoryPage({
    super.key,
  });

  @override
  State<CreateStoryPage> createState() => _CreateStoryPageState();
}

class _CreateStoryPageState extends State<CreateStoryPage> {
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
                      '/StoryGeneratePage?storytype=${builderstate.musicAndSpeed}',
                      extra: state.story,
                    );
                  } else if (state is StoryFailure) {
                    // Show error message
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
                                      cardForOptions(context, 'Characters',
                                          'Cat, Dog, Puppy',
                                          ontap: () {}),
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
                            // Show loading spinner when API call is in progress
                            if (state is StoryLoading)
                              const Center(child: LoadingWidget())
                            else
                              PixieButton(
                                text: 'Create Your Story',
                                onPressed: () {
                                  _createStory(
                                      context,
                                      StoryModal(
                                          age: "10",
                                          child_name: "ammu",
                                          event: builderstate.musicAndSpeed,
                                          gender: 'female',
                                          genre: builderstate.genre,
                                          language: builderstate.language,
                                          length: builderstate.musicAndSpeed ==
                                                  'Bedtime'
                                              ? '5min'
                                              : '10min',
                                          lessons: builderstate.lessons ?? '',
                                          relation: builderstate
                                                  .lovedOnce?.relation ??
                                              '',
                                          relative_name:
                                              builderstate.lovedOnce?.name ??
                                                  '',
                                          topic: builderstate.musicAndSpeed));
                                },
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

  // Function to dispatch GenerateStoryEvent when button is clicked
  void _createStory(BuildContext context, StoryModal storydata) {
    // Dispatching the event to the Bloc to make the API call

    print(storydata.age);
    print(storydata.child_name);
    print(storydata.event);
    print(storydata.genre);
    print(storydata.language);
    print(storydata.lessons);
    context.read<StoryBloc>().add(GenerateStoryEvent(
          event: storydata.event,
          age: storydata.age,
          topic: storydata.topic,
          childName: storydata.child_name,
          gender: storydata.gender,
          relation: storydata.relation,
          relativeName: storydata.relative_name,
          genre: storydata.genre,
          lessons: storydata.lessons,
          length: storydata.length,
          language: storydata.language.name,
        ));
  }
}
