import 'dart:io';

abstract class BottomNavState {}

class BottomNavBlocInitial extends BottomNavState {}

class ListenStateUpdated extends BottomNavState {
  final bool isListening;

  ListenStateUpdated({required this.isListening});
}

class ErrorState extends BottomNavState {
  final String message;

  ErrorState({required this.message});
}

class ReadAndRecordStateUpdated extends BottomNavState {
  final bool isRecording;

  ReadAndRecordStateUpdated({required this.isRecording});
}

class AudioInitial extends BottomNavState {}

class AudioRecording extends BottomNavState {}

class AudioRecorded extends BottomNavState {
  final String audioPath;

  AudioRecorded({required this.audioPath});
}

class AudioStopped extends BottomNavState {
  final String audioPath;

  AudioStopped({required this.audioPath});
}

class AudioUploading extends BottomNavState {}

class AudioUploaded extends BottomNavState {
  final String audioUrl;

  AudioUploaded(this.audioUrl);
}

class AudioUploadError extends BottomNavState {
  final String error;

  AudioUploadError(this.error);
}
