import 'package:flutter/material.dart';

class StoryConfirmationPage extends StatefulWidget {
  const StoryConfirmationPage({super.key});

  @override
  State<StoryConfirmationPage> createState() => _StoryConfirmationPageState();
}

class _StoryConfirmationPageState extends State<StoryConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceheight = MediaQuery.of(context).size.height;
    print(deviceheight);
    final devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: devicewidth,
        height: deviceheight,
         decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 231, 201, 249),
                Color.fromARGB(255, 248, 244, 187)
              ],
            ),
          ),
      ),
    );
  }
}
