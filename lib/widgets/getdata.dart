// Automatic FlutterFlow imports
// Imports custom functions
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class Getdata extends StatefulWidget {
  const Getdata({
    super.key,
    this.width,
    this.height,
    required this.docRef,
  });

  final double? width;
  final double? height;
  final DocumentReference docRef;

  @override
  State<Getdata> createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
  // Questions
  final List<String> questions = [
    'Story line',
    'Pronunciation',
    'Voice modulation',
    'Background music',
    'User journey',
  ];

  // Lists to store the answers
  List<List<bool>> answers = [[], [], [], [], []];

  // Function to fetch answers from Firestore
  Future<void> updateAnswers() async {
    for (int i = 0; i < questions.length; i++) {
      answers[i] = await getAppFeedback(widget.docRef, questions[i]);
    }
  }

  // Function to fetch a specific question's feedback
  Future<List<bool>> getAppFeedback(
      DocumentReference<Object?> docRef, String question) async {
    try {
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>?;

        if (data != null &&
            data['questionsLikedDisliked'] is Map<String, dynamic>) {
          final questionsMap =
              data['questionsLikedDisliked'] as Map<String, dynamic>;

          if (questionsMap.containsKey(question)) {
            final questionAnswers =
                questionsMap[question] as Map<String, dynamic>;
            final bool liked = questionAnswers['liked'] ?? false;
            final bool disliked = questionAnswers['disliked'] ?? false;
            return [liked, disliked];
          } else {
            print('Question not found: $question');
          }
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }

    return [false, false]; // Default values in case of failure
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: updateAnswers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while fetching data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle error scenario
          return const Center(child: Text('Error fetching data'));
        } else {
          // Build the UI with fetched data
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return buildFeedbackItem(questions[index], answers[index]);
              },
            ),
          );
        }
      },
    );
  }

  // Widget to display a feedback item
  Widget buildFeedbackItem(String question, List<bool> answers) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffCBB4F7)),
          borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Text(question),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.thumb_up_alt,
                      color: answers[0]
                          ? const Color(0xff612ACE)
                          : const Color(0xffCBB4F7),
                    )),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.thumb_down_alt,
                      color: answers[1]
                          ? const Color(0xff612ACE)
                          : const Color(0xffCBB4F7),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
