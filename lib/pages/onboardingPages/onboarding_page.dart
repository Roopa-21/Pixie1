import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardData = [
    {
      "title": "Your personalised storyteller",
      "description":
          "Pixie magically creates personalized audio adventures starring your child, tailored to their unique interests and imagination.",
    },
    {
      "title": "Screen free entertainment",
      "description":
          "Worried about your child's screentime? Pixie brings back that love of stories without the screen.",
    },
    {
      "title": "Supercharge young minds",
      "description":
          "Ignite imagination, sharpen focus, and boost memory through magical storytelling.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.kwhiteColor,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              itemCount: onboardData.length,
              itemBuilder: (context, index) {
                return OnboardContent(
                  title: onboardData[index]['title']!,
                  description: onboardData[index]['description']!,
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardData.length,
                    (index) => buildDot(index),
                  ),
                ),
                SizedBox(
                  height: deviceheight * 0.029, // 20
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ElevatedButton(
                    onPressed: () => context.push('/CreateAccount'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonblue,
                        minimumSize: Size(devicewidth, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text("Get started",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.textColorWhite,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceheight * 0.029,
                      vertical: deviceheight * 0.029),
                  child: ElevatedButton(
                    onPressed: () => context.push('/Loginpage'),
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: AppColors.kwhiteColor,
                        minimumSize: Size(devicewidth, deviceheight * 0.0737),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text("Already have an account",
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.textColorblue,
                            fontSize: 20,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: currentPage == index
            ? AppColors.dotColorSelected
            : AppColors.dotColorUnSelected,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String title;
  final String description;

  const OnboardContent({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceheight = MediaQuery.of(context).size.height;
    final devicewidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: devicewidth,
          height: deviceheight * 0.5,
          child: Image.asset(
            'assets/images/onboarding_image.png',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: deviceheight * 0.0589,
            right: deviceheight * 0.0589,
          ),
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  title,
                  style: theme.textTheme.displaySmall!.copyWith(
                      color: AppColors.textColorblue,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: deviceheight * 0.0242),
        Text(
          description,
          style: theme.textTheme.bodyLarge!.copyWith(
              color: AppColors.textColorGrey, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
