import 'package:example/presentation/widget/app_bar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_listview_bloc/presentation/infinite_sliverlist.dart';

import '../../model/post.dart';
import '../../repository/post_repository.dart';
import '../widget/feed_list_tile.dart';
import '../widget/feed_list_tile_placeholder.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
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
            title: Text('Infinite SliverList Cubit'),
            collapsedHeight: kToolbarHeight,
            expandedHeight: kToolbarHeight * 2,
            flexibleSpace: FlexibleSpaceBar(
              background: AppBarContent(),
            ),
            pinned: false,
            floating: true,
            stretch: true,
          ),
          InfiniteSliverList<Post>(
            limit: 20,
            itemBuilder: (context, item, index, {indexOnPage, key, page}) =>
                FeedListTile(
              item: item,
              page: page,
              indexOnPage: indexOnPage,
            ),
            itemPlacholderBuilder: (context, index, {key, page, indexOnPage}) =>
                FeedListSkeletonTile(
              page: page,
              indexOnPage: indexOnPage,
            ),
            loadNext: (page, limit) =>
                context.read<PostRepository>().list(page: page, limit: limit),
          ),
        ]),
        // child: CustomScrollView(controller: scrollController, slivers: [
        //   SliverAppBar.large(
        //     title: const Text('Infinite ListView Cubit'),
        //   ),
        //   SliverList.builder(
        //     itemBuilder: (context, index) =>
        //         ListTile(title: Text('index # $index')),
        //     itemCount: 200,
        //   )
        // ]),
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
