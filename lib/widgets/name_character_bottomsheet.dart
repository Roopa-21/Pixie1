import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';

class NameCharacterBottomsheet extends StatefulWidget {
  const NameCharacterBottomsheet({super.key});

  @override
  State<NameCharacterBottomsheet> createState() =>
      _NameCharacterBottomsheetState();
}

class _NameCharacterBottomsheetState extends State<NameCharacterBottomsheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceheight = MediaQuery.of(context).size.height;
    final devicewidth = MediaQuery.of(context).size.width;
    return Container(
      height: MediaQuery.of(context).size.height * .6,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: AppColors.bottomSheetBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18), topRight: Radius.circular(18))),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add a character',
                  style: theme.textTheme.displayMedium?.copyWith(
                      color: AppColors.textColorblue,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              textCapitalization: TextCapitalization.sentences,
              cursorColor: AppColors.textColorblue,
              decoration: InputDecoration(
                hintText: 'Character name',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textColorGrey,
                    fontWeight: FontWeight.w400),
                focusColor: AppColors.textColorblue,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.textColorblue)),
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.85,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.buttonblue,
                  ),
                  child: Text("Add",
                      style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textColorWhite,
                          fontSize: 20,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
