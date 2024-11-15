import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class ProgressNavBar extends StatefulWidget {
  const ProgressNavBar({super.key});

  @override
  State<ProgressNavBar> createState() => _ProgressNavBarState();
}

class _ProgressNavBarState extends State<ProgressNavBar> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      height: 180,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        image: DecorationImage(
            image: AssetImage('assets/images/Rectangle 11723.png'),
            fit: BoxFit.fill),
      ),
      child: Container(
      margin: EdgeInsets.only(bottom: deviceWidth * 0.03),
      padding: EdgeInsets.symmetric(
          vertical: deviceWidth * 0.07, horizontal: deviceWidth * 0.05),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
          
            width: 5,
          ),
        ),
        color: Colors.white.withOpacity(.4),
        borderRadius: BorderRadius.circular(12),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color.fromARGB(100, 206, 190, 251),
        //     blurRadius: 5,
        //     spreadRadius: 1,
        //     offset: Offset(0, 5),
        //   )
        // ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('title',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.kgreyColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text('value',
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.iconColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
         
        ],
      ),
    )
    );
  }
}
