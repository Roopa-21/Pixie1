import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  bool isListening = false;
  bool isRecording = false;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
   String? _audioPath;
  User? user = FirebaseAuth.instance.currentUser;

  BottomNavBloc() : super(BottomNavBlocInitial()) {
     _initializeRecorder();
    on<StartRecordingEvent>((event, emit) async => await _startRecording(emit));
    on<StopRecordingEvent>((event, emit) async => await _stopRecording(emit));
    on<UploadRecordingEvent>((event, emit) async => await _uploadAudio(event.audioPath, emit));

    on<UpdateListenStateEvent>((event, emit) {
      isListening = event.isListening;
      emit(ListenStateUpdated(isListening: isListening));
    });

    on<UpdateReadAndRecordStateEvent>((event, emit) {
      isRecording = event.isRecording;
      emit(ReadAndRecordStateUpdated(isRecording: isRecording));
    });

  }
   Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> _startRecording(Emitter<BottomNavState> emit) async {
    final tempDir = await getTemporaryDirectory();
    _audioPath = '${tempDir.path}/audio.aac';
    emit(AudioRecording());
    await _recorder.startRecorder(toFile: _audioPath);
  }

  Future<void> _stopRecording(Emitter<BottomNavState> emit) async {
    await _recorder.stopRecorder();
    if (_audioPath != null) {
      emit(AudioStopped());
      add(UploadRecordingEvent(_audioPath!));
    }
  }
  Future<void> _uploadAudio(String filePath, Emitter<BottomNavState> emit) async {
    emit(AudioUploading());
    try {
      final file = File(filePath);
      final ref = FirebaseStorage.instance
          .ref()
          .child('audio_files/${DateTime.now().millisecondsSinceEpoch}.aac');
      await ref.putFile(file);
      final audioUrl = await ref.getDownloadURL();

      // await FirebaseFirestore.instance
      //     .collection('events')
      //     .doc('dFMUJxFz9hQ9qxDXBeCq')
      //     .update({'audiourl': audioUrl});

      emit(AudioUploaded(audioUrl));
    } catch (e) {
      emit(AudioUploadError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _recorder.closeRecorder();
    return super.close();
  }
}

  


  
