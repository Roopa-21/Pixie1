import 'package:cloud_firestore/cloud_firestore.dart';

class FetchStoryRepository1 {
  final FirebaseFirestore _firestore;

  FetchStoryRepository1({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchStories(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('fav_storys')
          .where('user_ref', isEqualTo: userId)
          .get();

      // Parse the data into a list of maps, including the DocumentReference
      List<Map<String, dynamic>> stories = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'storytype': doc['storytype'],
          'audiofile': doc['audiofile'],
          'isfav': doc['isfav'],
          'language': doc['language'],
          'reference': doc.reference, // Include the DocumentReference
        };
      }).toList();

      return stories;
    } catch (e) {
      throw Exception('Failed to fetch stories: $e');
    }
  }
}
