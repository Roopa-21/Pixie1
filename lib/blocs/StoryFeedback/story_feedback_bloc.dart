import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'story_feedback_event.dart';
import 'story_feedback_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoryFeedbackBloc extends Bloc<StoryFeedbackEvent, StoryFeedbackState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StoryFeedbackBloc() : super(const StoryFeedbackState()) {
    on<UpdateRatingEvent>((event, emit) {
      emit(state.copyWith(rating: event.rating));
    });
 on<UpdatedislikeStateEvent>((event, emit) {
      emit(DislikeStateUpdated(isDisliked: event.isDisliked));
    });
    on<ToggleIssueEvent>((event, emit) {
      final issues = List<String>.from(state.issues);
      if (issues.contains(event.issue)) {
        issues.remove(event.issue);
      } else {
        issues.add(event.issue);
      }
      emit(state.copyWith(issues: issues));
    });

    on<AddCustomIssueEvent>((event, emit) {
      final issues = List<String>.from(state.issues)..add(event.issue);
      emit(state.copyWith(issues: issues));
    });

    on<SubmitFeedbackEvent>((event, emit) async {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userRef =
            FirebaseFirestore.instance.collection('users').doc(user!.uid);
        await _firestore.collection('story_feedback').add({
          'user_ref': userRef,
          'rating': state.rating,
          'issues': state.issues ?? "Not added",
          'created_time': FieldValue.serverTimestamp() ?? DateTime.now(),
          "story_title": event.story_title ?? "Not added",
          "story": event.story ?? "Not added",
          "audio_path": event.audiopath ?? ''
        });
      }
      emit(state.copyWith(issues: []));
      emit(state.copyWith(rating: 0));
    });
  }
}
