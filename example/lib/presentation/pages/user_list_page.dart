import 'package:example/model/user.dart';
import 'package:example/presentation/widget/user_list_tile.dart';
import 'package:example/repository/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../widget/app_bar_content.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
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
          InfiniteSliverList<User>(
            limit: 20,
            itemExtent: 64,
            useAnimation: false,
            useSeparated: false,
            itemBuilder: (context, item, index, {indexOnPage, key, page}) =>
                UserListTile(
              item: item,
              index: index,
            ),
            itemPlacholderBuilder: (context, index, {indexOnPage, key, page}) =>
                UserListTile.skeleton(index),
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

class DemoItem extends StatelessWidget {
  const DemoItem({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(style: textTheme.bodySmall, children: [
            TextSpan(
              text: '$value\n',
              style: textTheme.titleMedium,
            ),
            TextSpan(
              text: label,
              style: textTheme.bodySmall,
            ),
          ])),
    );
  }
}
