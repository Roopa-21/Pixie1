import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class PlaylistBottomsheet extends StatefulWidget {
  const PlaylistBottomsheet({super.key});

  @override
  State<PlaylistBottomsheet> createState() => _PlaylistBottomsheetState();
}

class _PlaylistBottomsheetState extends State<PlaylistBottomsheet> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.bottomSheetBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      height: deviceHeight * .8,
      width: deviceWidth,
      child: Column(
        children: [
          Container(
            height: deviceHeight * .1,
            decoration: const BoxDecoration(
                color: const Color(0xff644a98),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: deviceWidth * 0.3),
                  child: Text(
                    'Your Library',
                    style: theme.textTheme.displaySmall!
                        .copyWith(color: AppColors.textColorWhite),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
