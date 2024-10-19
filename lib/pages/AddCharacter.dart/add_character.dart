import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/models/Child_data_model.dart';
import 'package:pixieapp/models/story_model.dart';
import 'package:pixieapp/widgets/add_charactor_story.dart';
import 'package:pixieapp/widgets/add_lesson_bottom_sheet.dart';
import 'package:pixieapp/widgets/add_loved_ones_bottomsheet.dart';
import 'package:pixieapp/widgets/widgets_index.dart';

class AddCharacter extends StatefulWidget {
  const AddCharacter({super.key});

  @override
  State<AddCharacter> createState() => _AddCharacterState();
}

class _AddCharacterState extends State<AddCharacter> {
  PageController? pageViewController;
  List<Lovedonces> lovedOnceList = [];
  List<String> lessons = [];

  int? selectedlovedone;
  StoryModal storydata = StoryModal(
      age: "age",
      child_name: "Aju",
      event: "Bedtime",
      gender: "gender",
      genre: "Funny",
      language: Language.English,
      length: "5min",
      lessons: "",
      relation: "dad",
      relative_name: "jayan",
      topic: "Bedtime");
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    fetchLovedOnes().then((lovedOnes) {
      setState(() {
        lovedOnceList = lovedOnes;
        finalstorydatas.age = '10';
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return BlocListener<AddCharacterBloc, AddCharacterState>(
        listener: (context, state) {
          // Update storydata when the state changes
          finalstorydatas.language = state.language;
          finalstorydatas.event = state.musicAndSpeed;
          finalstorydatas.relation = state.lovedOnce?.relation ?? '';
          finalstorydatas.relative_name = state.lovedOnce?.name ?? '';
          finalstorydatas.lessons = state.lessons ?? '';
          finalstorydatas.genre = state.genre;
          finalstorydatas.topic = state.charactorname ?? '';

          storydata.language = state.language;
          storydata.relative_name = state.lovedOnce?.name ?? '';
          storydata.relation = state.lovedOnce?.relation ?? '';
          storydata.lessons = state.lessons ?? '';
          selectedlovedone = state.selectedindex;
          storydata.genre = state.genre;
          storydata.event = state.musicAndSpeed;
          storydata.topic = state.charactorname ?? '';
        },
        child: BlocBuilder<AddCharacterBloc, AddCharacterState>(
          builder: (context, state) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: const Color.fromARGB(255, 236, 215, 244),
              key: scaffoldKey,
              body: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 231, 201, 249),
                      Color.fromARGB(255, 248, 244, 187)
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Platform.isIOS ? 44.0 : 24.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20.0, 10.0, 20.0, 10.0),
                            child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              allowImplicitScrolling: false,
                              onPageChanged: (index) {
                                context
                                    .read<AddCharacterBloc>()
                                    .add(PageChangeEvent(index));
                              },
                              controller: pageViewController ??=
                                  PageController(initialPage: 0),
                              scrollDirection: Axis.horizontal,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8DEF8),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                context.go('/HomePage');
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back,
                                                color: AppColors.sliderColor,
                                                size: 23,
                                              ),
                                            )),
                                        const SizedBox(width: 5),
                                        customSlider(percent: 1),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        primary: true,
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 25),
                                            Text(
                                              'Music and speed of the story suitable for',
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textColorblue,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: width * .08),
                                            ),
                                            const SizedBox(height: 25),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Bedtime",
                                                selected: state.musicAndSpeed ==
                                                        'Bedtime'
                                                    ? true
                                                    : false,
                                                ontap: () {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateMusicandspeedEvent(
                                                              'Bedtime'));
                                                }),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Playtime",
                                                selected: state.musicAndSpeed ==
                                                        'Playtime'
                                                    ? true
                                                    : false,
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateMusicandspeedEvent(
                                                              'Playtime'));

                                                  print(storydata.event);
                                                }),
                                            const SizedBox(height: 40),
                                            Text(
                                              'Language of the story',
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textColorblue,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: width * .08),
                                            ),
                                            const SizedBox(height: 25),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "English",
                                                selected: state.language ==
                                                        Language.English
                                                    ? true
                                                    : false,
                                                ontap: () {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const LanguageChangeEvent(
                                                              Language
                                                                  .English));

                                                  storydata.language =
                                                      state.language;

                                                  print(storydata.language);
                                                }),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Hindi",
                                                selected: state.language ==
                                                        Language.Hindi
                                                    ? true
                                                    : false,
                                                ontap: () {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const LanguageChangeEvent(
                                                              Language.Hindi));

                                                  storydata.language =
                                                      state.language;

                                                  print(storydata.language);
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8DEF8),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                pageViewController
                                                    ?.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back,
                                                color: AppColors.sliderColor,
                                                size: 23,
                                              ),
                                            )),
                                        const SizedBox(width: 5),
                                        customSlider(percent: 0),
                                        customSlider(percent: 1),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        primary: true,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      15.0, 25, 15.0, 0.0),
                                              child: Text(
                                                'Add a character to the story...',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textColorblue,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * .08),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      15.0, 10.0, 15.0, 0.0),
                                              child: Text(
                                                'Select one',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .kgreyColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20),
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(user!.uid)
                                                  .snapshots(), // Listening for real-time updates to the user document
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child: LoadingWidget());
                                                }

                                                if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'Error: ${snapshot.error}'));
                                                }

                                                if (snapshot.hasData) {
                                                  var userData = snapshot.data!
                                                          .data()
                                                      as Map<String, dynamic>;

                                                  List<dynamic> charactors =
                                                      userData[
                                                              'storycharactors'] ??
                                                          [];

                                                  if (charactors.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            'No character found.'));
                                                  }

                                                  return Wrap(
                                                    children:
                                                        List<Widget>.generate(
                                                            charactors.length,
                                                            (int indexx) {
                                                      // Accessing each lesson by index
                                                      String charactorsitem =
                                                          charactors[
                                                              indexx]; // Get the lesson data for the current index
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: SizedBox(
                                                          height: 48,
                                                          child: ChoiceChip(
                                                            side: const BorderSide(
                                                                width: .4,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        152,
                                                                        152,
                                                                        152)),
                                                            shadowColor:
                                                                Colors.black,
                                                            onSelected:
                                                                (value) {
                                                              // Trigger an event or do something with the selected lesson
                                                              context
                                                                  .read<
                                                                      AddCharacterBloc>()
                                                                  .add(AddcharactorstoryEvent(
                                                                      charactorsitem,
                                                                      selectedindexcharactor:
                                                                          indexx));
                                                              // print(
                                                              //     charactorsitem);
                                                            },
                                                            selectedColor:
                                                                AppColors
                                                                    .kpurple,
                                                            elevation: 3,
                                                            checkmarkColor:
                                                                AppColors
                                                                    .kwhiteColor,
                                                            label: Text(
                                                                charactorsitem
                                                                    .toString(),
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: state.selectedindexcharactor ==
                                                                          indexx
                                                                      ? AppColors
                                                                          .kwhiteColor
                                                                      : AppColors
                                                                          .kblackColor,
                                                                ) // Display the lesson name or string representation

                                                                ),
                                                            selected: state
                                                                    .selectedindexcharactor ==
                                                                indexx, // Set the selection based on index
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              side: BorderSide
                                                                  .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                }

                                                return const Center(
                                                    child: Text(
                                                        'No character found.'));
                                              },
                                            ),
                                            addbutton(
                                                title: "Add a character",
                                                width: 180,
                                                theme: theme,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              const AddCharactorStory(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }),
                                            const SizedBox(height: 40),
                                            Container(
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                              decoration: BoxDecoration(
                                                  color: AppColors.kwhiteColor
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    12,
                                                  ),
                                                  border: const Border(
                                                      left: BorderSide(
                                                          color: Color(
                                                              0xffECECEC)),
                                                      right: BorderSide(
                                                        color:
                                                            Color(0xffECECEC),
                                                      ),
                                                      bottom: BorderSide(
                                                        color:
                                                            Color(0xffECECEC),
                                                      ),
                                                      top: BorderSide(
                                                          color: Color(
                                                              0xffECECEC)))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * .04,
                                                    vertical: width * .02),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Pro Tip',
                                                      style: theme.textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .kgreyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * .04),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Ask your little one:\nWhat should we name this character?',
                                                      style: theme.textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                              color: AppColors
                                                                  .textColorblue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  width * .04),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    const TextField(
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              'Enter character name',
                                                          hintStyle: TextStyle(
                                                              color: AppColors
                                                                  .kgreyColor),
                                                          border:
                                                              UnderlineInputBorder(),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .kpurple)),
                                                          enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: AppColors
                                                                      .kgreyColor)),
                                                          fillColor: Colors
                                                              .transparent),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8DEF8),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                pageViewController
                                                    ?.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back,
                                                color: AppColors.sliderColor,
                                                size: 23,
                                              ),
                                            )),
                                        const SizedBox(width: 5),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 1),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        TextButton(
                                            onPressed: () {
                                              pageViewController!.jumpToPage(4);
                                            },
                                            child: const Text("Skip to end",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textColorblue)))
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height * .03),
                                            Text(
                                              'Add a loved one to the story..',
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textColorblue,
                                                      fontSize: width * .08,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 10.0, 15.0, 0.0),
                                              child: Text(
                                                'Select one',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .kgreyColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20),
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(user!.uid)
                                                  .snapshots(), // Listening for real-time updates to the user document
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child: LoadingWidget());
                                                }

                                                if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'Error: ${snapshot.error}'));
                                                }

                                                if (snapshot.hasData) {
                                                  var userData = snapshot.data!
                                                          .data()
                                                      as Map<String, dynamic>;

                                                  // Deserialize the loved_once list
                                                  List<
                                                      Lovedonces> lovedonce = userData[
                                                              'loved_once'] !=
                                                          null
                                                      ? List<Lovedonces>.from(
                                                          userData['loved_once']
                                                              .map((item) =>
                                                                  Lovedonces
                                                                      .fromMap(
                                                                          item)))
                                                      : [];

                                                  if (lovedonce.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            'No loved one found.'));
                                                  }

                                                  return Wrap(
                                                    children:
                                                        List<Widget>.generate(
                                                      lovedonce.length,
                                                      (int index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: BlocBuilder<
                                                              AddCharacterBloc,
                                                              AddCharacterState>(
                                                            builder: (context,
                                                                state) {
                                                              return ChoiceChip(
                                                                side: const BorderSide(
                                                                    width: .4,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            152,
                                                                            152,
                                                                            152)),
                                                                shadowColor:
                                                                    Colors
                                                                        .black,
                                                                onSelected:
                                                                    (value) {
                                                                  context
                                                                      .read<
                                                                          AddCharacterBloc>()
                                                                      .add(
                                                                        AddLovedOnceEvent(
                                                                          lovedonce[
                                                                              index],
                                                                          selectedindex:
                                                                              index,
                                                                        ),
                                                                      );
                                                                },
                                                                selectedColor:
                                                                    AppColors
                                                                        .kpurple,
                                                                elevation: 5,
                                                                checkmarkColor:
                                                                    AppColors
                                                                        .kwhiteColor,
                                                                label: Text(
                                                                  (lovedonce[index].relation == "Mother" ||
                                                                          lovedonce[index].relation ==
                                                                              "Father" ||
                                                                          lovedonce[index].relation ==
                                                                              "GrandFather" ||
                                                                          lovedonce[index].relation ==
                                                                              "GrandMother")
                                                                      ? lovedonce[
                                                                              index]
                                                                          .relation
                                                                      : lovedonce[
                                                                              index]
                                                                          .name,
                                                                  style:
                                                                      TextStyle(
                                                                    color: state.selectedindex ==
                                                                            index
                                                                        ? AppColors
                                                                            .kwhiteColor
                                                                        : AppColors
                                                                            .kblackColor,
                                                                  ),
                                                                ),
                                                                selected: state
                                                                        .selectedindex ==
                                                                    index,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        12),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }
                                                return const Center(
                                                    child: Text(
                                                        'No loved one found.'));
                                              },
                                            ),
                                            addbutton(
                                                title: "Add a loved one",
                                                width: 200,
                                                theme: theme,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              const AddLovedOnesBottomSheet(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8DEF8),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                pageViewController
                                                    ?.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back,
                                                color: AppColors.sliderColor,
                                                size: 23,
                                              ),
                                            )),
                                        const SizedBox(width: 5),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 1),
                                        customSlider(percent: 0),
                                        TextButton(
                                            onPressed: () {
                                              pageViewController!.jumpToPage(4);
                                            },
                                            child: const Text("Skip to end",
                                                style: TextStyle(
                                                    color: AppColors
                                                        .textColorblue)))
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height * .03),
                                            Text(
                                              'Add a lesson to the story..',
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textColorblue,
                                                      fontSize: width * .08,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 10.0, 15.0, 0.0),
                                              child: Text(
                                                'Select one',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .kgreyColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 20),
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(user!.uid)
                                                  .snapshots(), // Listening for real-time updates to the user document
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child: LoadingWidget());
                                                }

                                                if (snapshot.hasError) {
                                                  return Center(
                                                      child: Text(
                                                          'Error: ${snapshot.error}'));
                                                }

                                                if (snapshot.hasData) {
                                                  var userData = snapshot.data!
                                                          .data()
                                                      as Map<String, dynamic>;

                                                  // Assuming 'lessons' is a List of strings for simplicity.
                                                  List<dynamic> lessons =
                                                      userData['lessons'] ?? [];

                                                  if (lessons.isEmpty) {
                                                    return const Center(
                                                        child: Text(
                                                            'No lessons found.'));
                                                  }

                                                  return Wrap(
                                                    children:
                                                        List<Widget>.generate(
                                                            lessons.length,
                                                            (int index) {
                                                      // Accessing each lesson by index
                                                      var lesson = lessons[
                                                          index]; // Get the lesson data for the current index
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: ChoiceChip(
                                                          onSelected: (value) {
                                                            // Trigger an event or do something with the selected lesson
                                                            context
                                                                .read<
                                                                    AddCharacterBloc>()
                                                                .add(AddlessonEvent(
                                                                    lesson,
                                                                    selectedindexlesson:
                                                                        index));

                                                            // Print the lesson to check the data
                                                          },
                                                          side:
                                                              const BorderSide(
                                                                  width: .4,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          152,
                                                                          152,
                                                                          152)),
                                                          shadowColor:
                                                              Colors.black,
                                                          selectedColor:
                                                              AppColors.kpurple,
                                                          elevation: 3,
                                                          checkmarkColor:
                                                              AppColors
                                                                  .kwhiteColor,
                                                          label: Text(
                                                            lesson
                                                                .toString(), // Display the lesson name or string representation
                                                            style: TextStyle(
                                                              color: state.selectedindexlesson ==
                                                                      index
                                                                  ? AppColors
                                                                      .kwhiteColor
                                                                  : AppColors
                                                                      .kblackColor,
                                                            ),
                                                          ),
                                                          selected: state
                                                                  .selectedindexlesson ==
                                                              index, // Set the selection based on index
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                }

                                                return const Center(
                                                    child: Text(
                                                        'No lessons found.'));
                                              },
                                            ),
                                            addbutton(
                                                title: "Add a lesson ",
                                                width: 170,
                                                theme: theme,
                                                onTap: () async {
                                                  await showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    enableDrag: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return GestureDetector(
                                                        onTap: () =>
                                                            FocusScope.of(
                                                                    context)
                                                                .unfocus(),
                                                        child: Padding(
                                                          padding: MediaQuery
                                                              .viewInsetsOf(
                                                                  context),
                                                          child:
                                                              const AddLessonBottomSheet(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8DEF8),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                pageViewController
                                                    ?.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.ease,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back,
                                                color: AppColors.sliderColor,
                                                size: 23,
                                              ),
                                            )),
                                        const SizedBox(width: 5),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 0),
                                        customSlider(percent: 1),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height * .03),
                                            Text(
                                              'Genre of the story..',
                                              style: theme
                                                  .textTheme.displaySmall!
                                                  .copyWith(
                                                      color: AppColors
                                                          .textColorblue,
                                                      fontSize: width * .08,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0.0, 10.0, 15.0, 0.0),
                                              child: Text(
                                                'Select one',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .kgreyColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: width * .05),
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Funny",
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateGenreEvent(
                                                              'Funny'));
                                                },
                                                selected: state.genre == "Funny"
                                                    ? true
                                                    : false),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Horror",
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateGenreEvent(
                                                              'Horror'));
                                                },
                                                selected:
                                                    state.genre == "Horror"
                                                        ? true
                                                        : false),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Adventure",
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateGenreEvent(
                                                              'Adventure'));
                                                },
                                                selected:
                                                    state.genre == "Adventure"
                                                        ? true
                                                        : false),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Action",
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateGenreEvent(
                                                              'Action'));
                                                },
                                                selected:
                                                    state.genre == "Action"
                                                        ? true
                                                        : false),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Sci-fi",
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateGenreEvent(
                                                              'Sci-fi'));
                                                },
                                                selected:
                                                    state.genre == "Sci-fi"
                                                        ? true
                                                        : false),
                                            choicechipbutton(
                                                theme: theme,
                                                title: "Mystery",
                                                ontap: () async {
                                                  context
                                                      .read<AddCharacterBloc>()
                                                      .add(
                                                          const UpdateGenreEvent(
                                                              'Mystery'));
                                                },
                                                selected:
                                                    state.genre == "Mystery"
                                                        ? true
                                                        : false),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * .16,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .85,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  state.currentPageIndex == 2 ||
                                          state.currentPageIndex == 3
                                      ? Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              pageViewController?.nextPage(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.ease,
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              foregroundColor:
                                                  AppColors.kwhiteColor,
                                              backgroundColor:
                                                  AppColors.kwhiteColor,
                                            ),
                                            child: Text(
                                              "Skip",
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(
                                                color: AppColors.kpurple,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        User? user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user == null) return;

                                        DocumentSnapshot doc =
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user.uid)
                                                .get();

                                        storydata.child_name =
                                            doc['child_name'];
                                        if (state.currentPageIndex == 4) {
                                          context.push('/CreateStoryPage',
                                              extra: storydata);
                                        } else {
                                          if (state.currentPageIndex == 0 &&
                                              (state.language ==
                                                      Language.English ||
                                                  state.language ==
                                                      Language.Hindi) &&
                                              (state.musicAndSpeed ==
                                                      "Bedtime" ||
                                                  state.musicAndSpeed ==
                                                      "Playtime")) {
                                            pageViewController?.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          } else if (state.currentPageIndex ==
                                                  1 &&
                                              state.charactorname != null) {
                                            pageViewController?.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          } else if (state.currentPageIndex ==
                                                  2 &&
                                              state.lovedOnce != null) {
                                            pageViewController?.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          } else if (state.currentPageIndex ==
                                                  3 &&
                                              state.lessons != null) {
                                            pageViewController?.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          }
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        foregroundColor:
                                            (state.currentPageIndex == 0 &&
                                                    (state.language ==
                                                            Language.English ||
                                                        state.language ==
                                                            Language.Hindi) &&
                                                    (state.musicAndSpeed ==
                                                            "Bedtime" ||
                                                        state.language ==
                                                            "Playtime"))
                                                ? AppColors.textColorblue
                                                : AppColors.textColorWhite,
                                        backgroundColor: (state
                                                            .currentPageIndex ==
                                                        0 &&
                                                    (state.language ==
                                                            Language.English ||
                                                        state.language ==
                                                            Language.Hindi) &&
                                                    (state.musicAndSpeed ==
                                                            "Bedtime" ||
                                                        state.musicAndSpeed ==
                                                            "Playtime")) ||
                                                (state.currentPageIndex == 1 &&
                                                    state.charactorname !=
                                                        null) ||
                                                (state.currentPageIndex == 2 &&
                                                    state.lovedOnce != null) ||
                                                (state.currentPageIndex == 3 &&
                                                    state.lessons != null) ||
                                                state.currentPageIndex == 4
                                            ? AppColors.textColorblue
                                            : AppColors.textColorWhite,
                                      ),
                                      child: Text(
                                        "Continue",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: (state.currentPageIndex == 0 &&
                                                      (state.language ==
                                                              Language
                                                                  .English ||
                                                          state.language ==
                                                              Language.Hindi) &&
                                                      (state.musicAndSpeed ==
                                                              "Bedtime" ||
                                                          state.musicAndSpeed ==
                                                              "Playtime")) ||
                                                  (state.currentPageIndex ==
                                                          1 &&
                                                      state.charactorname !=
                                                          null) ||
                                                  (state.currentPageIndex ==
                                                          2 &&
                                                      state.lovedOnce !=
                                                          null) ||
                                                  (state.currentPageIndex ==
                                                          3 &&
                                                      state.lessons != null) ||
                                                  state.currentPageIndex == 4
                                              ? AppColors.textColorWhite
                                              : AppColors.textColorblue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget choicechipbutton(
          {required ThemeData theme,
          required String title,
          required VoidCallback ontap,
          required bool selected}) =>
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 48,
          child: ElevatedButton(
            iconAlignment: IconAlignment.start,
            onPressed: ontap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              foregroundColor: selected == true
                  ? AppColors.buttonblue
                  : AppColors.buttonwhite,
              backgroundColor: selected == true
                  ? AppColors.buttonblue
                  : AppColors.buttonwhite,
            ),
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.check,
                      color: AppColors.kwhiteColor,
                      size: 18,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(title,
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: selected == true
                              ? AppColors.textColorWhite
                              : AppColors.textColorblack,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ),
      );
  Widget customSlider({required double percent}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
        child: LinearPercentIndicator(
          percent: percent,
          lineHeight: 9.0,
          animation: true,
          animateFromLastPercent: true,
          progressColor: AppColors.sliderColor,
          backgroundColor: AppColors.sliderBackground,
          barRadius: const Radius.circular(20.0),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget addbutton(
      {required ThemeData theme,
      required String title,
      required double width,
      required VoidCallback onTap,
      double height = 47}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 178, 178, 178)),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.textColorblack,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(title,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500)),
                ])),
      ),
    );
  }
}

class FormFieldController<T> extends ValueNotifier<T?> {
  FormFieldController(this.initialValue) : super(initialValue);

  final T? initialValue;

  void reset() => value = initialValue;
  void update() => notifyListeners();
}

class FormListFieldController<T> extends FormFieldController<List<T>> {
  final List<T>? _initialListValue;

  FormListFieldController(super.initialValue)
      : _initialListValue = List<T>.from(initialValue ?? []);

  @override
  void reset() => value = List<T>.from(_initialListValue ?? []);
}

Future<List<Lovedonces>> fetchLovedOnes() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return [];

  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  List<dynamic> lovedOnceData = doc['loved_once'] ?? [];

  // Convert to a list of Lovedonces objects
  return lovedOnceData.map((item) => Lovedonces.fromMap(item)).toList();
}
