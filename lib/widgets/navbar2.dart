import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';

class NavBar2 extends StatefulWidget {
  final DocumentReference<Object?>? documentReference;
  const NavBar2({super.key, required this.documentReference});

  @override
  State<NavBar2> createState() => _NavBar2State();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _NavBar2State extends State<NavBar2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              image: DecorationImage(
                  image: AssetImage('assets/images/navbar.png'))),
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
                    'assets/images/home_unselect.svg',
                    width: 40,
                    height: 40,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
                        context
                            .read<AddCharacterBloc>()
                            .add(UpdatefavbuttonEvent(!state.fav));
                        updatefirebase(
                            docRef: widget.documentReference!, fav: !state.fav);
                      },
                      icon: SvgPicture.asset(
                        state.fav == true
                            ? 'assets/images/Heart_filled.svg'
                            : 'assets/images/Heart.svg',
                        width: state.fav == true ? 40 : 25,
                        height: state.fav == true ? 40 : 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updatefirebase(
      {required bool fav, required DocumentReference<Object?> docRef}) async {
    if (fav) {
      // Remove the story from favorites
      await docRef.update({
        'isfav': true,
      });
      print('Story added to fav');
    } else {
      await docRef.update({
        'isfav': false,
      });
      print('Story removed from fav');
    }
  }
}
