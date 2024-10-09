import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/loading_widget.dart';
import 'package:pixieapp/widgets/navbar2.dart';
import 'package:pixieapp/widgets/navbar3.dart';

class Firebasestory extends StatefulWidget {
  final DocumentReference<Object?> storyDocRef; // Accept the DocumentReference
  const Firebasestory({super.key, required this.storyDocRef});

  @override
  _FirebasestoryState createState() => _FirebasestoryState();
}

class _FirebasestoryState extends State<Firebasestory> {
  Map<String, dynamic>? storyData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch the story data from the document reference
    widget.storyDocRef.get().then((docSnapshot) {
      if (docSnapshot.exists) {
        setState(() {
          storyData = docSnapshot.data() as Map<String, dynamic>?;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    if (storyData == null) {
      return const Scaffold(
        body: Center(child: LoadingWidget()),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: deviceHeight * 0.3,
            leadingWidth: deviceWidth,
            collapsedHeight: deviceHeight * 0.1,
            pinned: true,
            floating: false,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                bool isCollapsed = top <= kToolbarHeight + 30;

                return FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  title: Text(
                    storyData?["title"] ?? "No data",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: AppColors.textColorWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: isCollapsed ? 5 : 20,
                    ),
                  ),
                  background: Image.asset(
                    'assets/images/sliverApp.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5,
                left: deviceHeight * 0.0294,
                right: deviceHeight * 0.0294,
                bottom: deviceHeight * 0.0294,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storyData?["story"] ?? "No data",
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: AppColors.textColorGrey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar3(
        documentReference: widget.storyDocRef,
        favstatus: storyData!['isfav'],
      ),
    );
  }
}
