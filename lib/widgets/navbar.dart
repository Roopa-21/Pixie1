import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 2,right: 2),
      child: Container(
        
        width:MediaQuery.of(context).size.width ,
        decoration: const BoxDecoration(color: Color.fromARGB(255,211,196,242),image: DecorationImage(image: AssetImage("assets/images/navbar.png"),fit: BoxFit.fill)),
        child:  Padding(
          padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
             IconButton(onPressed: (){}, icon: SvgPicture.asset(
              'assets/images/navbar_icon1.svg',
              width: 40,  // Icon size
              height: 40,
              // color: Colors.white,  // Optional: to apply color filter to the SVG
            ),),
            IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddCharacter(),));
            }, icon: SvgPicture.asset(
              'assets/images/navbar_icon2.svg',
              width: 51,  // Icon size
              height: 51,
              // color: Colors.white,  // Optional: to apply color filter to the SVG
            ),),
            IconButton(onPressed: (){}, icon: SvgPicture.asset(
              'assets/images/navbar_icon3.svg',
              width: 40,  // Icon size
              height: 40,
              // color: Colors.white,  // Optional: to apply color filter to the SVG
            ),)
            ],
          ),
        ),
      ),
    );
  }
}