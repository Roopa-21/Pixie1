import 'dart:convert';

import 'package:http/http.dart' as http;

import 'dart:io';

class StoryRepository {
  final String storyApiUrl = 'http://54.86.247.121:8000/story';
  final String audioApiUrl = 'http://54.86.247.121:8000/audio';

  Future<String> generateStory({
    required String event,
    required String age,
    required String topic,
    required String child_name,
    required String gender,
    required String relation,
    required String relative_name,
    required String genre,
    required String lessons,
    required String length,
    required String language,
  }) async {
    final response = await http.post(Uri.parse(storyApiUrl),
        body: jsonEncode(
          {
            'event': event,
            'age': age,
            'topic': topic,
            'child_name': child_name,
            'gender': gender,
            'relation': relation,
            'relative_name': relative_name,
            'genre': genre,
            'lessons': lessons,
            'length': length,
            'language': language,
          },
        ));

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to generate story: ${response.body}');
    }
  }

  Future<File> speechToText({
    required String text,
    required String language,
  }) async {
    final response = await http.post(
      Uri.parse(audioApiUrl),
      body: {
        'text': text,
        'language': language,
      },
    );

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final audioFile = File('story_audio.mp3');
      await audioFile.writeAsBytes(bytes);
      return audioFile;
    } else {
      throw Exception('Failed to generate audio: ${response.body}');
    }
  }
}
