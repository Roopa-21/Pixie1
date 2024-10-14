import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/widgets/add_favorites_bottomsheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _nameController = TextEditingController();
  String? childName;
  String? pronoun;
  String? dateOfBirth;
  List<dynamic> favoriteThings = [];
  String? motherName;
  String? fatherName;
  String? grandMotherName;
  String? grandFatherName;
  String? petDogName;
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchUserData();
    _nameController = TextEditingController(text: childName);
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user?.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          childName = userDoc.data()?['child_name'] ?? 'Zoe';
          pronoun = userDoc.data()?['gender'] ?? 'prefer not to say';
          Timestamp dobTimestamp = userDoc.data()?['dob'];
          DateTime dobDateTime = dobTimestamp.toDate();

          dateOfBirth = DateFormat('dd/MM/yyyy').format(dobDateTime);
          favoriteThings =
              List<String>.from(userDoc.data()?['fav_things'] ?? []);

          List<dynamic> lovedOnes = userDoc.data()?['loved_once'] ?? [];

          for (var lovedOne in lovedOnes) {
            String? relation = lovedOne['relation'];
            String? name = lovedOne['name'];

            if (relation != null && name != null) {
              switch (relation) {
                case 'Mother':
                  motherName = name;
                  break;
                case 'Father':
                  fatherName = name;
                  break;
                case 'GrandMother':
                  grandMotherName = name;
                  break;
                case 'GrandFather':
                  grandFatherName = name;
                  break;
                case 'Pet Dog':
                  petDogName = name;
                  break;
                default:
                  break;
              }
            }
          }
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  void _editName() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change Name"),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Update name"),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Save"),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user?.uid)
                    .update({
                  'child_name': _nameController.text,
                });
                setState(() {
                  childName = _nameController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editDateOfBirth() {
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  maximumYear: DateTime.now().year,
                  minimumYear: 2000,
                  initialDateTime: selectedDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user?.uid)
                      .update({
                    'dob': selectedDate,
                  });

                  setState(() {
                    dateOfBirth = DateFormat('dd/MM/yyyy').format(selectedDate);
                  });

                  Navigator.of(context).pop();
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffead4f9),
              Color(0xfff7f1d1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.sliderColor,
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          AppColors.textColorGrey,
                          AppColors.textColorSettings,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(
                        Rect.fromLTWH(0.0, 0.0, bounds.width, bounds.height),
                      ),
                      child: Text(
                        "Profile",
                        style: theme.textTheme.headlineMedium!.copyWith(
                            fontSize: 24, color: AppColors.textColorWhite),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  setState(() {});
                },
                tabs: [
                  _tabTitle(deviceWidth, childName!, 0),
                  _tabTitle(deviceWidth, "Family", 1),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    profileChildTab(theme),
                    profileFamilyTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabTitle(double deviceWidth, String title, int index) {
    bool isSelected = _tabController.index == index;
    return Container(
      width: deviceWidth * 0.475,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.kpurple : AppColors.kwhiteColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color:
                  isSelected ? AppColors.kwhiteColor : AppColors.textColorblack,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Widget profileChildTab(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  detailsChild('Name', childName ?? 'Loading...', _editName),
                  const SizedBox(height: 20),
                  detailsChild('Pronoun', pronoun ?? 'Loading...', () {}),
                  const SizedBox(height: 20),
                  detailsChild('Date Of Birth', dateOfBirth.toString(),
                      _editDateOfBirth),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Favorite thing',
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textColorblack,
                            fontWeight: FontWeight.w400),
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5555,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              ...favoriteThings.map((thing) {
                                return ListTile(
                                  title: Text(thing),
                                  trailing: InkWell(
                                      onTap: () async {
                                        favoriteThings.remove(thing);
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user?.uid)
                                            .update({
                                          'fav_things': favoriteThings,
                                        });
                                        setState(() {});
                                      },
                                      child: Image.asset(
                                        'assets/images/delete.png',
                                        fit: BoxFit.cover,
                                      )),
                                );
                              }),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.5555,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: () async {
                                      await showModalBottomSheet(
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return const AddFavoritesBottomsheet();
                                        },
                                      );

                                      setState(() {});
                                    },
                                    child: Text(
                                      'Add your own',
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Delete my account",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textColorblue,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
            child: Text(
              "Save",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: AppColors.textColorblue,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailsChild(
      String title, String detailAnswer, VoidCallback onpressed) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium!.copyWith(
              color: AppColors.textColorblack, fontWeight: FontWeight.w400),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kwhiteColor,
          ),
          width: MediaQuery.of(context).size.width * 0.5555,
          height: 48,
          child: Center(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: TextEditingController(text: detailAnswer),
                    enabled: false,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textColorblack,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onpressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget profileFamilyTab() {
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          detailsChild('Mother', motherName ?? 'Loading...', _editName),
          const SizedBox(height: 20),
          detailsChild('Father', fatherName ?? 'Loading...', _editName),
          const SizedBox(height: 20),
          detailsChild(
              'Grandmother', grandMotherName ?? 'Loading...', _editName),
          const SizedBox(height: 20),
          detailsChild(
              'GrandFather', grandFatherName ?? 'Loading...', _editName),
          const SizedBox(height: 20),
          detailsChild('PetDog', petDogName ?? 'Loading...', _editName),
          const Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(deviceWidth, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
            ),
            child: Text(
              "Save",
              style: theme.textTheme.bodyLarge!.copyWith(
                color: AppColors.textColorblue,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
