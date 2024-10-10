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

class MusicAndSpeedBottomsheet extends StatefulWidget {
  const MusicAndSpeedBottomsheet({
    super.key,
  });

  @override
  State<MusicAndSpeedBottomsheet> createState() =>
      _MusicAndSpeedBottomsheetState();
}

class _MusicAndSpeedBottomsheetState extends State<MusicAndSpeedBottomsheet> {
  @override
  Widget build(BuildContext context) {
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
                      'Music and speed of the story suitable for',
                      style: theme.textTheme.displaySmall!.copyWith(
                          color: AppColors.textColorblue,
                          fontWeight: FontWeight.w400,
                          fontSize: MediaQuery.of(context).size.width * .08),
                    ),
                    const SizedBox(height: 25),
                    choicechipbutton(
                        theme: theme,
                        title: "Bedtime",
                        selected:
                            state.musicAndSpeed == 'Bedtime' ? true : false,
                        ontap: () {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateMusicandspeedEvent('Bedtime'));
                          context.pop();
                        }),
                    choicechipbutton(
                        theme: theme,
                        title: "Playtime",
                        selected:
                            state.musicAndSpeed == 'Playtime' ? true : false,
                        ontap: () async {
                          context
                              .read<AddCharacterBloc>()
                              .add(const UpdateMusicandspeedEvent('Playtime'));
                          context.pop();
                        }),
                    const SizedBox(height: 40),
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
