import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FeedbackBloc() : super(FeedbackInitial()) {
    on<SubmitFeedbackEvent>(_submitFeedback);
    on<CheckFeedbackEvent>(_checkFeedback);
    on<UpdateLikedDislikedEvent>(_updateLikedDisliked);
    on<UpdateRatingEvent>(_updateRating);
  }

  Future<void> _submitFeedback(
      SubmitFeedbackEvent event, Emitter<FeedbackState> emit) async {
    try {
      emit(FeedbackLoading());

      await _firestore.collection('feedback').doc(event.userId).set({
        'rating': event.rating,
        'questionsLikedDisliked': event.questionsLikedDisliked,
        'createdAt': FieldValue.serverTimestamp(),
        'userRef': event.userId,
      });

      emit(FeedbackSubmitted());
    } catch (e) {
      emit(FeedbackError('Error submitting feedback: ${e.toString()}'));
    }
  }

  Future<void> _checkFeedback(
      CheckFeedbackEvent event, Emitter<FeedbackState> emit) async {
    try {
      emit(FeedbackLoading());

      final docSnapshot =
          await _firestore.collection('feedback').doc(event.userId).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final questionsLikedDisliked =
            _parseQuestionsMap(data['questionsLikedDisliked']);
        final previousRating = data['rating'] as int;

        emit(FeedbackUpdated(
          rating: previousRating,
          questionsLikedDisliked: questionsLikedDisliked,
        ));
      } else {
        emit(FeedbackInitial());
      }
    } catch (e) {
      emit(FeedbackError('Error checking feedback: ${e.toString()}'));
    }
  }

  void _updateLikedDisliked(
      UpdateLikedDislikedEvent event, Emitter<FeedbackState> emit) {
    if (state is FeedbackUpdated) {
      final currentState = state as FeedbackUpdated;
      final updatedMap = Map<String, Map<String, bool>>.from(
          currentState.questionsLikedDisliked);

      updatedMap[event.question] = <String, bool>{
        'liked': event.liked,
        'disliked': !event.liked,
      };

      emit(FeedbackUpdated(
        rating: currentState.rating,
        questionsLikedDisliked: updatedMap,
      ));
    }
  }

  void _updateRating(UpdateRatingEvent event, Emitter<FeedbackState> emit) {
    if (state is FeedbackUpdated) {
      final currentState = state as FeedbackUpdated;

      emit(FeedbackUpdated(
        rating: event.rating,
        questionsLikedDisliked: currentState.questionsLikedDisliked,
      ));
    } else {
      emit(FeedbackUpdated(
        rating: event.rating,
        questionsLikedDisliked: _initialQuestions(),
      ));
    }
  }

  Map<String, Map<String, bool>> _initialQuestions() {
    return <String, Map<String, bool>>{
      'Story line': <String, bool>{'liked': false, 'disliked': false},
      'Tone of narration': <String, bool>{'liked': false, 'disliked': false},
      'Voice modulation': <String, bool>{'liked': false, 'disliked': false},
      'Background music': <String, bool>{'liked': false, 'disliked': false},
      'User journey': <String, bool>{'liked': false, 'disliked': false},
    };
  }

  Map<String, Map<String, bool>> _parseQuestionsMap(Map<String, dynamic> raw) {
    return raw.map((key, value) {
      final innerMap =
          (value as Map<String, dynamic>).map((k, v) => MapEntry(k, v as bool));
      return MapEntry(key, innerMap);
    });
  }
}
