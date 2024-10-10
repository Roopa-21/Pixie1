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

      // Save feedback to Firebase
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
        emit(FeedbackExists(docSnapshot.data()!));
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
      final updatedMap = {...currentState.questionsLikedDisliked};

      // Ensure both liked and disliked are managed correctly
      updatedMap[event.question] = {
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
    if (state is FeedbackUpdated || state is FeedbackInitial) {
      final currentState = state is FeedbackUpdated
          ? state as FeedbackUpdated
          : FeedbackUpdated(
              rating: 0, questionsLikedDisliked: _initialQuestions());

      emit(FeedbackUpdated(
        rating: event.rating,
        questionsLikedDisliked: currentState.questionsLikedDisliked,
      ));
    }
  }

  Map<String, Map<String, bool>> _initialQuestions() {
    return {
      'Story line': {'liked': false, 'disliked': false},
      'Tone of narration': {'liked': false, 'disliked': false},
      'Voice modulation': {'liked': false, 'disliked': false},
      'Background music': {'liked': false, 'disliked': false},
      'User journey': {'liked': false, 'disliked': false},
    };
  }
}
