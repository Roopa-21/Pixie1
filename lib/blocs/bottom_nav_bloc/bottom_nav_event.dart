// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';

// abstract class BottomNavEvent {}

// class UpdateListenStateEvent extends BottomNavEvent {
//   final bool isListening;

//   UpdateListenStateEvent({required this.isListening});
// }

// class UpdateReadAndRecordStateEvent extends BottomNavEvent {
//   final bool isRecording;

//   UpdateReadAndRecordStateEvent({required this.isRecording});
// }

// class StartRecordingEvent extends BottomNavEvent {}

// class StopRecordingEvent extends BottomNavEvent {}

// class UploadRecordingEvent extends BottomNavEvent {
//   final String audioPath;
//   final DocumentReference<Object?>? documentReference;

//   UploadRecordingEvent(
//       {required this.audioPath, required this.documentReference});
// }
