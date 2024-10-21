import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.kwhiteColor,
                ),
                height: 56,
                width: deviceWidth,
                child: TextField(
                  enabled: false,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textColorblack,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    fillColor: AppColors.kwhiteColor,
                    focusColor: AppColors.textColorblue,
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
