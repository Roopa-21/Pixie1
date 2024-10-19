import 'dart:io';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/blocs/Story_bloc/story_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_state.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pixieapp/widgets/navbar_loading_audio.dart';

class StoryGeneratePage extends StatefulWidget {
  final Map<String, String> story;
  final String storytype;
  final String language;

  const StoryGeneratePage({
    super.key,
    required this.story,
    required this.storytype,
    required this.language,
  });

  @override
  _StoryGeneratePageState createState() => _StoryGeneratePageState();
}

class _StoryGeneratePageState extends State<StoryGeneratePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference<Object?>? _documentReference;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _createInitialStoryEntry();
  }

  void _createInitialStoryEntry() async {
    final queryParams = GoRouterState.of(context).uri.queryParameters;

    if (_documentReference == null) {
      final docRef = await _addStoryToFirebase(
        audiopath: '', // Temporary empty audio path
        fav: false,
        story: widget.story["story"] ?? "No data",
        title: widget.story["title"] ?? "No data",
        type: queryParams['storytype']!,
        language: queryParams['language']!,
        createdTime: DateTime.now(),
      );

      setState(() {
        _documentReference = docRef;
      });
    }
  }

  File? audioFile;
  bool audioloaded = false;

  bool callAppBar = false;
  String? audioUrl = '';
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return BlocListener<StoryBloc, StoryState>(
      listener: (context, state) async {
        if (state is StoryAudioSuccess) {
          audioFile = state.audioFile;
          print('Audio File Path: ${audioFile!.path}');

          audioUrl = await _uploadAudioToStorage(audioFile!);

          if (audioUrl != null) {
            setState(() {
              audioloaded = true;
            });
            await _updateStoryWithAudioUrl(audioUrl!);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: deviceHeight * 0.38,
              leadingWidth: deviceWidth,
              collapsedHeight: deviceHeight * 0.15,
              pinned: true,
              floating: false,
              backgroundColor: const Color(0xff644a98),
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  bool isCollapsed = top <= kToolbarHeight + 30;

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                    title: Text(
                      widget.story["title"] ?? "No data",
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: AppColors.textColorWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: isCollapsed ? 5 : 20,
                      ),
                    ),
                    background: Image.asset(
                      'assets/images/appbarbg.jpg',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              actions: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.kwhiteColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      context.read<AddCharacterBloc>().add(ResetStateEvent());
                      context.go('/HomePage');
                    },
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 5,
                  left: deviceHeight * 0.0294,
                  right: deviceHeight * 0.0294,
                  bottom: deviceHeight * 0.0294,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: AppColors.textColorGrey,
                        fontWeight: FontWeight.w400,
                      ),
                      child: AnimatedTextKit(
                        onFinished: () {
                          setState(() {
                            callAppBar = true;
                          });
                        },
                        isRepeatingAnimation: false,
                        pause: const Duration(milliseconds: 100),
                        animatedTexts: [
                          TyperAnimatedText(
                            widget.story["story"] ?? "No data",
                            textStyle: theme.textTheme.bodyMedium!.copyWith(
                                fontSize: 24, fontWeight: FontWeight.w400),
                            speed: const Duration(milliseconds: 20),
                          ),
                        ],
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: audioloaded
            ? NavBar2(
                documentReference: _documentReference,
                audioFile: audioFile!,
                story: widget.story['story'] ?? 'No Story available',
                title: widget.story['title'] ?? 'No title available',
                firebaseAudioPath: audioUrl ?? '',
              )
            // : SizedBox.shrink()
            : const NavBarLoading(),
      ),
    );
  }

  Future<DocumentReference<Object?>?> _addStoryToFirebase({
    required String title,
    required String audiopath,
    required bool fav,
    required String story,
    required String type,
    required String language,
    required DateTime createdTime,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final docRef = await _firestore.collection('fav_storys').add({
        'storytype': type,
        'title': title,
        'audiofile': audiopath,
        'story': story,
        'isfav': fav,
        'user_ref': userRef,
        'language': language,
        'createdTime': FieldValue.serverTimestamp(),
      });

      print('Story added to favorites');
      return docRef;
    } catch (e) {
      print('Error adding story: $e');
      return null;
    }
  }

  Future<void> _updateStoryWithAudioUrl(String audioUrl) async {
    if (_documentReference != null) {
      try {
        await _documentReference!.update({'audiofile': audioUrl});
        print('Audio URL updated in Firestore');
      } catch (e) {
        print('Error updating audio URL: $e');
      }
    }
  }

  Future<String?> _uploadAudioToStorage(File audioFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_audio')
          .child('${DateTime.now().millisecondsSinceEpoch}.mp3');

      final uploadTask = storageRef.putFile(audioFile);
      final snapshot = await uploadTask;
      final audioUrl = await snapshot.ref.getDownloadURL();

      print('Audio uploaded: $audioUrl');
      return audioUrl;
    } catch (e) {
      print('Error uploading audio: $e');
      return null;
    }
  }
}
