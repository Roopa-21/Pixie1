import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/repositories/story_repository.dart';
import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryRepository storyRepository;

  StoryBloc({required this.storyRepository}) : super(StoryInitial()) {
    on<GenerateStoryEvent>(_onGenerateStoryEvent);
    on<SpeechToTextEvent>(_onSpeechToTextEvent);
    // on<AddMusicEvent>(_onAddmusicEvent);
    on<StartRecordnavbarEvent>(_onStartRecordnavbarEvent);
    on<AddMusicEvent>((event, emit) => RecordaudioScreen());
  }

  // Event handler for GenerateStoryEvent
  Future<void> _onGenerateStoryEvent(
      GenerateStoryEvent event, Emitter<StoryState> emit) async {
    emit(StoryLoading());
    try {
      final storyResponse = await storyRepository.generateStory(
        event: event.event,
        age: event.age,
        topic: event.topic,
        child_name: event.childName,
        gender: event.gender,
        relation: event.relation,
        relative_name: event.relativeName,
        genre: event.genre,
        lessons: event.lessons,
        length: event.length,
        language: event.language,
      );

      emit(StorySuccess(story: storyResponse));
      // try {
      //   final audioFile = await storyRepository.speechToText(
      //     text: storyResponse['title']! + storyResponse['story']!,
      //     language: event.language,
      //   );
      //   emit(StoryAudioSuccess(audioFile: audioFile));
      // } catch (error) {
      //   print(error);
      //   emit(StoryFailure(error: error.toString()));
      // }
    } catch (error) {
      emit(StoryFailure(error: error.toString()));
    }
  }

  // Event handler for SpeechToTextEvent
  Future<void> _onSpeechToTextEvent(
      SpeechToTextEvent event, Emitter<StoryState> emit) async {
    emit(StoryLoading());
    try {
      final audioFile = await storyRepository.speechToText(
        text: event.text,
        language: event.language,
      );
      emit(StoryAudioSuccess(audioFile: audioFile));
    } catch (error) {
      emit(StoryFailure(error: error.toString()));
    }
  }

  // Event handler for SpeechToTextEvent
  Future<void> _onAddmusicEvent(
      AddMusicEvent event, Emitter<StoryState> emit) async {
    emit(StoryLoading());
    try {
      final audioFile = await storyRepository.addMusicToAudio(
        event: event.event,
        audioFile: event.audiofile,
      );
      emit(RecordedStoryAudioSuccess(musicAddedaudioFile: audioFile));
    } catch (error) {
      emit(StoryFailure(error: error.toString()));
    }
  }

  // Event handler for StartRecordnavbarEvent
  void _onStartRecordnavbarEvent(
      StartRecordnavbarEvent event, Emitter<StoryState> emit) {
    emit(StartRecordaudioScreen());
  }
}
