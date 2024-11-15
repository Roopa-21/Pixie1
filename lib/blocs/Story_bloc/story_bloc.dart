import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixieapp/repositories/story_repository.dart';
import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryRepository storyRepository;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _audioPath;
  StoryBloc({required this.storyRepository}) : super(StoryInitial()) {
    _initializeRecorder();
    on<GenerateStoryEvent>(_onGenerateStoryEvent);
    on<SpeechToTextEvent>(_onSpeechToTextEvent);

    on<AddMusicEvent>(_onAddmusicEvent);
    on<StartRecordnavbarEvent>(_onStartRecordnavbarEvent);

    on<StartRecordingEvent>((event, emit) async => await _startRecording(emit));
    on<StopRecordingEvent>((event, emit) async => await _stopRecording(emit));
  }
  _initializeRecorder() async {
    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> _startRecording(Emitter<StoryState> emit) async {
    try {
      var status = await Permission.microphone.status;
      if (status.isDenied || status.isRestricted) {
        status = await Permission.microphone.request();
      }

      if (status.isGranted) {
        final Directory? externalDir = await getExternalStorageDirectory();
        final String externalPath = '${externalDir?.path}/Music';
        await Directory(externalPath).create(recursive: true);
        _audioPath =
            '$externalPath/audio_${DateTime.now().millisecondsSinceEpoch}.aac';

        emit(AudioRecording());
        await _recorder.startRecorder(toFile: _audioPath);
      } else {
        emit(AudioUploadError(
            'Microphone permission is required to start recording.'));
      }
    } catch (e) {
      emit(AudioUploadError('Failed to start recording: $e'));
    }
  }

  Future<void> _stopRecording(Emitter<StoryState> emit) async {
    try {
      await _recorder.stopRecorder();
      if (_audioPath != null) {
        emit(AudioStopped(audioPath: _audioPath!));
      }
    } catch (e) {
      emit(AudioUploadError('Failed to stop recording: $e'));
    }
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
      print(audioFile);
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
