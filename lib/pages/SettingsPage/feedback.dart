import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixieapp/blocs/Feedback/feedback_bloc.dart';
import 'package:pixieapp/blocs/Feedback/feedback_event.dart';
import 'package:pixieapp/blocs/Feedback/feedback_state.dart';
import 'package:pixieapp/const/colors.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<FeedbackBloc>().add(CheckFeedbackEvent(user.uid));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback submitted!')));
          }
        },
        builder: (context, state) {
          if (state is FeedbackLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FeedbackExists) {
            return _buildSubmittedFeedback(state.feedbackData, theme);
          } else if (state is FeedbackUpdated) {
            return _buildFeedbackForm(state.rating,
                state.questionsLikedDisliked, theme, deviceHeight, deviceWidth);
          } else {
            return _buildFeedbackForm(
                0, _initialQuestions(), theme, deviceHeight, deviceWidth);
          }
        },
      ),
    );
  }

  Widget _buildFeedbackForm(
      int rating,
      Map<String, Map<String, bool>> questionsLikedDisliked,
      ThemeData theme,
      double deviceHeight,
      double deviceWidth) {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffead4f9),
            Color(0xfff7f1d1),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,
                        size: 24, color: AppColors.buttonblue),
                  ),
                  const SizedBox(width: 20),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        AppColors.textColorGrey,
                        AppColors.textColorSettings,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      "Feedback",
                      style: theme.textTheme.headlineMedium!.copyWith(
                          fontSize: 24, color: AppColors.textColorWhite),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Rate your experience',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    context
                        .read<FeedbackBloc>()
                        .add(UpdateRatingEvent(index + 1));
                  },
                  icon: Icon(
                    rating > index
                        ? Icons.star_rate_rounded
                        : Icons.star_border_rounded,
                    color: AppColors.kpurple,
                    size: 50,
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            Card(
              child: Container(
                width: deviceWidth * .9,
                height: deviceHeight * .36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                    color: AppColors.kwhiteColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: questionsLikedDisliked.keys.map((question) {
                    final liked =
                        questionsLikedDisliked[question]?['liked'] ?? false;
                    final disliked =
                        questionsLikedDisliked[question]?['disliked'] ?? false;
                    return questionRow(
                      title: question,
                      liked: liked,
                      disliked: disliked,
                      theme: theme,
                      onLike: () {
                        context.read<FeedbackBloc>().add(
                            UpdateLikedDislikedEvent(
                                question: question, liked: true));
                      },
                      onDislike: () {
                        context.read<FeedbackBloc>().add(
                            UpdateLikedDislikedEvent(
                                question: question, liked: false));
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  context.read<FeedbackBloc>().add(
                        SubmitFeedbackEvent(
                          rating: rating,
                          questionsLikedDisliked: questionsLikedDisliked,
                          userId: user.uid,
                        ),
                      );
                }
              },
              child: const Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  Widget questionRow({
    required String title,
    required bool liked,
    required bool disliked,
    required ThemeData theme,
    required VoidCallback onLike,
    required VoidCallback onDislike,
  }) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Text(
            title,
            style: theme.textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onLike,
            icon: Icon(
              liked ? Icons.thumb_up_alt : Icons.thumb_up_off_alt,
              color: AppColors.kpurple,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            onPressed: onDislike,
            icon: Icon(
              disliked ? Icons.thumb_down_alt : Icons.thumb_down_off_alt,
              color: AppColors.kpurple,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmittedFeedback(
      Map<String, dynamic> feedbackData, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'You have already submitted feedback. Thank you!',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 40),
          TextButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.kpurple,
                size: 20,
              ),
              label: Text(
                "Back",
                style: theme.textTheme.bodyLarge!
                    .copyWith(fontSize: 20, color: AppColors.kpurple),
              ))
        ],
      ),
    );
  }

  Map<String, Map<String, bool>> _initialQuestions() {
    return {
      'Story line': {'liked': false, 'disliked': false},
      'Tone of narration': {'liked': false, 'disliked': false},
      'Voice modulation': {'liked': false, 'disliked': false},
      'Background music': {'liked': false, 'disliked': false},
      'User journey': {'liked': false, 'disliked': false},
    };
  }
}
