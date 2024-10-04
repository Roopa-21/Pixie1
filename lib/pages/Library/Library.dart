import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff9f3cd),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "My Stories",
                  style: theme.textTheme.headlineMedium!.copyWith(fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: SizedBox(
                  width: width,
                  height: 35,
                  child: ListView.builder(
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 5, bottom: 5),
                      child: filterChoicechip(
                          ontap: () {}, title: 'Bedtime', theme: theme),
                    ),
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/updownarrow.svg'),
                    const SizedBox(width: 10),
                    Text(
                      'Recents',
                      style: theme.textTheme.bodySmall!.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: storylistCard(
                      title: 'Title of the story',
                      storytype: 'bedtime',
                      theme: theme,
                      ontap: () {},
                      duration: '2.34',
                      image: '',
                    ),
                  ),
                  itemCount: 6,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget filterChoicechip(
      {required ThemeData theme,
      required String title,
      required void Function() ontap}) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        minimumSize: const Size(50, 32),
        maximumSize: const Size(200, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      child: Text(
        title,
        style: theme.textTheme.bodySmall!.copyWith(
            color: AppColors.kblackColor,
            fontSize: 13,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget storylistCard(
      {required ThemeData theme,
      required String title,
      required String storytype,
      required String duration,
      required String image,
      required void Function() ontap}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 70,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Row(
                  children: [
                    Text(storytype),
                    const Text(
                      ' - ',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(duration)
                  ],
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(flex: 1, child: Icon(Icons.ios_share_rounded))
        ],
      ),
    );
  }
}
