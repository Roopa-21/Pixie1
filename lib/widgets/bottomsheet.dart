import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/pages/AddCharacter.dart/add_character.dart';
import 'package:pixieapp/widgets/choicechip.dart';

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
            ChoiceChips(
              options: const [
                ChipData('Elephant', Icons.star_purple500_rounded),
                ChipData('Name', Icons.star_purple500_rounded),
                ChipData('Hippopotamus', Icons.star_purple500_rounded),
                ChipData('Person', Icons.star_rate_outlined),
                ChipData('Friend', Icons.star_purple500_rounded),
                ChipData('Dog', Icons.star_purple500_rounded)
              ],
              onChanged: (val) => choiceChipsValues1 = val,
              selectedChipStyle: ChipStyle(
                backgroundColor: AppColors.sliderColor,
                textStyle: theme.textTheme.bodyMedium,
                iconColor: AppColors.sliderColor,
                iconSize: 18.0,
                elevation: 0.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
              unselectedChipStyle: ChipStyle(
                backgroundColor: AppColors.choicechipUnSelected,
                textStyle: theme.textTheme.bodySmall,
                iconColor: AppColors.sliderColor,
                iconSize: 16.0,
                elevation: 0.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
              chipSpacing: 10.0,
              rowSpacing: 10.0,
              multiselect: true,
              alignment: WrapAlignment.start,
              controller: choiceChipsValueController1 ??=
                  FormFieldController<List<String>>(
                [],
              ),
              wrapped: true,
            ),
          ],
        ),
      ),
    );
  }
}
