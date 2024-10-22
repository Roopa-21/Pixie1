import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/story_feedback.dart';

class NavBar2 extends StatefulWidget {
  final DocumentReference<Object?>? documentReference;
  final File? audioFile;
  final String story;
  final String title;
  final String firebaseAudioPath;
  final bool suggestedStories;
  final bool firebaseStories;

  const NavBar2(
      {super.key,
      required this.documentReference,
      this.audioFile,
      required this.story,
      required this.title,
      required this.firebaseAudioPath,
      required this.suggestedStories,
      required this.firebaseStories});

  @override
  State<NavBar2> createState() => _NavBar2State();
}

class _NavBar2State extends State<NavBar2> {
  final player = AudioPlayer();
  late AudioPlayer _audioPlayer;
  User? user = FirebaseAuth.instance.currentUser;
  bool _isPlaying = false;

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  @override
  void initState() {
    super.initState();

    widget.firebaseStories
        ? player.setUrl(widget.firebaseAudioPath)
        : player.setFilePath(widget.audioFile!.path);
    player.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
    player.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          position = Duration.zero;
        });
        player.pause();
        player.seek(position);
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    player.dispose();
    super.dispose();
  }

  // Function to set the audio source from the audio file path
  Future<void> _setAudioSource() async {
    try {
      // Use the file path directly
      await _audioPlayer.setFilePath(widget.audioFile!.path);
      print("Audio source set successfully.");
    } catch (e) {
      print("Error loading audio file: $e");
    }
  }

  // // Function to toggle play/pause
  // Future<void> _togglePlayPause() async {
  //   print(_isPlaying);
  //   try {
  //     if (_isPlaying) {
  //       await _audioPlayer.pause();
  //     } else {
  //       // Ensure the audio is ready before trying to play
  //       if (_audioPlayer.processingState == ProcessingState.ready ||
  //           _audioPlayer.processingState == ProcessingState.idle) {
  //         await _audioPlayer.play();
  //       }
  //     }
  //     setState(() {
  //       _isPlaying = !_isPlaying; // Toggle the play state
  //     });
  //   } catch (e) {
  //     print("Error playing audio: $e");
  //   }
  // }

  // Format the time duration as minutes and seconds
  // String _formatDuration(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final minutes = twoDigits(duration.inMinutes.remainder(60));
  //   final seconds = twoDigits(duration.inSeconds.remainder(60));
  //   return '$minutes:$seconds';
  // }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void handlePlayPause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    formatDuration(position),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textColorblue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: handleSeek,
                      activeColor: AppColors.kpurple,
                      inactiveColor: AppColors.kwhiteColor,
                    ),
                  ),
                  Text(
                    formatDuration(duration),
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textColorblue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  BlocBuilder<AddCharacterBloc, AddCharacterState>(
                    builder: (context, state) => Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: IconButton(
                        onPressed: () {
                          context
                              .read<AddCharacterBloc>()
                              .add(UpdatefavbuttonEvent(!state.fav));
                          widget.suggestedStories
                              ? updateFirebaseSuggested(
                                  docRef: widget.documentReference!,
                                  fav: !state.fav,
                                )
                              : updateFirebase(
                                  docRef: widget.documentReference!,
                                  fav: !state.fav,
                                );
                        },
                        // icon: SvgPicture.asset(
                        //   state.fav == true
                        //       ? 'assets/images/Heart_filled.svg'
                        //       : 'assets/images/likee.svg',
                        //   width: state.fav == true ? 40 : 25,
                        //   height: state.fav == true ? 40 : 25,
                        // ),
                        icon: Icon(
                          state.fav == true
                              ? Icons.thumb_up
                              : Icons.thumb_up_off_alt,
                          size: 30,
                          color: AppColors.kpurple,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        enableDrag: false,
                        context: context,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: Padding(
                              padding: MediaQuery.viewInsetsOf(context),
                              child: StoryFeedback(
                                story: widget.story,
                                title: widget.title,
                                path: widget.firebaseAudioPath,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    // icon: SvgPicture.asset(
                    //   'assets/images/dislike.svg',
                    //   width: 25,
                    //   height: 25,
                    // ),
                    icon: const Icon(
                      Icons.thumb_down_off_alt,
                      color: AppColors.kpurple,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: handlePlayPause,
                    icon: SizedBox(
                      width: 60,
                      height: 60,
                      child: player.playing
                          ? const Icon(
                              Icons.pause_circle_filled_sharp,
                              color: AppColors.kpurple,
                              size: 60,
                            )
                          : SvgPicture.asset(
                              'assets/images/pausegrad.svg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  widget.suggestedStories
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                        )
                      : IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/images/addToFavorites.svg',
                            width: 25,
                            height: 25,
                          ),
                        ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/images/share.svg',
                      width: 25,
                      height: 25,
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

  Future<void> updateFirebase({
    required bool fav,
    required DocumentReference<Object?> docRef,
  }) async {
    if (fav) {
      await docRef.update({
        'isfav': true,
      });
      print('Story added to fav');
    } else {
      await docRef.update({'isfav': false});
      print('Story removed from fav');
    }
  }

  Future<void> updateFirebaseSuggested({
    required bool fav,
    required DocumentReference<Object?> docRef,
  }) async {
    if (fav) {
      await docRef.update({
        'isfav': true,
        'noOfFavorites': FieldValue.arrayUnion([
          FirebaseFirestore.instance.collection('users').doc(user?.uid),
        ]),
      });
      print('Story added to fav');
    } else {
      await docRef.update({
        'isfav': false,
        'noOfFavorites': FieldValue.arrayRemove([
          FirebaseFirestore.instance.collection('users').doc(user?.uid),
        ]),
      });
      print('Story removed from fav');
    }
  }
}
