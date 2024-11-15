import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_bloc.dart';
import 'package:pixieapp/blocs/Story_bloc/story_event.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:pixieapp/const/colors.dart';

class RecordListenNavbar extends StatelessWidget {
  final String story;
  final String title;
  final String language;
  const RecordListenNavbar(
      {super.key,
      required this.story,
      required this.title,
      required this.language});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(bottom: 40),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        image: DecorationImage(
            image: AssetImage('assets/images/Rectangle 11723.png'),
            fit: BoxFit.fill),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                context.read<StoryBloc>().add(const StartRecordnavbarEvent());
                print("aaaaa");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kwhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              child: Text(
                "Read and record",
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColorblue,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                context.read<StoryBloc>().add(
                    SpeechToTextEvent(text: story + title, language: language));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kwhiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
              child: Text(
                "Listen",
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColorblue,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
