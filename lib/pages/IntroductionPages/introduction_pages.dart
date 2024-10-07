import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pixieapp/blocs/introduction/introduction_state.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/models/Child_data_model.dart';
import 'package:pixieapp/widgets/add_loved_ones_bottomsheet.dart';
import 'package:pixieapp/widgets/add_new_character.dart';
import '../../blocs/introduction/introduction_bloc.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  // State field(s) for PageView widget.
  PageController? pageViewController;
  ClildDataModel childdata = ClildDataModel(
      name: "name",
      gender: Gender.prefernottosay,
      favthings: ["Motorbike", "Robot", "Monkey", "Race cars"],
      dob: DateTime.now(),
      lovedonce: []);
  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  // State field(s) for ChoiceChips widget.

  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedPronounIndex = -1;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController mother = TextEditingController();
  final TextEditingController father = TextEditingController();
  final TextEditingController GrandMother = TextEditingController();
  final TextEditingController GrandFather = TextEditingController();
  final TextEditingController pet = TextEditingController();
  final List<String> pronouns = ['He', 'She', 'Prefer not to say'];
  int currentpage_index = 0;

  DateTime selectedDate = DateTime.now();

  Widget _buildPronounButton(
      {required String text,
      required double width,
      required bool selected,
      required VoidCallback ontap}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: ontap,
      child: Container(
          height: 50,
          width: width,
          decoration: BoxDecoration(
            color: selected ? AppColors.kpurple : AppColors.kwhiteColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color:
                    selected ? AppColors.kwhiteColor : AppColors.kblackColor),
          ))),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    print(deviceWidth);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 215, 244),
        key: scaffoldKey,
        body: BlocConsumer<TextBloc, TextState>(
          listener: (context, state) {
            if (state is TextUpdated) {}
          },
          builder: (context, state) {
            String name = '';
            if (state is TextUpdated) {
              name = state.name;
            }
            return Container(
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
                      width: deviceWidth,
                      height: deviceHeight,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            20.0, 10.0, 20.0, 10.0),
                        child: SafeArea(
                          child: PageView(
                            controller: pageViewController ??=
                                PageController(initialPage: 0),
                            onPageChanged: (index) {
                              setState(() {
                                currentpage_index = index;
                              });
                            },
                            scrollDirection: Axis.horizontal,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE8DEF8),
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
                                      const SizedBox(width: 5),
                                      customSlider(percent: 1),
                                      customSlider(percent: 0),
                                      customSlider(percent: 0),
                                      const SizedBox(width: 10),
                                      Transform.rotate(
                                        angle: .2,
                                        child: Image.asset(
                                          'assets/images/star.png',
                                          width: 70,
                                          height: 80,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.5899,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Whom are you creating stories for?",
                                            style: theme.textTheme.displaySmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textColorblue,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "This helps Pixie personalise the stories",
                                            style: theme
                                                .textTheme.headlineSmall!
                                                .copyWith(
                                                    color: AppColors
                                                        .textColorblack,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "First Name",
                                            style: theme
                                                .textTheme.headlineSmall!
                                                .copyWith(
                                                    color: AppColors
                                                        .textColorblack,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.kwhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: TextField(
                                              controller: nameController,
                                              cursorColor:
                                                  AppColors.textColorblue,
                                              onChanged: (value) {
                                                setState(() {
                                                  childdata.name = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 15),
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                errorBorder: InputBorder.none,
                                                focusedErrorBorder:
                                                    InputBorder.none,
                                                disabledBorder:
                                                    InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                fillColor:
                                                    AppColors.kwhiteColor,
                                                hintText: 'Your child\'s name',
                                                hintStyle: theme
                                                    .textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: AppColors
                                                            .textColorGrey,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                focusColor:
                                                    AppColors.textColorblue,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "Pronoun",
                                            style: theme
                                                .textTheme.headlineSmall!
                                                .copyWith(
                                                    color: AppColors
                                                        .textColorblack,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              _buildPronounButton(
                                                  text: "He",
                                                  width: deviceWidth * 0.4305,
                                                  ontap: () {
                                                    setState(() {
                                                      childdata.gender =
                                                          Gender.male;
                                                    });
                                                  },
                                                  selected: childdata.gender ==
                                                          Gender.male
                                                      ? true
                                                      : false),
                                              SizedBox(
                                                  width: deviceWidth * 0.0277),
                                              _buildPronounButton(
                                                  text: "She",
                                                  width: deviceWidth * 0.4305,
                                                  ontap: () {
                                                    setState(() {
                                                      childdata.gender =
                                                          Gender.female;
                                                    });
                                                  },
                                                  selected: childdata.gender ==
                                                          Gender.female
                                                      ? true
                                                      : false),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          _buildPronounButton(
                                              text: "Prefer not to say",
                                              width: deviceWidth * 0.4305,
                                              ontap: () {
                                                setState(() {
                                                  childdata.gender =
                                                      Gender.prefernottosay;
                                                });
                                              },
                                              selected: childdata.gender ==
                                                      Gender.prefernottosay
                                                  ? true
                                                  : false),
                                          const SizedBox(height: 20),
                                          const SizedBox(height: 20),
                                          const Text("Date of Birth",
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(
                                            height: 200,
                                            child: CupertinoDatePicker(
                                              initialDateTime: selectedDate,
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                              onDateTimeChanged:
                                                  (DateTime newDate) {
                                                setState(() {
                                                  childdata.dob = newDate;
                                                });
                                              },
                                            ),
                                          ),
                                          // CupertinoButton(
                                          //   child: Text('Done'),
                                          //   onPressed: () =>
                                          //       Navigator.of(context).pop(),
                                          // ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                              /******************************************** */

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
                                      const SizedBox(width: 5),
                                      customSlider(percent: 0),
                                      customSlider(percent: 1),
                                      customSlider(percent: 0),
                                      const SizedBox(width: 10),
                                      Transform.rotate(
                                        angle: .2,
                                        child: Image.asset(
                                          'assets/images/star.png',
                                          width: 70,
                                          height: 80,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '''What are [name]'s favorite things?''',
                                    style: theme.textTheme.displaySmall!
                                        .copyWith(
                                            color: AppColors.textColorblue,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 25),
                                  Wrap(
                                      children: List<Widget>.generate(
                                          childdata.favthings.length,
                                          (int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ChoiceChip(
                                        elevation: 3,
                                        label: Text(
                                          childdata.favthings[index],
                                          style: const TextStyle(
                                              color: AppColors.kblackColor),
                                        ),
                                        selected: false,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        padding: const EdgeInsets.all(16),
                                      ),
                                    );
                                  })),
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
                                                  FocusScope.of(context)
                                                      .unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
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

                              /**************************************************** */

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFE8DEF8),
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
                                      const SizedBox(width: 5),
                                      customSlider(percent: 0),
                                      customSlider(percent: 0),
                                      customSlider(percent: 1),
                                      const SizedBox(width: 10),
                                      Transform.rotate(
                                        angle: .2,
                                        child: Image.asset(
                                          'assets/images/star.png',
                                          width: 70,
                                          height: 80,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.5899,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Who are [Name]’s loved ones?",
                                            style: theme.textTheme.displaySmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textColorblue,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "We can feature them in stories",
                                            style: theme
                                                .textTheme.headlineSmall!
                                                .copyWith(
                                                    color: AppColors
                                                        .textColorblack,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          const SizedBox(height: 20),
                                          Text(
                                            "Answer atleast one",
                                            style: theme
                                                .textTheme.headlineSmall!
                                                .copyWith(
                                                    color:
                                                        AppColors.textColorGrey,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                            children: [
                                              Relations(
                                                theme: theme,
                                                relationName: 'Mother',
                                                controller: mother,
                                                onChanged: (mom) {
                                                  setState(() {
                                                    childdata.lovedonce.add(
                                                        Lovedonces(
                                                            name: mom,
                                                            relation:
                                                                "Mother"));
                                                  });
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Relations(
                                                theme: theme,
                                                relationName: 'Father',
                                                controller: father,
                                                onChanged: (dad) {
                                                  setState(() {
                                                    childdata.lovedonce.add(
                                                        Lovedonces(
                                                            name: dad,
                                                            relation:
                                                                "Father"));
                                                  });
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Relations(
                                                theme: theme,
                                                relationName: 'GrandMother',
                                                controller: GrandMother,
                                                onChanged: (GM) {
                                                  setState(() {
                                                    childdata.lovedonce.add(
                                                        Lovedonces(
                                                            name: GM,
                                                            relation:
                                                                "GrandMother"));
                                                  });
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Relations(
                                                theme: theme,
                                                relationName: 'GrandFather',
                                                controller: GrandFather,
                                                onChanged: (GF) {
                                                  setState(() {
                                                    childdata.lovedonce.add(
                                                        Lovedonces(
                                                            name: GF,
                                                            relation:
                                                                "GrandFather"));
                                                  });
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Relations(
                                                theme: theme,
                                                relationName: 'Pet Dog',
                                                controller: pet,
                                                onChanged: (pet) {
                                                  setState(() {
                                                    childdata.lovedonce.add(
                                                        Lovedonces(
                                                            name: pet,
                                                            relation:
                                                                "Pet Dog"));
                                                  });
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const AddLovedOnesBottomSheet();
                                                      });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Container(
                                                      width: deviceWidth,
                                                      height: 47,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: const Color
                                                                  .fromARGB(
                                                                  255,
                                                                  178,
                                                                  178,
                                                                  178)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40)),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .textColorblack,
                                                              size: 20,
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                                'Add a loved one',
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                          ])),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  )
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
                                  if (currentpage_index == 2) {
                                    childdata.lovedonce.add(Lovedonces(
                                        relation: "Mother", name: mother.text));
                                    childdata.lovedonce.add(Lovedonces(
                                        relation: "Father", name: father.text));
                                    childdata.lovedonce.add(Lovedonces(
                                        relation: "GrandMother",
                                        name: GrandMother.text));
                                    childdata.lovedonce.add(Lovedonces(
                                        relation: "GrandFather",
                                        name: GrandFather.text));
                                    childdata.lovedonce.add(Lovedonces(
                                        relation: "Pet Dog", name: pet.text));
                                    List<Map<String, dynamic>> lovedOnceList =
                                        childdata.lovedonce
                                            .map((lovedonce) =>
                                                lovedonce.toMap())
                                            .toList();
                                    try {
                                      // Get the currently authenticated user
                                      User? user =
                                          FirebaseAuth.instance.currentUser;

                                      if (user != null) {
                                        String userId =
                                            user.uid; // Get the user ID

                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userId)
                                            .update({
                                          'email': user.email,
                                          'phone': '',

                                          'child_name': childdata.name,
                                          'gender': childdata.gender.name,
                                          'fav_things': childdata.favthings,
                                          'dob': childdata.dob,
                                          'loved_once': lovedOnceList,
                                          'displayName':
                                              "displayName", // Update as needed
                                          'photoURL':
                                              "photoURL", // Update as needed
                                          'newUser': false,
                                        });
                                        print("User data updated successfully");
                                        context.push('/splashScreen');
                                      } else {
                                        print(
                                            "No user is currently signed in.");
                                      }
                                    } catch (e) {
                                      print("Error updating user data: $e");
                                    }
                                  } else {
                                    await pageViewController?.nextPage(
                                      duration:
                                          const Duration(milliseconds: 300),
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
                                child: (currentpage_index == 2)
                                    ? Text("Done",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.textColorblue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400))
                                    : Text("Continue",
                                        style: theme.textTheme.bodyLarge!
                                            .copyWith(
                                                color: AppColors.textColorblue,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w400))),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
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

class Relations extends StatelessWidget {
  const Relations({
    super.key,
    required this.theme,
    required this.relationName,
    required this.controller,
    required this.onChanged,
  });
  final Function(String)? onChanged;
  final TextEditingController controller;
  final ThemeData theme;
  final String relationName;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          relationName,
          style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColors.textColorblack, fontWeight: FontWeight.w400),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kwhiteColor,
          ),
          width: deviceWidth * 0.5555,
          height: 48,
          child: TextField(
            textAlign: TextAlign.center,
            cursorColor: AppColors.textColorblue,
            onChanged: (value) {},
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: '''Type $relationName's name''',
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textColorGrey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
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
