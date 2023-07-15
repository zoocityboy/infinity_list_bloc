import 'package:flutter/material.dart';
import 'package:personal/features/feed/presentation/widgets/post_widget.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('build: feedpage');
    final itemExtent = MediaQuery.of(context).size.width * .66;
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar.large(
        title: const Text('Feed'),
      ),
      SliverList.builder(
          itemBuilder: (context, index) => SizedBox(
                height: itemExtent,
                child: const PostWidget(child: SizedBox.expand()),
              ),
          itemCount: 200),
    ]));
  }
}
