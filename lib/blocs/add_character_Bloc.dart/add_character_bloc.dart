import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/models/story_model.dart';
import 'add_character_event.dart';
import 'add_character_state.dart';

class AddCharacterBloc extends Bloc<AddCharacterEvent, AddCharacterState> {
  AddCharacterBloc()
      : super(const AddCharacterState(
            currentPageIndex: 0,
            language: Language.English,
            lovedOnce: null,
            selectedindex: -1,
            selectedindexlesson: -1,
            genre: 'Funny',
            musicAndSpeed: 'Bedtime')) {
    // Handle page change events
    on<PageChangeEvent>((event, emit) {
      emit(state.copyWith(currentPageIndex: event.currentPageIndex));
    });

    // Handle language change events
    on<LanguageChangeEvent>((event, emit) {
      emit(state.copyWith(language: event.language));
    });

    // Handle resetting lovedOnce to null
    on<ResetLovedOnceEvent>((event, emit) {
      emit(state.copyWith(lovedOnce: null));
    });
    // handle Loved once change event
    on<AddLovedOnceEvent>((event, emit) {
      emit(state.copyWith(
          lovedOnce: event.lovedOnce, selectedindex: event.selectedindex));
    });

    // Handle resetting lovedOnce to null
    on<ResetlessonEvent>((event, emit) {
      emit(state.copyWith(lessons: null));
    });
    // handle Loved once change event
    on<AddlessonEvent>((event, emit) {
      emit(state.copyWith(
          lessons: event.lesson,
          selectedindexlesson: event.selectedindexlesson));
    });
    // Handle update genre event
    on<UpdateGenreEvent>((event, emit) {
      emit(state.copyWith(genre: event.genre));
    });
    on<UpdateMusicandspeedEvent>((event, emit) {
      emit(state.copyWith(musicAndSpeed: event.musicandspeed));
    });
  }
}
