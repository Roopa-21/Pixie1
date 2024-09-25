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

    return Container(
      height: 170,
      width: devicewidth,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Frame 1261154616.png"),
              fit: BoxFit.fill)),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75),
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
