import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';

class LessonBottomsheet extends StatefulWidget {
  const LessonBottomsheet({super.key});

  @override
  State<LessonBottomsheet> createState() => _LessonBottomsheetState();
}

class _LessonBottomsheetState extends State<LessonBottomsheet> {
  List<dynamic> lessons = []; // List to store lessons

  @override
  void initState() {
    super.initState();
    _getLessons().then((lessonslist) {
      setState(() {
        lessons = lessonslist;
      });
    });
    fetchSuggestedLessons().then((suggestedlessonslist) {
      setState(() {
        lessons.addAll(suggestedlessonslist);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) => Container(
        height: MediaQuery.of(context).size.height * .6,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.bottomSheetBackground,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a lesson to the story..',
                style: theme.textTheme.displayMedium?.copyWith(
                  color: AppColors.textColorblue,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              // Wrapping the Wrap widget inside a Flexible + SingleChildScrollView
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 0.0, // Space between chips
                    runSpacing: 0.0, // Space between rows
                    children:
                        List<Widget>.generate(lessons.length, (int index) {
                      var lesson = lessons[index]; // Get the lesson data
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ChoiceChip(
                          onSelected: (value) {
                            context.read<AddCharacterBloc>().add(
                                  AddlessonEvent(
                                    lesson,
                                    selectedindexlesson: index,
                                  ),
                                );
                            context.pop();
                          },
                          side: const BorderSide(
                            width: .4,
                            color: Color.fromARGB(255, 152, 152, 152),
                          ),
                          shadowColor: Colors.black,
                          selectedColor: AppColors.kpurple,
                          elevation: 3,
                          checkmarkColor: AppColors.kwhiteColor,
                          label: Text(
                            lesson.toString(),
                            style: TextStyle(
                              color: state.selectedindexlesson == index
                                  ? AppColors.kwhiteColor
                                  : AppColors.kblackColor,
                            ),
                          ),
                          selected: state.selectedindexlesson == index,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> _getLessons() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User is not authenticated")),
      );
      return [];
    } else {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        var userData = userDoc.data() as Map<String, dynamic>?;
        return userData?['lessons'] ?? [];
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load lessons: $e")),
        );
        return [];
      }
    }
  }

  Future<List<String>> fetchSuggestedLessons() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<String> lessonStrings = [];
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('admin_data').limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        var data = querySnapshot.docs.first.data() as Map<String, dynamic>;

        List<dynamic> fetchedLessons = data['suggested_lessons'] ?? [];
        lessonStrings = fetchedLessons.map((e) => e.toString()).toList();

        return lessonStrings;
      } else {
        print('No document found in admin_data.');
        return lessonStrings;
      }
    } catch (e) {
      print('Error fetching suggested lessons: $e');
      return lessonStrings;
    }
  }
}
