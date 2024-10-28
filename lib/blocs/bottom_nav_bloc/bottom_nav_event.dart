
import 'dart:io';

abstract class BottomNavEvent {}

class UpdateListenStateEvent extends BottomNavEvent {
  final bool isListening;

  UpdateListenStateEvent({required this.isListening});
}

class UpdateReadAndRecordStateEvent extends BottomNavEvent {
  final bool isRecording;

  UpdateReadAndRecordStateEvent({required this.isRecording});
}



class StartRecordingEvent extends BottomNavEvent {}

class StopRecordingEvent extends BottomNavEvent {}

class UploadRecordingEvent extends BottomNavEvent {
final String audioPath;
  UploadRecordingEvent(this.audioPath);
}