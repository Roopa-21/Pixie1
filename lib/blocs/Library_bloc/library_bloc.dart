import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Library_bloc/library_event.dart';
import 'package:pixieapp/blocs/Library_bloc/library_state.dart';
import 'package:pixieapp/repositories/library_repository.dart';

class FetchStoryBloc extends Bloc<FetchStoryEvent, StoryState> {
  final FetchStoryRepository _fetchStoryRepository;

  FetchStoryBloc(this._fetchStoryRepository) : super(const StoryInitial()) {
    on<FetchStories>(_onFetchStories);
    on<AddfilterEvent>(_onAddFilter);
  }

  Future<void> _onFetchStories(
      FetchStories event, Emitter<StoryState> emit) async {
    emit(const StoryLoading());
    try {
      // Fetch all stories for the user
      final stories = await _fetchStoryRepository.fetchStories(event.userId);

      // Store the original stories and emit them along with the default filter (empty)
      emit(StoryLoaded(stories: stories, filteredStories: stories, filter: ''));
    } catch (e) {
      emit(StoryError('Failed to fetch stories: ${e.toString()}'));
    }
  }

  void _onAddFilter(AddfilterEvent event, Emitter<StoryState> emit) {
    if (state is StoryLoaded) {
      final loadedState = state as StoryLoaded;

      // Apply the new filter to the original list of stories (not the filtered ones)
      final filteredStories = _applyFilter(loadedState.stories, event.filter);

      // Emit the updated state with both the original list and filtered list
      emit(StoryLoaded(
          stories: loadedState.stories, // Keep the original stories
          filteredStories: filteredStories, // Pass the filtered stories
          filter: event.filter));
    } else {
      emit(StoryError('Cannot apply filter. No stories available.'));
    }
  }

  // Apply filter to the list of stories
  List<Map<String, dynamic>> _applyFilter(
      List<Map<String, dynamic>> stories, String filter) {
    if (filter.isEmpty) return stories;

    return stories.where((story) {
      if (filter == 'English' || filter == 'Hindi') {
        return story['language']?.toLowerCase() == filter.toLowerCase();
      } else if (filter == 'Bedtime' || filter == 'Playtime') {
        return story['storytype']?.toLowerCase() == filter.toLowerCase();
      } else if (filter == 'Liked') {
        return story['isfav'] == true;
      }
      return true;
    }).toList();
  }
}
