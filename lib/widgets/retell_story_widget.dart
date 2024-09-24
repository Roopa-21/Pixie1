import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class RetellWidget extends StatefulWidget {
  const RetellWidget({super.key});

  @override
  State<RetellWidget> createState() => _RetellWidgetState();
}

class _RetellWidgetState extends State<RetellWidget> {
  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Stack(clipBehavior: Clip.none, children: [
      Container(
        height: deviceheight * 0.3687,
        width: devicewidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/retell.png"),
                fit: BoxFit.fill)),
      ),
      Positioned(
        bottom: devicewidth * 0.13,
        left: 0,
        right: 0,
        child: Padding(
          padding: EdgeInsets.only(
            left: devicewidth * 0.044,
            right: devicewidth * 0.044,
          ),
          child: Column(
            children: [
              Image.asset('assets/images/star.png'),
              Padding(
                padding: EdgeInsets.only(bottom: devicewidth * 0.044),
                child: Container(
                  height: deviceheight * 0.1474,
                  width: devicewidth,
                  padding: EdgeInsets.symmetric(
                      vertical: devicewidth * 0.044,
                      horizontal: devicewidth * 0.044),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.98),
                        AppColors.cardColorRetell.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.secondaryColor,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Re-tell the story',
                          style: theme.textTheme.bodyLarge!.copyWith(
                              color: AppColors.iconColor,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(
                          'With helpful cue-cards to co-create with your\n family together!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: AppColors.iconColor)),
                    ],
                  ),
                ),
              ),
              Text('Something not right with this story?',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.buttonColor1)),
            ],
          ),
        ),
      )
    ]);
  }
}
