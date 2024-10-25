import 'package:flutter/material.dart';

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

    return Container(
      height: 120,
      width: devicewidth,
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromARGB(255, 250, 175, 175), // Border color
              width: .5, // Border thickness
            ),
          ),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          image: DecorationImage(
              image: AssetImage("assets/images/Frame 1261154616.png"),
              fit: BoxFit.cover)),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
          ],
        ),
      ),
    );
  }
}
