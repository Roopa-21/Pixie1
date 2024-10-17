import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class StoryFeedbackEvent extends Equatable {
  const StoryFeedbackEvent();

  @override
  List<Object?> get props => [];
}

class UpdateRatingEvent extends StoryFeedbackEvent {
  final int rating;

  const UpdateRatingEvent(this.rating);

  @override
  List<Object?> get props => [rating];
}

class ToggleIssueEvent extends StoryFeedbackEvent {
  final String issue;

  const ToggleIssueEvent(this.issue);

  @override
  List<Object?> get props => [issue];
}

class AddCustomIssueEvent extends StoryFeedbackEvent {
  final String issue;

  const AddCustomIssueEvent(this.issue);

  @override
  List<Object?> get props => [issue];
}

class SubmitFeedbackEvent extends StoryFeedbackEvent {
  final String story_title;
  final String story;
  final String audiopath;

  SubmitFeedbackEvent(
      {required this.story_title,
      required this.story,
      required this.audiopath});
  @override
  List<Object?> get props => [story_title, story, audiopath];
}
