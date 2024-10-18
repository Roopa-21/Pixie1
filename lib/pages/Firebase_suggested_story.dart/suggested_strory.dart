import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/repositories/story_repository.dart';
import 'package:pixieapp/widgets/loading_widget.dart';
import 'package:pixieapp/widgets/navbar2.dart';
import 'package:pixieapp/widgets/navbar3.dart';

class Firebasesuggestedstory extends StatefulWidget {
  final DocumentReference<Object?> storyDocRef;

  const Firebasesuggestedstory({super.key, required this.storyDocRef});

  @override
  _FirebasesuggestedstoryState createState() => _FirebasesuggestedstoryState();
}

class _FirebasesuggestedstoryState extends State<Firebasesuggestedstory> {
  Map<String, dynamic>? storyData;

  String childName = "child_name";
  File? audioFile;
  StoryRepository? storyRepository;

  @override
  void initState() {
    super.initState();
    _fetchUserDataAndStory();
  }

  // Fetch the child name from the authenticated user's document
  Future<void> _fetchUserDataAndStory() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            childName = userDoc.data()?['child_name'] ?? "Ram";
            print('Fetched child name: $childName');
          });
        } else {
          print('User document does not exist.');
        }
      } else {
        print('No authenticated user found.');
      }

      // Fetch the story data after getting the child name
      await _fetchStoryData();
    } catch (e) {
      print('Error fetching user or story data: $e');
    }
  }

  // Fetch the story data from Firestore
  Future<void> _fetchStoryData() async {
    try {
      final docSnapshot = await widget.storyDocRef.get();
      if (docSnapshot.exists) {
        setState(() {
          storyData = docSnapshot.data() as Map<String, dynamic>?;

          //   audioUrl = _uploadAudioToStorage(audioFile!);
        });
        print(
            '***${storyData?["title"]! + storyData?["story"]! + storyData?["language"]}');
        print('+++++${storyData?["story"]!}');
        print('........${storyData?["language"]}');

        audioFile = await storyRepository?.speechToText(
            text: storyData?["title"]! + storyData?["story"]!,
            language: storyData?["language"]);
        print('Aaaa$audioFile');
      } else {
        print('Story document does not exist.');
      }
    } catch (e) {
      print('Error fetching story data: $e');
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

  // Replace 'child_name' with the appropriate name based on the language
  String formatText(String text) {
    final language = storyData?['language'] ?? 'English';
    final nameToUse = language == 'Hindi' ? 'राम' : childName;
    return text.replaceAll('child_name', nameToUse).replaceAll('. ', '.\n');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if (storyData == null) {
      return const Scaffold(
        body: Center(child: LoadingWidget()),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: deviceHeight * 0.3,
            leadingWidth: deviceWidth,
            collapsedHeight: deviceHeight * 0.1,
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
                    formatText(storyData?["title"] ?? "No data"),
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
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
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
                  AnimatedTextKit(
                    isRepeatingAnimation: false,
                    pause: const Duration(milliseconds: 1000),
                    animatedTexts: [
                      TyperAnimatedText(
                        formatText(storyData?["story"] ?? "No data"),
                        textStyle: theme.textTheme.bodyMedium!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                        speed: const Duration(milliseconds: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar:
      //  NavBar2(
      //   documentReference: widget.storyDocRef,
      //   audioFile: audioFile!,
      //   story: storyData?["story"] ?? 'No Story available',
      //   title: storyData?["title"] ?? 'No title available',
      //   firebaseAudioPath:
      //       'https://firebasestorage.googleapis.com/v0/b/pixie-38007.appspot.com/o/user_audio%2F1729173045688.mp3?alt=media&token=4c83fd6f-7d1f-47d8-b0e4-3a1e793ffe5f',
      // ),
         NavBar3(
        documentReference: widget.storyDocRef,
        favstatus: storyData!['isfav'],
        language: storyData?["language"]??'',
        text: storyData?["title"]! + storyData?["story"]!??'',

      ),
    );
  }
}
