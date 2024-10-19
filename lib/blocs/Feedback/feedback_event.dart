import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object?> get props => [];
}

class SubmitFeedbackEvent extends FeedbackEvent {
  final int rating;
  final Map<String, Map<String, bool>> questionsLikedDisliked;
  final String userId;
  final DocumentReference<Map<String, dynamic>> userref;
  const SubmitFeedbackEvent({
    required this.userref,
    required this.rating,
    required this.questionsLikedDisliked,
    required this.userId,
  });

  @override
  List<Object?> get props => [rating, questionsLikedDisliked, userId, userref];
}

class CheckFeedbackEvent extends FeedbackEvent {
  final String userId;

  const CheckFeedbackEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UpdateLikedDislikedEvent extends FeedbackEvent {
  final String question;
  final bool liked;

  const UpdateLikedDislikedEvent({
    required this.question,
    required this.liked,
  });

  @override
  List<Object?> get props => [question, liked];
}

class UpdateRatingEvent extends FeedbackEvent {
  final int rating;

  const UpdateRatingEvent(this.rating);

  @override
  List<Object?> get props => [rating];
}
