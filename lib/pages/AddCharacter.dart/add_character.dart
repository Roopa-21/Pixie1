import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/add_new_character.dart';
import 'package:pixieapp/widgets/choicechip.dart';
import 'package:pixieapp/widgets/navbar.dart';

class AddCharacter extends StatefulWidget {
  const AddCharacter({super.key});

  @override
  State<AddCharacter> createState() => _AddCharacterState();
}

class _AddCharacterState extends State<AddCharacter> {
  PageController? pageViewController;
  int currentpage_index = 0;
  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  FormFieldController<List<String>>? choiceChipsValueController1;
  String? get choiceChipsValue1 =>
      choiceChipsValueController1?.value?.firstOrNull;
  set choiceChipsValue1(String? val) =>
      choiceChipsValueController1?.value = val != null ? [val] : [];

  FormFieldController<List<String>>? choiceChipsValueController2;
  String? get choiceChipsValue2 =>
      choiceChipsValueController2?.value?.firstOrNull;
  set choiceChipsValue2(String? val) =>
      choiceChipsValueController2?.value = val != null ? [val] : [];

  FormFieldController<List<String>>? choiceChipsValueController3;
  String? get choiceChipsValue3 =>
      choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) =>
      choiceChipsValueController3?.value = val != null ? [val] : [];

  FormFieldController<List<String>>? choiceChipsValueController4;
  String? get choiceChipsValue4 =>
      choiceChipsValueController4?.value?.firstOrNull;
  set choiceChipsValue4(String? val) =>
      choiceChipsValueController4?.value = val != null ? [val] : [];

  FormFieldController<List<String>>? choiceChipsValueController5;
  String? get choiceChipsValue5 =>
      choiceChipsValueController5?.value?.firstOrNull;
  set choiceChipsValue5(String? val) =>
      choiceChipsValueController5?.value = val != null ? [val] : [];

  FormFieldController<List<String>>? choiceChipsValueController6;
  String? get choiceChipsValue6 =>
      choiceChipsValueController6?.value?.firstOrNull;
  set choiceChipsValue6(String? val) =>
      choiceChipsValueController6?.value = val != null ? [val] : [];
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
          child: Padding(
            padding: EdgeInsets.only(
              top: Platform.isIOS ? 44.0 : 24.0,
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
                      child: PageView(
                        onPageChanged: (index) {
                          setState(() {
                            currentpage_index = index;
                          });
                        },
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
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8DEF8),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          context.pop();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  const SizedBox(width: 5),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                ],
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(height: 25),
                                    Text(
                                      'Music and speed of the story suitable for',
                                      style: theme.textTheme.displaySmall!
                                          .copyWith(
                                              color: AppColors.textColorblue,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 34),
                                    ),
                                    const SizedBox(height: 25),
                                    choicechipbutton(
                                        theme: theme,
                                        title: "Bedtime",
                                        selected: true,
                                        ontap: () {}),
                                    choicechipbutton(
                                        theme: theme,
                                        title: "Playtime",
                                        selected: false,
                                        ontap: () {}),
                                    const SizedBox(height: 40),
                                    Text(
                                      'Language of the story',
                                      style: theme.textTheme.displaySmall!
                                          .copyWith(
                                              color: AppColors.textColorblue,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 34),
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
                                  ],
                                ),
                              ),
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
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8DEF8),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            pageViewController?.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  const SizedBox(width: 5),
                                  customSlider(percent: 0),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  primary: true,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15.0, 25, 15.0, 0.0),
                                        child: Text(
                                          'Add a character to the story...',
                                          style: theme.textTheme.displaySmall!
                                              .copyWith(
                                                  color:
                                                      AppColors.textColorblue,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 34),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(15.0, 10.0, 15.0, 0.0),
                                        child: Text(
                                          'Select one',
                                          style: theme.textTheme.displaySmall!
                                              .copyWith(
                                                  color: AppColors.kgreyColor,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20),
                                        ),
                                      ),
                                      const SizedBox(height: 25),
                                      ChoiceChips(
                                        options: const [
                                          ChipData('Elephant',
                                              Icons.star_purple500_rounded),
                                          ChipData('Name',
                                              Icons.star_purple500_rounded),
                                          ChipData('Hippopotamus',
                                              Icons.star_purple500_rounded),
                                          ChipData('Person',
                                              Icons.star_rate_outlined),
                                          ChipData('Friend',
                                              Icons.star_purple500_rounded),
                                          ChipData('Dog',
                                              Icons.star_purple500_rounded)
                                        ],
                                        onChanged: (val) => choiceChipsValue1 =
                                            val?.firstOrNull,
                                        selectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              AppColors.sliderColor,
                                          textStyle: theme.textTheme.bodyMedium,
                                          iconColor: AppColors.sliderColor,
                                          iconSize: 18.0,
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        unselectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              AppColors.choicechipUnSelected,
                                          textStyle: theme.textTheme.bodySmall,
                                          iconColor: AppColors.sliderColor,
                                          iconSize: 16.0,
                                          elevation: 0.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        chipSpacing: 10.0,
                                        rowSpacing: 10.0,
                                        multiselect: true,
                                        alignment: WrapAlignment.start,
                                        controller:
                                            choiceChipsValueController1 ??=
                                                FormFieldController<
                                                    List<String>>(
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              enableDrag: false,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child:
                                                        const AddNewCharacter(
                                                      text: "Name a\ncharacter",
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          }),
                                      const SizedBox(height: 40),
                                      Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .175,
                                        decoration: BoxDecoration(
                                            color: AppColors.koffwhiteColor,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Pro Tip',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .kgreyColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Ask your little one:\nWhat should we name this character?',
                                                style: theme
                                                    .textTheme.displaySmall!
                                                    .copyWith(
                                                        color: AppColors
                                                            .textColorblue,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16),
                                              ),
                                              const SizedBox(height: 5),
                                              const TextField(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Enter character name',
                                                    hintStyle: TextStyle(
                                                        color: AppColors
                                                            .kgreyColor),
                                                    border:
                                                        UnderlineInputBorder(),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .kpurple)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: AppColors
                                                                    .kgreyColor)),
                                                    fillColor:
                                                        Colors.transparent),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
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
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8DEF8),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            pageViewController?.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  const SizedBox(width: 5),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  TextButton(
                                      onPressed: () {
                                        pageViewController!.jumpToPage(4);
                                      },
                                      child: const Text("Skip to end",
                                          style: TextStyle(
                                              color: AppColors.textColorblue)))
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Add a loved one to the story..',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 10.0, 15.0, 0.0),
                                child: Text(
                                  'Select one',
                                  style: theme.textTheme.displaySmall!.copyWith(
                                      color: AppColors.kgreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
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
                                onChanged: (val) =>
                                    choiceChipsValue2 = val?.firstOrNull,
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
                                  title: "Add a loved one",
                                  width: 200,
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
                                            child: const AddNewCharacter(
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
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8DEF8),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            pageViewController?.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  const SizedBox(width: 5),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 1),
                                  customSlider(percent: 0),
                                  TextButton(
                                      onPressed: () {
                                        pageViewController!.jumpToPage(4);
                                      },
                                      child: const Text("Skip to end",
                                          style: TextStyle(
                                              color: AppColors.textColorblue)))
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Add a lesson to the story..',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontSize: 34,
                                    fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 10.0, 15.0, 0.0),
                                child: Text(
                                  'Select one',
                                  style: theme.textTheme.displaySmall!.copyWith(
                                      color: AppColors.kgreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 25),
                              ChoiceChips(
                                options: const [
                                  ChipData('Gratitude',
                                      Icons.star_purple500_rounded),
                                  ChipData('Respect everyone',
                                      Icons.star_purple500_rounded),
                                  ChipData('Being Honest',
                                      Icons.star_purple500_rounded),
                                  ChipData(
                                      'Help others', Icons.star_rate_outlined),
                                  ChipData('Wait for your turn',
                                      Icons.star_purple500_rounded),
                                  ChipData('Eat Veggies',
                                      Icons.star_purple500_rounded),
                                  ChipData('Ask before you take',
                                      Icons.star_purple500_rounded),
                                  ChipData(
                                      'Frienship', Icons.star_purple500_rounded)
                                ],
                                onChanged: (val) =>
                                    choiceChipsValue5 = val?.firstOrNull,
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
                                            child: const AddNewCharacter(
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
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8DEF8),
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          setState(() {
                                            pageViewController?.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.ease,
                                            );
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                          color: AppColors.sliderColor,
                                          size: 23,
                                        ),
                                      )),
                                  const SizedBox(width: 5),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 0),
                                  customSlider(percent: 1),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Text(
                                'Genre of the story',
                                style: theme.textTheme.displaySmall!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15.0, 10.0, 15.0, 0.0),
                                child: Text(
                                  'Select one',
                                  style: theme.textTheme.displaySmall!.copyWith(
                                      color: AppColors.kgreyColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(height: 25),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Funny",
                                  ontap: () {},
                                  selected: true),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Horror",
                                  ontap: () {},
                                  selected: false),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Adventure",
                                  ontap: () {},
                                  selected: false),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Action",
                                  ontap: () {},
                                  selected: false),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Sci-fi",
                                  ontap: () {},
                                  selected: false),
                              choicechipbutton(
                                  theme: theme,
                                  title: "Mystery",
                                  ontap: () {},
                                  selected: false),
                              // addbutton(
                              //     title: "Add a theme",
                              //     width: MediaQuery.of(context).size.width * .9,
                              //     theme: theme,
                              //     onTap: () {})
                            ],
                          ),
                        ],
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            currentpage_index == 2 || currentpage_index == 3
                                ? Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          pageViewController?.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.ease,
                                          );
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width,
                                            50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        "Skip",
                                        style:
                                            theme.textTheme.bodyLarge!.copyWith(
                                          color: AppColors.textColorblue,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  print(pageViewCurrentIndex);
                                  if (currentpage_index == 4) {
                                    context.push('/CreateStoryPage');
                                  } else {
                                    setState(() {
                                      pageViewController?.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Continue",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.textColorblue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
          height: 48,
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
