import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pixieapp/blocs/StoryFeedback/story_feedback_bloc.dart';
import 'package:pixieapp/blocs/StoryFeedback/story_feedback_event.dart';
import 'package:pixieapp/blocs/StoryFeedback/story_feedback_state.dart';
import 'package:pixieapp/blocs/Story_bloc/story_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_state.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/audio_controller.dart';
import 'package:pixieapp/widgets/story_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final AudioController _audioController = AudioController();
  //final player = AudioPlayer();
  // late AudioPlayer _audioPlayer;
  User? user = FirebaseAuth.instance.currentUser;
  bool _isPlaying = false;
  bool showfeedback = true;
  bool isDisliked = false;
  final GlobalKey _tooltipKey = GlobalKey();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  String? audioUrl;
  @override
  void initState() {
    super.initState();

    print('oooo${widget.audioFile}');

    widget.firebaseStories
        ? _audioController.audioPlayer.setUrl(widget.firebaseAudioPath)
        : _audioController.audioPlayer.setFilePath(widget.audioFile!.path);
    _audioController.audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });
    _audioController.audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d!;
      });
    });
    _audioController.audioPlayer.playerStateStream.listen((state) async {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          position = Duration.zero;
        });
        _audioController.audioPlayer.pause();
        _audioController.audioPlayer.seek(position);
      }
    });
  }

  Future<void> fetchAudioUrl() async {
    print('ggggg${widget.documentReference}');
    if (widget.documentReference != null) {
      try {
        final documentSnapshot = await widget.documentReference!.get();
        if (documentSnapshot.exists) {
          setState(() {
            audioUrl = documentSnapshot.get('audiofile');
            print('yy${audioUrl}');
          });
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  void dispose() {
    _audioController.stop();

    super.dispose();
  }

  // Function to set the audio source from the audio file path
  // Future<void> _setAudioSource() async {
  //   try {
  //     // Use the file path directly
  //     await _audioController.audioPlayer.setFilePath(widget.audioFile!.path);
  //     print("Audio source set successfully.");
  //   } catch (e) {
  //     print("Error loading audio file: $e");
  //   }
  // }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void stopplaying() {
    if (_audioController.audioPlayer.playing) {
      _audioController.audioPlayer.pause();
    }
  }

  void handlePlayPause({required AddCharacterState state}) async {
    if (_audioController.audioPlayer.playing) {
      _audioController.audioPlayer.pause();
    } else {
      _audioController.audioPlayer.play();
    }
  }

  void handleSeek(double value) {
    _audioController.audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<StoryBloc, StoryState>(
      listener: (context, state) async {
        if (state is Stopplayingstate) {
          stopplaying();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            image: DecorationImage(
                image: AssetImage('assets/images/Rectangle 11723.png'),
                fit: BoxFit.fill),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
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
                      children: [
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
                      ],
                    ),
                  ],
                ),
                BlocBuilder<AddCharacterBloc, AddCharacterState>(
                  builder: (context, state) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: IconButton(
                          onPressed: () {
                            !isDisliked
                                ? context
                                    .read<AddCharacterBloc>()
                                    .add(UpdatefavbuttonEvent(!state.fav))
                                : context.read<StoryFeedbackBloc>().add(
                                    const UpdatedislikeStateEvent(
                                        isDisliked: false));
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
                          icon: SvgPicture.asset(
                            state.fav == true
                                ? 'assets/images/afterLike.svg'
                                : 'assets/images/beforeLike.svg',
                            width: 30,
                            height: 30,
                          ),
                          // icon: Icon(
                          //   state.fav == true
                          //       ? Icons.thumb_up
                          //       : Icons.thumb_up_off_alt,
                          //   size: 30,
                          //   color: AppColors.kpurple,
                          // ),
                        ),
                      ),
                      BlocBuilder<StoryFeedbackBloc, StoryFeedbackState>(
                        builder: (context, state) {
                          if (state is DislikeStateUpdated) {
                            isDisliked = state.isDisliked;
                          }

                          return IconButton(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                context: context,
                                builder: (context) {
                                  return GestureDetector(
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
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
                            icon: SvgPicture.asset(
                              isDisliked
                                  ? 'assets/images/afterDislike.svg'
                                  : 'assets/images/beforeDislike.svg',
                              width: 30,
                              height: 30,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          handlePlayPause(state: state);
                        },
                        icon: SizedBox(
                          width: 60,
                          height: 60,
                          child: _audioController.audioPlayer.playing
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
                      IconButton(
                        onPressed: () {
                          // Show the tooltip programmatically
                          final dynamic tooltip = _tooltipKey.currentState;
                          tooltip?.ensureTooltipVisible();

                          // Simulate feature loading (Optional)
                          Future.delayed(const Duration(seconds: 2), () {
                            print("Feature loading completed");
                          });
                        },
                        icon: Tooltip(
                          key: _tooltipKey, // Add the tooltip key
                          message:
                              'Stay tuned for the magic!', // Tooltip message
                          waitDuration:
                              const Duration(milliseconds: 0), // No wait
                          showDuration:
                              const Duration(seconds: 2), // Show for 2 seconds
                          child: SvgPicture.asset(
                            'assets/images/addToFavorites.svg',
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          // FirebaseAuth.instance
                          //     .signInAnonymously()
                          //     .then((userCredential) {
                          //   FirebaseStorage.instance
                          //       .ref('path/to/audio/file.mp3')
                          //       .getDownloadURL()
                          //       .then((downloadUrl) {
                          //     shareOnWhatsApp(
                          //       appUrl:
                          //           "https://apps.apple.com/in/app/instagram/id389801252",
                          //       audioFileUrl: downloadUrl,
                          //     );
                          //   }).catchError((error) {
                          //     print("Failed to get download URL: $error");
                          //   });
                          // }).catchError((error) {
                          //   print("Anonymous sign-in failed: $error");
                          // });
                          await fetchAudioUrl();
                          // Future<String> createDynamicLink(
                          //     String originalUrl) async {
                          //   print('hjhj$originalUrl');
                          //   final url = Uri.parse(
                          //       'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=AIzaSyDzN_pzKQ1mvvwMUDWOsYnV3EII73ONtLA');

                          //   final response = await http.post(
                          //     url,
                          //     headers: {
                          //       'Content-Type': 'application/json',
                          //     },
                          //     body: jsonEncode({
                          //       "dynamicLinkInfo": {
                          //         "domainUriPrefix": "https://pixie.page.link",
                          //         "link": originalUrl,
                          //         "androidInfo": {
                          //           "androidPackageName":
                          //               "com.fabletronic.pixie",
                          //         },
                          //         "iosInfo": {
                          //           "iosBundleId": "com.fabletronic.pixie",
                          //         }
                          //       },
                          //       "suffix": {
                          //         "option": "SHORT",
                          //       },
                          //     }),
                          //   );

                          //   if (response.statusCode == 200) {
                          //     final data = jsonDecode(response.body);
                          //     return data['shortLink'];
                          //   } else {
                          //     throw Exception(
                          //         'Failed to create dynamic link: ${response.body}');
                          //   }
                          // }

                          // final shortLink =
                          //     await createDynamicLink(audioUrl ?? '');
                          // print('oops$shortLink');
                          openWhatsAppChat(
                              '''${widget.title}\n\n${widget.story}\n\n 🎧Hey! Listen to the personalized story I created for my child. You can create such personalized audio stories for your children too! \n $audioUrl \n\nDownload the app now \n For ios app:https://apps.apple.com/us/app/pixie-dream-create-inspire/id6737147663\n\n For Android app : https://play.google.com/store/apps/details?id=com.fabletronic.pixie.''');
                        },
                        icon: SvgPicture.asset(
                          'assets/images/share.svg',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

// void shareOnWhatsApp(
//     {required String audioFileUrl, required String appUrl}) async {
//   final whatsappUrl = Uri.parse(
//     "https://wa.me/?text=Hey!%20Listen%20to%20this%20amazing%20story%20on%20Pixie.%20Download%20the%20app%20for%20more%20similar%20stories:%20$appUrl%20\n\n"
//     "You%20can%20also%20listen%20to%20the%20audio%20directly:%20$audioFileUrl",
//   );
//   if (await canLaunchUrl(whatsappUrl)) {
//     await launchUrl(whatsappUrl);
//   } else {
//     print("Could not launch WhatsApp.");
//   }
// }
// Future<void> openWhatsAppChat(String text) async {
//   var url = "https://wa.me/?text=$text";
//   var uri = Uri.encodeFull(url);

//   if (await canLaunchUrl(Uri.parse(uri))) {
//     await launchUrl(Uri.parse(uri), mode: LaunchMode.externalApplication);
//   } else {
//     throw 'Could not launch WhatsApp';
//   }
// }
Future<void> openWhatsAppChat(String text) async {
  final encodedText = Uri.encodeComponent(text);

  final url = "https://wa.me/?text=$encodedText";

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch WhatsApp';
  }
}
