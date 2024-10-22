import 'package:equatable/equatable.dart';

abstract class StoryState extends Equatable {
  final String error;
  final String filter;

  const StoryState({required this.error, required this.filter});

  @override
  List<Object?> get props => [error, filter];
}

class StoryInitial extends StoryState {
  const StoryInitial() : super(error: '', filter: 'All');
}

class StoryLoading extends StoryState {
  const StoryLoading() : super(error: '', filter: '');
}


class StoryLoaded extends StoryState {
  final List<Map<String, dynamic>> stories;
  final List<Map<String, dynamic>> filteredStories;

  const StoryLoaded({
    required this.stories,
    required this.filteredStories,
    String filter = '',
    String error = '',
  }) : super(error: error, filter: filter);

  @override
  List<Object?> get props => [stories, filteredStories, filter, error];
}

class StoryError extends StoryState {
  const StoryError(String error) : super(error: error, filter: '');

  @override
  List<Object?> get props => [error];
}

extension CopyWithStoryState on StoryState {
  StoryState copyWith({String? filter, String? error}) {
    return StoryLoaded(
      stories: (this is StoryLoaded) ? (this as StoryLoaded).stories : [],
      filteredStories:
          (this is StoryLoaded) ? (this as StoryLoaded).filteredStories : [],
      filter: filter ?? this.filter,
      error: error ?? this.error,
    );
  }
}
