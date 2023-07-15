import 'package:example/model/user.dart';
import 'package:example/presentation/widget/user_grid_tile.dart';
import 'package:example/presentation/widget/user_list_tile.dart';
import 'package:example/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../widget/app_bar_content.dart';

class UserGridPage extends StatefulWidget {
  const UserGridPage({super.key});

  @override
  State<UserGridPage> createState() => _UserGridPageState();
}

class _UserGridPageState extends State<UserGridPage> {
  final ScrollController scrollController = ScrollController();
  bool showScrollTop = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      MediaQuery.of(context).size.height;
      final showFab = scrollController.position.extentBefore >
          MediaQuery.of(context).size.height;
      if (showScrollTop != showFab) {
        setState(() {
          showScrollTop = showFab;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: const CardTheme(elevation: 0, color: Colors.transparent),
        ),
        child: CustomScrollView(controller: scrollController, slivers: [
          const SliverAppBar(
            actions: [],
            title: Text('Infinite ListView Cubit'),
            bottom: AppBarContent(),
          ),
          InfiniteSliverGrid<User>(
            limit: 20,
            useAnimation: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, item, index, {indexOnPage, key, page}) =>
                UserGridTile(
              item: item,
              index: index,
            ),
            itemPlacholderBuilder: (context, index, {indexOnPage, key, page}) =>
                UserGridTile.skeleton(index),
            loadNext: (page, limit) =>
                context.read<UserRepository>().list(page: page, limit: limit),
          ),
        ]),
      ),
      floatingActionButton: showScrollTop
          ? FloatingActionButton(
              child: const Icon(Icons.arrow_upward_outlined),
              onPressed: () {
                scrollController.jumpTo(0);
              },
            )
          : null,
    );
  }
}
