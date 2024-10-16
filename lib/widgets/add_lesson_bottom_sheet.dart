import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/pages/home/home_page.dart';

class AddLessonBottomSheet extends StatefulWidget {
  const AddLessonBottomSheet({super.key});

  @override
  State<AddLessonBottomSheet> createState() => _AddLessonBottomSheetState();
}

TextEditingController lessoncontroller = TextEditingController();

class _AddLessonBottomSheetState extends State<AddLessonBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: AppColors.bottomSheetBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Add a lesson",
                style: theme.textTheme.displayMedium?.copyWith(
                    color: AppColors.textColorblue,
                    fontSize: 34,
                    fontWeight: FontWeight.w400)),
            const SizedBox(height: 25),
            TextField(
              controller: lessoncontroller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Add a lesson",
                hintStyle: TextStyle(color: Color.fromARGB(255, 199, 199, 199)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    strokeAlign: 5,
                    color: AppColors.textColorblue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textColorblue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textColorblue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _addLesson(
                      context: context, lesson: lessoncontroller.text);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: AppColors.buttonblue,
                    backgroundColor: AppColors.buttonblue),
                child: Text("Add",
                    style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textColorWhite,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _addLesson({
  required BuildContext context,
  required String lesson,
}) async {
  // Get the current authenticated user
  User? user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    // If no user is signed in, show an error
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("No user is signed in"),
      backgroundColor: Colors.red,
    ));
    return;
  }

  // Get the UID of the authenticated user
  final String userId = user.uid;

  if (lesson.isNotEmpty) {
    try {
      // Capitalize the first letter of the lesson
      String capitalizedLesson = lesson[0].toUpperCase() + lesson.substring(1);

      // Reference to the user's document
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Add the new lesson to the existing array using arrayUnion
      await userDocRef.update({
        'lessons': FieldValue.arrayUnion([capitalizedLesson]),
      });
      context.pop();
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text("Lesson added successfully!"),
      //   backgroundColor: Colors.green,
      // ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add lesson: $e"),
        backgroundColor: Colors.red,
      ));
    }
  } else {
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text("Please enter a lesson"),
    //   backgroundColor: Colors.orange,
    // ));
  }
}
