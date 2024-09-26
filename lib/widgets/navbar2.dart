import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/routes/routes.dart';

class NavBar2 extends StatefulWidget {
  const NavBar2({super.key});

  @override
  State<NavBar2> createState() => _NavBar2State();
}

class _NavBar2State extends State<NavBar2> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            image:
                DecorationImage(image: AssetImage('assets/images/navbar.png'))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {},
                focusColor: Colors.white,
                color: Colors.white,
                hoverColor: Colors.white,
                splashColor: Colors.white,
                disabledColor: Colors.white,
                highlightColor: Colors.white,
                icon: SvgPicture.asset(
                  'assets/images/home-02.svg',
                  width: 40,
                  height: 40,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () => router.go('/StoryGeneratePage'),
                icon: SvgPicture.asset(
                  'assets/images/pausebutton.svg',
                  width: 60,
                  height: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 50,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        fav = !fav;
                      });
                      // router.push('/AddCharacter');
                    },
                    icon: SvgPicture.asset(
                      fav == true
                          ? 'assets/images/Heart_filled.svg'
                          : 'assets/images/Heart.svg',
                      width: fav == true ? 40 : 25,
                      height: fav == true ? 40 : 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
