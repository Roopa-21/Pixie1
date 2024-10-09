import 'package:cloud_firestore/cloud_firestore.dart';

class FetchStoryRepository {
  final FirebaseFirestore _firestore;

  FetchStoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchStories(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('fav_storys')
          .where('user_ref', isEqualTo: userId)
          .get();

      // Parse the data into a list of maps
      List<Map<String, dynamic>> stories = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return stories;
    } catch (e) {
      throw Exception('Failed to fetch stories: $e');
    }
  }
}
