import 'package:example/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import 'model/user.dart';
import 'widget/user_list_tile.dart';
import 'widget/user_list_tile_placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  bool showScrollTop = false;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      MediaQuery.of(context).size.height;
      final showFab = scrollController.position.extentBefore > MediaQuery.of(context).size.height;
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
      appBar: AppBar(
        title: const Text('Demo'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              DemoItem(
                label: 'Total Count',
                value: context.read<UserRepository>().totalCount.toString(),
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(style: Theme.of(context).textTheme.bodySmall, children: [
                    TextSpan(
                      text: '${context.read<UserRepository>().totalCount}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text: 'Total Count',
                    ),
                  ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '${context.read<UserRepository>().totalPages}\n',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: 'Total Pages ',
                ),
              ])),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: '${context.read<UserRepository>().pageSize}\n',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(
                  text: 'PageSize ',
                ),
              ])),
            ])),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          cardTheme: const CardTheme(elevation: 0, color: Colors.transparent),
        ),
        child: InfiniteListView<User>(
          scrollController: scrollController,
          limit: 20,
          itemExtent: MediaQuery.of(context).size.width,
          itemBuilder: (context, item, {indexOnPage, key, page}) => UserListTile(
            item: item,
            page: page,
            indexOnPage: indexOnPage,
          ),
          itemPlacholderBuilder: (context, {key, page, indexOnPage}) => UserListSkeletonTile(
            page: page,
            indexOnPage: indexOnPage,
          ),
          loadNext: (page, limit) => context.read<UserRepository>().list(page: page, limit: limit),
        ),
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: label,
              style: textTheme.bodySmall,
            ),
          ])),
    );
  }
}
