import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/routes/routes.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          color: AppColors.kwhiteColor,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () => router.go('/HomePage'),
                icon: SvgPicture.asset(
                  'assets/images/home.svg',
                  width: 40,
                  height: 40,
                ),
              ),
              IconButton(
                onPressed: () => router.go('/MyStories'),
                icon: SvgPicture.asset(
                  'assets/images/Frame 4262.svg',
                  width: 40,
                  height: 40,
                ),
              ),
              IconButton(
                onPressed: () => router.push('/AddCharacter'),
                icon: SvgPicture.asset(
                  'assets/images/story.svg',
                  width: 40,
                  height: 40,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/images/navbar_icon3.svg',
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
