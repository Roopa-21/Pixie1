import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/routes/routes.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

bool home = true;
bool create = false;
bool library = false;
bool settings = false;

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        home = true;
                        create = false;
                        library = false;
                        settings = false;
                      });
                      router.go('/HomePage');
                    },
                    icon: SvgPicture.asset(
                      home == true
                          ? 'assets/images/home_selected.svg'
                          : 'assets/images/home-02.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Text('Home',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 13))
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        home = false;
                        create = true;
                        library = false;
                        settings = false;
                      });
                      router.push('/AddCharacter');
                    },
                    icon: SvgPicture.asset(
                      create == true
                          ? 'assets/images/create_selected.svg'
                          : 'assets/images/story.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Text('Create',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 13))
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        home = false;
                        create = false;
                        library = true;
                        settings = false;
                      });
                      router.go('/MyStories');
                    },
                    icon: SvgPicture.asset(
                      library == true
                          ? 'assets/images/Library_selected.svg'
                          : 'assets/images/Library.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Text('Library',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 13))
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        home = false;
                        create = false;
                        library = false;
                        settings = true;
                      });
                    },
                    icon: SvgPicture.asset(
                      settings == true
                          ? 'assets/images/settings_selected.svg'
                          : 'assets/images/navbar_icon3.svg',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Text('Settings',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 13))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
