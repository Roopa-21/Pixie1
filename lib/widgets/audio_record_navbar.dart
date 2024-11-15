import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_state.dart';

class BottomNavRecord extends StatefulWidget {
  // final DocumentReference<Object?>? documentReference;
  const BottomNavRecord({super.key});

  @override
  State<BottomNavRecord> createState() => _BottomNavRecordState();
}

class _BottomNavRecordState extends State<BottomNavRecord> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<BottomNavBloc, BottomNavState>(
      listener: (context, state) {
        if (state is AudioUploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Audio uploaded successfully')),
          );
        } else if (state is AudioUploadError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error uploading audio: ${state.error}')),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 40),
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          image: DecorationImage(
              image: AssetImage('assets/images/Rectangle 11723.png'),
              fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<BottomNavBloc, BottomNavState>(
              builder: (context, state) {
                if (state is AudioRecording) {
                  return ElevatedButton(
                    onPressed: () {
                      // context.read<BottomNavBloc>().add(StopRecordingEvent());
                    },
                    child: const Text("Stop Recording"),
                  );
                } else if (state is AudioRecorded) {
                  // Options after recording is done
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // context
                          //     .read<BottomNavBloc>()
                          //     .add(StartRecordingEvent());
                        },
                        child: const Text("Record Again"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // context.read<BottomNavBloc>().add(UploadRecordingEvent(
                          //   audioPath: state.audioPath,
                          //   documentReference: widget.documentReference,
                          // ));
                        },
                        child: const Text("Save Recording"),
                      ),
                    ],
                  );
                } else if (state is AudioUploading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AudioUploaded) {
                  return const Center(
                    child: Text('Audio Uploaded Successfully!'),
                  );
                } else {
                  // Initial state
                  return ElevatedButton(
                    onPressed: () {
                      context.read<BottomNavBloc>().add(StartRecordingEvent());
                    },
                    child: const Text("Start Recording"),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
