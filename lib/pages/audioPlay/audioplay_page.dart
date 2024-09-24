import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class AudioplayPage extends StatefulWidget {
  const AudioplayPage({super.key});

  @override
  State<AudioplayPage> createState() => _AudioplayPageState();
}

class _AudioplayPageState extends State<AudioplayPage> {
  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
height: deviceheight,
width: devicewidth,
 decoration: BoxDecoration(
            
            gradient: LinearGradient(
              colors: [AppColors.buttonColor1, AppColors.audioPlayColor],
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
          ),
      ),
    );
  }
}
