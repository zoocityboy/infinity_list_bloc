import 'package:example/model/post.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'feed/card_content.dart';
import 'feed/card_footer.dart';
import 'feed/card_header.dart';

class FeedListTile extends StatelessWidget {
  const FeedListTile({
    super.key,
    required this.item,
    this.page,
    this.indexOnPage,
  });
  final Post item;
  final int? page;
  final int? indexOnPage;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CardHeader(post: item),
          AspectRatio(
            aspectRatio: kContentAspectRatio,
            child: CardContent(item: item),
          ),
          CardFooter(post: item),
        ]);
  }
}
