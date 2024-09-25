import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar.dart';

class StoryGeneratePage extends StatelessWidget {
  const StoryGeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: deviceheight * 0.4424,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  background: Stack(children: [
                Image.asset(
                  'assets/images/sliverApp.png',
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(deviceheight * 0.0294),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The wind in the willows',
                        style: theme.textTheme.titleLarge!.copyWith(
                            color: AppColors.textColorWhite,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: deviceheight * 0.0294,
                      ),
                      Text(
                        'Creating Story',
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: AppColors.textColorWhite,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              ])),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 5,
                    left: deviceheight * 0.0294,
                    right: deviceheight * 0.0294,
                    bottom: deviceheight * 0.0294),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur finibus erat eu magna tempus gravida. Suspendisse potenti. Nam quis ex nec diam mollis varius eu non arcu.',
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.textColorGrey,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: deviceheight * 0.0294),
                    Text(
                        'Suspendisse in justo risus. Maecenas laoreet augue eget efficitur tristique. Quisque aliquet sed velit id rhoncus. Aenean pharetra mauris ut elit malesuada, aliquam laoreet magna pulvinar.',
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.textColorGrey,
                            fontWeight: FontWeight.w400)),
                    SizedBox(height: deviceheight * 0.0294),
                    Text(
                        'Suspendisse in justo risus. Maecenas laoreet augue eget efficitur tristique. Quisque aliquet sed velit id rhoncus. Aenean pharetra mauris ut elit malesuada, aliquam laoreet magna pulvinar.',
                        style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.textColorGrey,
                            fontWeight: FontWeight.w400)),

                    // Add more text as needed
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const NavBar());
  }
}
