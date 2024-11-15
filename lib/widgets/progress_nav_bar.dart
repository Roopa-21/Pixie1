import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Loading%20Navbar/loadingnavbar_bloc.dart';
import 'package:pixieapp/blocs/Loading%20Navbar/loadingnavbar_event.dart';
import 'package:pixieapp/blocs/Loading%20Navbar/loadingnavbar_state.dart';
import 'package:shimmer/shimmer.dart';

class ProgressNavBar extends StatefulWidget {
  const ProgressNavBar({super.key});

  @override
  State<ProgressNavBar> createState() => _ProgressNavBarState();
}

class _ProgressNavBarState extends State<ProgressNavBar> {
  @override
  @override
  void initState() {
    context.read<LoadingNavbarBloc>().add(StartLoadingNavbarEvent());
    super.initState();
  }

  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return BlocBuilder<LoadingNavbarBloc, LoadingNavbarState>(
      builder: (context, state) {
        // Determine which section is highlighted based on the state

        return Container(
          padding: const EdgeInsets.only(bottom: 10),
          height: 250,
          width: deviceWidth,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            image: DecorationImage(
              image: AssetImage('assets/images/Rectangle 11723.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 80,
                      width: deviceWidth,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xfffffce8),
                          Color.fromARGB(255, 249, 240, 206),
                          Color.fromARGB(255, 246, 230, 191),
                          Color.fromARGB(255, 251, 231, 185),
                          Color.fromARGB(255, 250, 221, 158),
                          Color.fromARGB(255, 247, 209, 140)
                        ]),
                        border: const Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(255, 242, 191, 234),
                            width: 5,
                          ),
                        ),
                        color: Colors.white.withOpacity(.4),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: const Color(0xff612ACE),
                                  highlightColor: state is! LoadingStateOne
                                      ? const Color(0xff612ACE)
                                      : Colors.white,
                                  child: Text(
                                    'Weaving\nstory',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: const Color(0xff612ACE),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: state is LoadingStateOne
                                      ? const Color(0xffc7acd5)
                                      : const Color(0xff612ACE),
                                  highlightColor: state is LoadingStateThree
                                      ? const Color(0xff612ACE)
                                      : Colors.white,
                                  child: Text(
                                    'Waking up\ncharacters',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: state is LoadingStateOne
                                          ? const Color(0xffc7acd5)
                                          : const Color(0xff612ACE),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: state is LoadingStateOne ||
                                          state is LoadingStateTwo
                                      ? const Color(0xffc7acd5)
                                      : const Color(0xff612ACE),
                                  highlightColor: state is! LoadingStateThree
                                      ? const Color(0xff612ACE)
                                      : Colors.white,
                                  child: Text(
                                    'Almost\nready!',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: state is LoadingStateOne ||
                                              state is LoadingStateTwo
                                          ? const Color(0xffc7acd5)
                                          : const Color(0xff612ACE),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Enjoy reading while we generate your audio adventure!",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: const Color(0xff612ACE),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: state is LoadingStateOne
                            ? Image.asset(
                                "assets/images/lodingnavlogo.png",
                                fit: BoxFit.contain,
                                width: 54,
                                height: 54,
                              )
                            : const SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: state is LoadingStateTwo
                            ? Image.asset(
                                "assets/images/lodingnavlogo.png",
                                fit: BoxFit.contain,
                                width: 54,
                                height: 54,
                              )
                            : const SizedBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: state is LoadingStateThree
                            ? Image.asset(
                                "assets/images/lodingnavlogo.png",
                                fit: BoxFit.contain,
                                width: 54,
                                height: 54,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
