import 'package:equatable/equatable.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object?> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackSubmitted extends FeedbackState {}

class FeedbackExists extends FeedbackState {
  final Map<String, dynamic> feedbackData;

  const FeedbackExists(this.feedbackData);

  @override
  List<Object?> get props => [feedbackData];
}

class FeedbackUpdated extends FeedbackState {
  final int rating;
  final Map<String, Map<String, bool>> questionsLikedDisliked;

  const FeedbackUpdated({
    required this.rating,
    required this.questionsLikedDisliked,
  });

  @override
  List<Object?> get props => [rating, questionsLikedDisliked];
}

class FeedbackError extends FeedbackState {
  final String message;

  const FeedbackError(this.message);

  @override
  List<Object?> get props => [message];
}
