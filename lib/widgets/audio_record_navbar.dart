import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_state.dart';

class BottomNavRecord extends StatefulWidget {
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
            SnackBar(content: Text('Audio uploaded successfully')),
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
                      context.read<BottomNavBloc>().add(StopRecordingEvent());
                    },
                    child: Text("Stop Recording"),
                  );
                } else if (state is AudioUploaded) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<BottomNavBloc>()
                              .add(StartRecordingEvent());
                        },
                        child: Text("Record Again"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<BottomNavBloc>()
                              .add(UploadRecordingEvent(state.audioPath));
                        },
                        child: Text("Save Recording"),
                      ),
                    ],
                  );
                } else if (state is AudioUploading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AudioUploaded) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Audio Uploaded Successfully!'),
                        Text('URL: ${state.audioPath}'),
                      ],
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<BottomNavBloc>().add(StartRecordingEvent());
                    },
                    child: Text("Start Recording"),
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
