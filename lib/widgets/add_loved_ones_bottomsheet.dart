import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/pixie_button.dart';

class AddLovedOnesBottomSheet extends StatefulWidget {
  const AddLovedOnesBottomSheet({super.key});

  @override
  State<AddLovedOnesBottomSheet> createState() =>
      _AddLovedOnesBottomSheetState();
}

class _AddLovedOnesBottomSheetState extends State<AddLovedOnesBottomSheet> {
  String? selectedRelation;
  bool isExpanded = false;

  final List<String> relations = [
    'Friend',
    'Brother',
    'Sister',
    'Uncle',
    'Aunt',
    'Pet Cat',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: deviceHeight * 0.8,
          width: deviceWidth,
          decoration: const BoxDecoration(
            color: AppColors.bottomSheetBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
            ),
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add a loved one',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: AppColors.textColorblue,
                          fontWeight: FontWeight.w400,
                        ),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.buttonblue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedRelation ?? 'Select Relation',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.textColorGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: AppColors.buttonblue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    cursorColor: AppColors.textColorblue,
                    decoration: InputDecoration(
                      hintText: 'Type name',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textColorGrey,
                          fontWeight: FontWeight.w400),
                      focusColor: AppColors.textColorblue,
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.textColorblue)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.buttonblue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
                          backgroundColor:
                              AppColors.buttonblue, // Text (foreground) color
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
          ),
        ),
        if (isExpanded)
          Positioned(
            top: deviceHeight * 0.2,
            left: 16,
            right: 16,
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(8),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: relations.length,
                itemBuilder: (context, index) {
                  final relation = relations[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedRelation = relation;
                        isExpanded = false;
                      });
                    },
                    child: Container(
                      color: AppColors.kwhiteColor,
                      height: 50,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Text(
                        relation,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.textColorblue,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
