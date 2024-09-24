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
      height: deviceheight * 0.14749,
      width: devicewidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.outerButtonColor1.withOpacity(0.092),
            AppColors.textColor2.withOpacity(0.3664),
            AppColors.outerButtonColor2.withOpacity(0.4),
            AppColors.textColor2.withOpacity(0.4)
          ],
          begin: const Alignment(-0.919, -0.394),
          end: const Alignment(0.919, 0.394),
        ),
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
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
                style:
                    theme.textTheme.bodyMedium!.copyWith(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
