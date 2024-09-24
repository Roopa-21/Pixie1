import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class PixieButton extends StatelessWidget {
  const PixieButton({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    final devicewidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      elevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      focusElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: onPressed,
      padding: const EdgeInsets.all(20),
      minWidth: double.infinity,
      color: AppColors.kwhiteColor,
      child: Text(
        text,
      ),
    );
  }
}
