import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/introduction/introduction_bloc.dart';
import 'package:pixieapp/blocs/introduction/introduction_event.dart';
import 'package:pixieapp/blocs/introduction/introduction_state.dart';
import 'package:pixieapp/const/colors.dart';

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
  TextEditingController nameofRelation = TextEditingController();
   

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<IntroductionBloc, IntroductionState>(
      listener: (context, state) {
        if (state is RelationUpdated) {}
      },
      builder: (context, state) {
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
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Text(
                        'Add a loved one',
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: AppColors.textColorblue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Container(
                          height: 43,
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
                      const SizedBox(height: 10),
                      Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(10),
                        child: TextField(
                          controller: nameofRelation,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.textColorblue,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                          cursorColor: AppColors.textColorblue,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.kwhiteColor,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.kwhiteColor),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.kwhiteColor),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.kwhiteColor),
                                borderRadius: BorderRadius.circular(10)),
                            errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: AppColors.kwhiteColor),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Type name',
                            hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.textColorGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.85,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (selectedRelation != null &&
                                  nameofRelation.text.isNotEmpty) {
                                context.read<IntroductionBloc>().add(
                                    RelationAdded(
                                        relation: selectedRelation!,
                                        relationName: nameofRelation.text));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              foregroundColor: AppColors.kwhiteColor,
                              backgroundColor: AppColors
                                  .buttonblue, // Text (foreground) color
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
                top: deviceHeight * 0.25,
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
      },
    );
  }
}
