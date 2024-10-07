import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/navbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _nameController.text = 'Zoe';
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
  

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height:deviceHeight,
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
                    Icon(Icons.arrow_back,
                        size: 24, color: AppColors.buttonblue),
                    SizedBox(
                      width: 20,
                    ),
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
                tabs: [
                  Container(
                    width: deviceWidth * 0.475,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.kwhiteColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                        child: Text(
                      "Name of chile",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textColorblack,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                  Container(
                    width: deviceWidth * 0.475,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.kwhiteColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                        child: Text(
                      "Family",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textColorblack,
                          fontWeight: FontWeight.w400),
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(
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

  Widget detailsChild(String title, String detailAnswer) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
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
            controller: _nameController,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textColorGrey,
              fontWeight: FontWeight.w400,
            ),
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
              hintText: 'Type $detailAnswer name',
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

  Widget profileChildTab(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          detailsChild('Name', 'abx'),
          Row(
            children: [
              Text(
                'Pronoun',
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColorblack,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                'Date Of Birth',
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColorblack,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(children: [
            Text(
              'Favorite Thing',
              style: theme.textTheme.bodyMedium!.copyWith(
                  color: AppColors.textColorblack, fontWeight: FontWeight.w400),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Delete my account",
              style: theme.textTheme.bodyLarge!.copyWith(
                  color: AppColors.textColorblue, fontWeight: FontWeight.w400),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: Colors.white,
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

  Widget profileFamilyTab() {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          detailsChild('Mother', 'abx'),
          const SizedBox(
            height: 20,
          ),
          detailsChild('Father', 'abx'),
          const SizedBox(
            height: 20,
          ),
          detailsChild('Grandmother', 'abx'),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
                width: deviceWidth,
                height: 47,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 178, 178, 178)),
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
                      Text('Add a loved one',
                          style: theme.textTheme.bodyLarge!
                              .copyWith(fontWeight: FontWeight.w500)),
                    ])),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              foregroundColor: Colors.white,
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
