

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/add_new_character.dart';
import 'package:pixieapp/widgets/choicechip.dart';

class AddCharacter extends StatefulWidget {
  const AddCharacter({super.key});

  @override
  State<AddCharacter> createState() => _AddCharacterState();
}

class _AddCharacterState extends State<AddCharacter> {
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController1;
  List<String>? get choiceChipsValues1 => choiceChipsValueController1?.value;
  set choiceChipsValues1(List<String>? val) =>
      choiceChipsValueController1?.value = val;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController2;
  List<String>? get choiceChipsValues2 => choiceChipsValueController2?.value;
  set choiceChipsValues2(List<String>? val) =>
      choiceChipsValueController2?.value = val;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController3;
  String? get choiceChipsValue3 =>
      choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) =>
      choiceChipsValueController3?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController4;
  String? get choiceChipsValue4 =>
      choiceChipsValueController4?.value?.firstOrNull;
  set choiceChipsValue4(String? val) =>
      choiceChipsValueController4?.value = val != null ? [val] : [];
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController5;
  List<String>? get choiceChipsValues5 => choiceChipsValueController5?.value;
  set choiceChipsValues5(List<String>? val) =>
      choiceChipsValueController5?.value = val;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController6;
  List<String>? get choiceChipsValues6 => choiceChipsValueController6?.value;
  set choiceChipsValues6(List<String>? val) =>
      choiceChipsValueController6?.value = val;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 215, 244),
        key: scaffoldKey,
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 231, 201, 249),
                Color.fromARGB(255, 248, 244, 187)
              ],
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 10.0, 20.0, 10.0),
                    child: SafeArea(
                      child: PageView(
                        controller: pageViewController ??=
                            PageController(initialPage: 0),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8DEF8), // Background color
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 30.0, 15.0, 0.0),
                                child: Text(
                                  'Let’s add in some characters...',
                                  style: theme.textTheme.displaySmall!.copyWith(
                                      color: AppColors.textColorblue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 25),
                              ChoiceChips(
                                options: const [
                                  ChipData(
                                      'Elephant', Icons.star_purple500_rounded),
                                  ChipData(
                                      'Name', Icons.star_purple500_rounded),
                                  ChipData('Hippopotamus',
                                      Icons.star_purple500_rounded),
                                  ChipData('Person', Icons.star_rate_outlined),
                                  ChipData(
                                      'Friend', Icons.star_purple500_rounded),
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
                                  backgroundColor:
                                      AppColors.choicechipUnSelected,
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
                              addbutton(
                                  title: "Add a character",
                                  width: 180,
                                  theme: theme,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: AddNewCharacter(
                                              text: "Name a\ncharacter",
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8DEF8), // Background color
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await pageViewController
                                              ?.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Add loved ones in...',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 25),
                              ChoiceChips(
                                options: const [
                                  ChipData('Mom', Icons.star_purple500_rounded),
                                  ChipData('Dad', Icons.star_purple500_rounded),
                                  ChipData(
                                      'Nidhi', Icons.star_purple500_rounded),
                                  ChipData('Mishka', Icons.star_rate_outlined),
                                  ChipData(
                                      'Friend', Icons.star_purple500_rounded),
                                  ChipData('Name', Icons.star_purple500_rounded)
                                ],
                                onChanged: (val) => choiceChipsValues2 = val,
                                selectedChipStyle: ChipStyle(
                                  backgroundColor: AppColors.sliderColor,
                                  textStyle: theme.textTheme.bodyMedium,
                                  iconColor: AppColors.sliderColor,
                                  iconSize: 18.0,
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      AppColors.choicechipUnSelected,
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
                                controller: choiceChipsValueController2 ??=
                                    FormFieldController<List<String>>(
                                  [],
                                ),
                                wrapped: true,
                              ),
                              addbutton(
                                  title: "Add",
                                  width: 100,
                                  theme: theme,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: AddNewCharacter(
                                              text: "Name a\ncharacter",
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8DEF8), // Background color
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await pageViewController
                                              ?.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 30.0, 15.0, 0.0),
                                child: Text(
                                  'What’s the occasion',
                                  style: theme.textTheme.displaySmall!.copyWith(
                                      color: AppColors.textColorblue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(height: 25),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Bead time",
                                  selected: true,
                                  ontap: () {}),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Play time",
                                  selected: false,
                                  ontap: () {}),
                              addbutton(
                                  title: "Add occasion",
                                  width: MediaQuery.of(context).size.width * .9,
                                  height: 55,
                                  theme: theme,
                                  onTap: () {})
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8DEF8), // Background color
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await pageViewController
                                              ?.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Language of the story',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 25),
                              choicechipbutton(
                                  theme: theme,
                                  title: "English",
                                  selected: true,
                                  ontap: () {}),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Hindi",
                                  selected: false,
                                  ontap: () {}),
                              addbutton(
                                  title: "Add language",
                                  width: MediaQuery.of(context).size.width * .9,
                                  height: 55,
                                  theme: theme,
                                  onTap: () {})
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8DEF8), // Background color
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await pageViewController
                                              ?.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  // const SizedBox(width: 5),
                                  // TextButton(
                                  //     onPressed: () async {
                                  //       await pageViewController?.nextPage(
                                  //         duration:
                                  //             const Duration(milliseconds: 300),
                                  //         curve: Curves.ease,
                                  //       );
                                  //     },
                                  //     child: const Text(
                                  //       "Skip",
                                  //       style: TextStyle(
                                  //           color: AppColors.textColorblue),
                                  //     ))
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Add a lesson',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 25),
                              ChoiceChips(
                                options: const [
                                  ChipData('Mom', Icons.star_purple500_rounded),
                                  ChipData('Dad', Icons.star_purple500_rounded),
                                  ChipData(
                                      'Nidhi', Icons.star_purple500_rounded),
                                  ChipData('Mishka', Icons.star_rate_outlined),
                                  ChipData(
                                      'Friend', Icons.star_purple500_rounded),
                                  ChipData('Name', Icons.star_purple500_rounded)
                                ],
                                onChanged: (val) => choiceChipsValues5 = val,
                                selectedChipStyle: ChipStyle(
                                  backgroundColor: AppColors.sliderColor,
                                  textStyle: theme.textTheme.bodyMedium,
                                  iconColor: AppColors.sliderColor,
                                  iconSize: 18.0,
                                  elevation: 0.0,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                unselectedChipStyle: ChipStyle(
                                  backgroundColor:
                                      AppColors.choicechipUnSelected,
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
                                controller: choiceChipsValueController5 ??=
                                    FormFieldController<List<String>>(
                                  [],
                                ),
                                wrapped: true,
                              ),
                              addbutton(
                                  title: "Add a character",
                                  width: 170,
                                  theme: theme,
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () =>
                                              FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: AddNewCharacter(
                                              text: "Name a\ncharacter",
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: const Color(
                                            0xFFE8DEF8), // Background color
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await pageViewController
                                              ?.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  customSlider(percent: 1),
                                  const SizedBox(width: 10),
                                  TextButton(
                                      onPressed: () {
                                        context.push('/CreateStoryPage');
                                      },
                                      child: const Text("Skip",
                                          style: TextStyle(
                                              color: AppColors.textColorblue)))
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Genre of the story',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 25),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Surprise me",
                                  ontap: () {},
                                  selected: true),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Funny",
                                  ontap: () {},
                                  selected: false),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Scifi",
                                  ontap: () {},
                                  selected: false),
                              addbutton(
                                  title: "Add a theme",
                                  width: MediaQuery.of(context).size.width * .9,
                                  theme: theme,
                                  onTap: () {})
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 140.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    border: Border(
                        top: BorderSide(
                            color: Color.fromARGB(255, 255, 213, 213),
                            strokeAlign: 1)),
                    color: Color.fromARGB(145, 255, 255, 255)),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 28),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.85,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (pageViewCurrentIndex == 5) {
                              context.push('/CreateStoryPage');
                            } else {
                              await pageViewController?.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Colors.white, // Text (foreground) color
                          ),
                          child: Text("Continue",
                              style: theme.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.textColorblue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
          height: 60,
          child: ElevatedButton(
            onPressed: () async {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              foregroundColor: selected == true
                  ? AppColors.buttonblue
                  : AppColors.buttonwhite,
              backgroundColor: selected == true
                  ? AppColors.buttonblue
                  : AppColors.buttonwhite, // Text (foreground) color
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

  Widget addbutton(
      {required ThemeData theme,
      required String title,
      required double width,
      required VoidCallback onTap,
      double height = 47}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 178, 178, 178)),
                borderRadius: BorderRadius.circular(40)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.add,
                    color: AppColors.textColorblack,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(title,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w500)),
                ])),
      ),
    );
  }
}

class FormFieldController<T> extends ValueNotifier<T?> {
  FormFieldController(this.initialValue) : super(initialValue);

  final T? initialValue;

  void reset() => value = initialValue;
  void update() => notifyListeners();
}

class FormListFieldController<T> extends FormFieldController<List<T>> {
  final List<T>? _initialListValue;

  FormListFieldController(super.initialValue)
      : _initialListValue = List<T>.from(initialValue ?? []);

  @override
  void reset() => value = List<T>.from(_initialListValue ?? []);
}
