import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.of(context).size.width * .7,
      height: MediaQuery.of(context).size.height * .2,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/animations/pixieloading_crop.gif'),
              fit: BoxFit.contain)),
    ));
  }
}
