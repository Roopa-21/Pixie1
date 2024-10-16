import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pixieapp/blocs/Feedback/feedback_bloc.dart';
import 'package:pixieapp/blocs/Feedback/feedback_event.dart';
import 'package:pixieapp/blocs/Feedback/feedback_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/widgets_index.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  int _currentRating = 0; // Track the current rating locally
  late Map<String, Map<String, bool>> _currentQuestionsLikedDisliked;

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
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<FeedbackBloc, FeedbackState>(
        listener: (context, state) {
          if (state is FeedbackSubmitted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Feedback updated successfully!')));
          }
        },
        builder: (context, state) {
          if (state is FeedbackLoading) {
            return const Center(child: LoadingWidget());
          } else if (state is FeedbackExists) {
            // Initialize the existing feedback data for editing
            _initializeFeedback(state.feedbackData);
            return _buildFeedbackForm(
              "Update Feedback",
              _currentRating,
              _currentQuestionsLikedDisliked,
              theme,
              deviceHeight,
              deviceWidth,
              isUpdate: true,
            );
          } else {
            // Initialize default values for new feedback
            _currentQuestionsLikedDisliked = _initialQuestions();
            return _buildFeedbackForm(
              "Submit Feedback",
              _currentRating,
              _currentQuestionsLikedDisliked,
              theme,
              deviceHeight,
              deviceWidth,
              isUpdate: false,
            );
          }
        },
      ),
    );
  }

  // Initialize feedback data from Firebase to local variables for editing
  void _initializeFeedback(Map<String, dynamic> feedbackData) {
    _currentRating = feedbackData['rating'] ?? 0;
    _currentQuestionsLikedDisliked =
        (feedbackData['questionsLikedDisliked'] as Map<String, dynamic>).map(
      (key, value) => MapEntry(
        key,
        (value as Map).map((k, v) => MapEntry(k.toString(), v as bool)),
      ),
    );
  }

  Widget _buildFeedbackForm(
    String buttonText,
    int rating,
    Map<String, Map<String, bool>> questionsLikedDisliked,
    ThemeData theme,
    double deviceHeight,
    double deviceWidth, {
    required bool isUpdate,
  }) {
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
            _buildHeader(theme),
            const SizedBox(height: 30),
            _buildRatingSection(),
            const SizedBox(height: 30),
            _buildQuestionsSection(questionsLikedDisliked, theme),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _submitFeedback(isUpdate),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
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
              style: theme.textTheme.headlineMedium!
                  .copyWith(fontSize: 24, color: AppColors.textColorWhite),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          onPressed: () {
            setState(() {
              _currentRating = index + 1; // Update local rating
            });
          },
          icon: Icon(
            _currentRating > index
                ? Icons.star_rate_rounded
                : Icons.star_border_rounded,
            color: AppColors.kpurple,
            size: 50,
          ),
        );
      }),
    );
  }

  Widget _buildQuestionsSection(
      Map<String, Map<String, bool>> questions, ThemeData theme) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: AppColors.kwhiteColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: questions.keys.map((question) {
            final liked = questions[question]?['liked'] ?? false;
            final disliked = questions[question]?['disliked'] ?? false;

            return _questionRow(
              title: question,
              liked: liked,
              disliked: disliked,
              onLike: () => _updateQuestion(question, true),
              onDislike: () => _updateQuestion(question, false),
              theme: theme,
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _questionRow({
    required String title,
    required bool liked,
    required bool disliked,
    required VoidCallback onLike,
    required VoidCallback onDislike,
    required ThemeData theme,
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

  void _updateQuestion(String question, bool liked) {
    setState(() {
      _currentQuestionsLikedDisliked[question] = {
        'liked': liked,
        'disliked': !liked,
      };
    });
  }

  Future<void> _submitFeedback(bool isUpdate) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.read<FeedbackBloc>().add(
            SubmitFeedbackEvent(
              rating: _currentRating,
              questionsLikedDisliked: _currentQuestionsLikedDisliked,
              userId: user.uid,
            ),
          );
    }
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
