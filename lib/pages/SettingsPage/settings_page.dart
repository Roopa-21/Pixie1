import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pixieapp/widgets/navbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff9f3cd),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Settings",
                  style: theme.textTheme.headlineMedium!.copyWith(fontSize: 24),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  height: height * .73,
                  child: ListView.builder(
                    itemBuilder: (context, index) => profilelistCard(
                        title: 'profile',
                        ontap: () {},
                        icon_path: '',
                        theme: theme),
                    itemCount: 7,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }

  Widget profilelistCard(
      {required ThemeData theme,
      required String title,
      required String icon_path,
      required void Function() ontap}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/Heart_filled.svg',
          ),
          const SizedBox(width: 10),
          Text(title),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
