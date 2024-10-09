import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/models/Child_data_model.dart';
import 'package:pixieapp/widgets/LovedonceBottomsheet.dart';

class GenreBottomsheet extends StatefulWidget {
  const GenreBottomsheet({
    super.key,
  });

  @override
  State<GenreBottomsheet> createState() => _GenreBottomsheetState();
}

class _GenreBottomsheetState extends State<GenreBottomsheet> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return BlocBuilder<AddCharacterBloc, AddCharacterState>(
        builder: (context, state) => Container(
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: AppColors.bottomSheetBackground,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Padding(
                padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      'Genre of the story',
                      style: theme.textTheme.displaySmall!.copyWith(
                          color: AppColors.textColorblue,
                          fontSize: width * .08,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 10.0, 15.0, 0.0),
                      child: Text(
                        'Select one',
                        style: theme.textTheme.displaySmall!.copyWith(
                            color: AppColors.kgreyColor,
                            fontWeight: FontWeight.w400,
                            fontSize: width * .05),
                      ),
                    ),
                    const SizedBox(height: 25),
                    choicechipbutton(
                        theme: theme,
                        title: "Funny",
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateGenreEvent('Funny'));
                          context.pop();
                        },
                        selected: state.genre == "Funny" ? true : false),
                    choicechipbutton(
                        theme: theme,
                        title: "Horror",
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateGenreEvent('Horror'));
                          context.pop();
                        },
                        selected: state.genre == "Horror" ? true : false),
                    choicechipbutton(
                        theme: theme,
                        title: "Adventure",
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateGenreEvent('Adventure'));
                          context.pop();
                        },
                        selected: state.genre == "Adventure" ? true : false),
                    choicechipbutton(
                        theme: theme,
                        title: "Action",
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateGenreEvent('Action'));
                          context.pop();
                        },
                        selected: state.genre == "Action" ? true : false),
                    choicechipbutton(
                        theme: theme,
                        title: "Sci-fi",
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateGenreEvent('Sci-fi'));
                          context.pop();
                        },
                        selected: state.genre == "Sci-fi" ? true : false),
                    choicechipbutton(
                        theme: theme,
                        title: "Mystery",
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateGenreEvent('Mystery'));
                          context.pop();
                        },
                        selected: state.genre == "Mystery" ? true : false),
                  ],
                ),
              ),
            ));
  }

  Widget choicechipbutton(
          {required ThemeData theme,
          required String title,
          required VoidCallback ontap,
          required bool selected}) =>
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: 48,
          child: ElevatedButton(
            onPressed: ontap,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              foregroundColor: selected == true
                  ? AppColors.buttonblue
                  : AppColors.buttonwhite,
              backgroundColor: selected == true
                  ? AppColors.buttonblue
                  : AppColors.buttonwhite,
            ),
            child: Text(title,
                style: theme.textTheme.bodyLarge!.copyWith(
                    color: selected == true
                        ? AppColors.textColorWhite
                        : AppColors.textColorblack,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );
  Widget customSlider({required double percent}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
        child: LinearPercentIndicator(
          percent: percent,
          lineHeight: 9.0,
          animation: true,
          animateFromLastPercent: true,
          progressColor: AppColors.sliderColor,
          backgroundColor: AppColors.sliderBackground,
          barRadius: const Radius.circular(20.0),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
