import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/models/Child_data_model.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key, required this.text});
  final String text;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

FormFieldController<List<String>>? choiceChipsValueController1;
List<String>? get choiceChipsValues1 => choiceChipsValueController1?.value;
set choiceChipsValues1(List<String>? val) =>
    choiceChipsValueController1?.value = val;

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  @override
  List<Lovedonces> lovedOnceList = [];
  int? selectedlovedone;
  void initState() {
    super.initState();
    fetchLovedOnes().then((lovedOnes) {
      setState(() {
        lovedOnceList = lovedOnes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: AppColors.bottomSheetBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.text,
                style: theme.textTheme.displayMedium?.copyWith(
                    color: AppColors.textColorblue,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 25),
            Wrap(
                children:
                    List<Widget>.generate(lovedOnceList.length, (int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ChoiceChip(
                  onSelected: (value) {
                    setState(() {
                      selectedlovedone = index;
                      // storydata.relative_name = lovedOnceList[index].name;
                      // storydata.relation = lovedOnceList[index].relation;
                    });
                    print(lovedOnceList[index].name);
                    print(lovedOnceList[index].relation);
                  },
                  selectedColor: AppColors.kpurple,
                  elevation: 3,
                  checkmarkColor: AppColors.kwhiteColor,
                  label: Text(
                    lovedOnceList[index].name,
                    style: TextStyle(
                        color: selectedlovedone == index
                            ? AppColors.kwhiteColor
                            : AppColors.kblackColor),
                  ),
                  selected: selectedlovedone == index ? true : false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}

Future<List<Lovedonces>> fetchLovedOnes() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) return [];

  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  List<dynamic> lovedOnceData = doc['loved_once'] ?? [];

  return lovedOnceData.map((item) => Lovedonces.fromMap(item)).toList();
}
