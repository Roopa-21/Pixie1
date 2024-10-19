import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Getdata extends StatefulWidget {
  final DocumentReference docRef;

  const Getdata({super.key, required this.docRef});

  @override
  State<Getdata> createState() => _GetdataState();
}

List<bool> answer1 = [];
List<bool> answer2 = [];
List<bool> answer3 = [];
List<bool> answer4 = [];
List<bool> answer5 = [];
Future<List<bool>> getappfeedback(
  DocumentReference<Map<String, dynamic>>? docRef,
  String question,
) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  try {
    if (docRef == null) {
      print('Document reference is null.');
      return [false, false]; // Default values if docRef is null
    }

    // Fetch the document from Firestore
    final docSnapshot = await docRef.get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data();
      if (data != null &&
          data['questionsLikedDisliked'] is Map<String, dynamic>) {
        final questionsMap =
            data['questionsLikedDisliked'] as Map<String, dynamic>;

        // Check if the question exists
        if (questionsMap.containsKey(question)) {
          final questionAnswers =
              questionsMap[question] as Map<String, dynamic>;
          final bool liked = questionAnswers['liked'] ?? false;
          final bool disliked = questionAnswers['disliked'] ?? false;
          return [liked, disliked]; // Return as a list of booleans
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

  // Return default values in case of any failure
  return [false, false];

  /// MODIFY CODE ONLY ABOVE THIS LINE
}

class _GetdataState extends State<Getdata> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
