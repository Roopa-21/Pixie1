import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class PixieButton extends StatelessWidget {
  const PixieButton({
    Key? key,
    this.onPressed,
    required this.text,
    required this.color1,
    required this.color2,
  }) : super(key: key);
  final void Function()? onPressed;
  final String text;
  final Color color1;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final devicewidth = MediaQuery.of(context).size.width;
    final deviceheight = MediaQuery.of(context).size.height;
    print(deviceheight);
    print(devicewidth);
    return Container(
      height: 140,
      width: devicewidth,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            // AppColors.outerButtonColor1.withOpacity(0.092),
            // AppColors.textColor2.withOpacity(0.3664),
            Color.fromARGB(255, 246, 244, 234),
            Color.fromARGB(255, 205, 244, 229),
            Color.fromARGB(255, 174, 229, 202),
            Color.fromARGB(255, 174, 229, 202),
            Color.fromARGB(255, 235, 199, 175),
            Color.fromARGB(255, 235, 199, 175)
          ],
          stops: [0.01, 0.3, 0.5, 0.7, 0.8, 1],
          begin: Alignment.topLeft, // Start from the top-left corner
          end: Alignment.bottomRight,
        ),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(text,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
