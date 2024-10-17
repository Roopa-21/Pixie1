import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';

class NavBar2 extends StatefulWidget {
  final DocumentReference<Object?>? documentReference;
  final File audioFile;

  const NavBar2(
      {super.key, required this.documentReference, required this.audioFile});

  @override
  State<NavBar2> createState() => _NavBar2State();
}

class _NavBar2State extends State<NavBar2> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero; // Track current playback position
  Duration _totalDuration = Duration.zero; // Track total duration of the audio

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(); // Initialize the audio player
    _setAudioSource(); // Load the audio source when the widget is initialized

    // Listen to the current playback position
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    // Listen to total duration of the audio
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });

    // Add a listener to handle audio completion
    _audioPlayer.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.completed) {
        _audioPlayer.pause(); // Pause the audio after it finishes
        _audioPlayer.seek(Duration.zero); // Reset the audio to the start
        setState(() {
          _isPlaying = false; // Reset the play/pause state
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the audio player when not needed
    super.dispose();
  }

  // Function to set the audio source from the audio file path
  Future<void> _setAudioSource() async {
    try {
      // Use the file path directly
      await _audioPlayer.setFilePath(widget.audioFile.path);
      print("Audio source set successfully.");
    } catch (e) {
      print("Error loading audio file: $e");
    }
  }

  // Function to toggle play/pause
  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        // Ensure the audio is ready before trying to play
        if (_audioPlayer.processingState == ProcessingState.ready ||
            _audioPlayer.processingState == ProcessingState.idle) {
          await _audioPlayer.play();
        }
      }
      setState(() {
        _isPlaying = !_isPlaying; // Toggle the play state
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // Format the time duration as minutes and seconds
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          image: DecorationImage(
              image: AssetImage('assets/images/Rectangle 11723.png'),
              fit: BoxFit.fill),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Music slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Display the current time (progress)
                  Text(
                    _formatDuration(_currentPosition),
                    style: const TextStyle(color: Colors.black),
                  ),
                  // Slider to control the progress of the audio
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: _totalDuration.inSeconds.toDouble(),
                      value: _currentPosition.inSeconds
                          .toDouble()
                          .clamp(0, _totalDuration.inSeconds.toDouble()),
                      onChanged: (value) async {
                        if (_isPlaying) {
                          final newPosition = Duration(seconds: value.toInt());
                          await _audioPlayer.seek(newPosition);
                        }
                      },
                      activeColor: AppColors.kpurple,
                      inactiveColor: AppColors.kwhiteColor,
                    ),
                  ),
                  // Display the total duration of the audio
                  Text(
                    _formatDuration(_totalDuration),
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/home_unselect.svg',
                      width: 40,
                      height: 40,
                      color: Colors.transparent,
                    ),
                    focusColor: Colors.transparent,
                    color: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  IconButton(
                    onPressed:
                        _togglePlayPause, // Play/Pause audio on button press
                    icon: SvgPicture.asset(
                      _isPlaying
                          ? 'assets/images/pausebutton.svg'
                          : 'assets/images/playing.svg', // Toggle the play/pause icon
                      width: 60,
                      height: 60,
                    ),
                  ),
                  BlocBuilder<AddCharacterBloc, AddCharacterState>(
                    builder: (context, state) => Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            context
                                .read<AddCharacterBloc>()
                                .add(UpdatefavbuttonEvent(!state.fav));
                            updateFirebase(
                                docRef: widget.documentReference!,
                                fav: !state.fav);
                          },
                          icon: SvgPicture.asset(
                            state.fav == true
                                ? 'assets/images/Heart_filled.svg'
                                : 'assets/images/Heart.svg',
                            width: state.fav == true ? 40 : 25,
                            height: state.fav == true ? 40 : 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateFirebase(
      {required bool fav, required DocumentReference<Object?> docRef}) async {
    if (fav) {
      await docRef.update({'isfav': true});
      print('Story added to fav');
    } else {
      await docRef.update({'isfav': false});
      print('Story removed from fav');
    }
  }
}
