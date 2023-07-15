import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:personal/core/colors.dart';
import 'package:personal/features/dashboard/logic/cubit/navigation_cubit.dart';
import 'package:personal/features/profile/presentation/pages/profile_tab_page.dart';

import '../../../feed/presentation/pages/feed_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final pages = [
    const FeedPage(
      key: Key('feed'),
    ),
    Scaffold(
      key: const Key('discover'),
      body: Container(
        key: const Key('1'),
        color: primarColor,
      ),
    ),
    Scaffold(
      key: const Key('center'),
      body: Container(
        key: const Key('2'),
        color: secondaryColor,
      ),
    ),
    Scaffold(
      key: const Key('messages'),
      body: Container(
        key: const Key('3'),
        color: tertiaryColor,
      ),
    ),
    const ProfileTabPage(
      key: Key('4'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocBuilder<NavigationCubit, NavigationState>(
          builder: (context, state) {
            final pagex = pages[state.page];
            print('state: $state pagex: ${pagex.key}');
            return PageTransitionSwitcher(
              reverse: state.reverse,
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  transitionType: SharedAxisTransitionType.horizontal,
                  child: child,
                );
              },
              child: pagex,
            );
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return NavigationBar(
              selectedIndex: state.page,
              onDestinationSelected: (value) =>
                  context.read<NavigationCubit>().go(value),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Symbols.location_home_rounded),
                  selectedIcon: Icon(Symbols.location_home_sharp),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.search_check_rounded),
                  selectedIcon: Icon(Symbols.search_check_sharp),
                  label: 'Discover',
                ),
                NavigationDestination(
                  icon: Icon(LineIcons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.chat_bubble_outline_rounded),
                  selectedIcon: Icon(Symbols.chat_bubble_outline_sharp),
                  label: 'Messages',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.person_2_rounded),
                  selectedIcon: Icon(Symbols.person_2_sharp),
                  label: 'Profile',
                ),
              ]);
        },
      ),
    );
  }
}
