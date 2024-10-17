import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';

class NavBarLoading extends StatefulWidget {
  const NavBarLoading({
    super.key,
  });

  @override
  State<NavBarLoading> createState() => _NavBarLoadingState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _NavBarLoadingState extends State<NavBarLoading> {
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
                  image: AssetImage('assets/images/Rectangle 11723.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 25, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    height: 50,
                    child: Image.asset('assets/images/loadingplaybutton.gif'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
