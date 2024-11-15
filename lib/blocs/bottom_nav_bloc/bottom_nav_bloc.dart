import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'bottom_nav_event.dart';
import 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _audioPath;

  BottomNavBloc() : super(BottomNavBlocInitial()) {
    _initializeRecorder();
    on<UpdateListenStateEvent>((event, emit) {
      emit(ListenStateUpdated(isListening: event.isListening));
    });
    on<UpdateReadAndRecordStateEvent>((event, emit) {
      emit(ReadAndRecordStateUpdated(isRecording: event.isRecording));
    });
    on<StartRecordingEvent>((event, emit) async => await _startRecording(emit));
    on<StopRecordingEvent>((event, emit) async => await _stopRecording(emit));
    on<UploadRecordingEvent>((event, emit) async => await _uploadRecording(
        event.audioPath,
        event.documentReference as DocumentReference<Object?>?,
        emit));
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> _startRecording(Emitter<BottomNavState> emit) async {
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

  Future<void> _stopRecording(Emitter<BottomNavState> emit) async {
    try {
      await _recorder.stopRecorder();
      if (_audioPath != null) {
        emit(AudioStopped(audioPath: _audioPath!));
      }
    } catch (e) {
      emit(AudioUploadError('Failed to stop recording: $e'));
    }
  }

  Future<void> _uploadRecording(
      String audioPath,
      DocumentReference<Object?>? documentReference,
      Emitter<BottomNavState> emit) async {
    try {
      emit(AudioUploading());

      // Prepare the file and create a multipart request
      final uri = Uri.parse('http://54.86.247.121:8000/music_addition');
      final request = http.MultipartRequest('POST', uri)
        ..fields['event'] = 'bedtime' // Add any additional fields here
        ..files.add(await http.MultipartFile.fromPath('audiofile', audioPath));

      // Send the request and get the response
      final response = await request.send();

      if (response.statusCode == 200) {
        // Parse the response to get the audio URL
        final responseBody = await response.stream.bytesToString();
        final audioUrl = responseBody.trim(); // Ensure it's a valid URL format

        // Update Firestore with the audio URL if documentReference is not null
        if (documentReference != null && audioUrl.isNotEmpty) {
          await documentReference.update({
            'audioRecordUrl': audioUrl,
          });
          emit(AudioUploaded(audioUrl));
        } else {
          emit(AudioUploadError(
              'Invalid audio URL received from API or document reference is null.'));
        }
      } else {
        emit(
            AudioUploadError('Failed to upload audio: ${response.statusCode}'));
      }
    } catch (e) {
      emit(AudioUploadError('An error occurred during upload: $e'));
    }
  }

  @override
  Future<void> close() {
    _recorder.closeRecorder();
    return super.close();
  }
}
