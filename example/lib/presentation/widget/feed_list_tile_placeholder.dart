import 'package:example/presentation/widget/feed/card_header.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'common/shimmer_image.dart';
import 'feed/card_footer.dart';

class FeedListSkeletonTile extends StatelessWidget {
  const FeedListSkeletonTile({
    super.key,
    this.page,
    this.indexOnPage,
  });
  final int? page;
  final int? indexOnPage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const CardHeaderSkeleton(),
          AspectRatio(
            aspectRatio: kContentAspectRatio,
            child: Container(
              color: colorScheme.surfaceTint,
              child: const ShimmerImage(),
            ),
          ),
          const CardFooterSkeleton(),
        ]);
  }
}
