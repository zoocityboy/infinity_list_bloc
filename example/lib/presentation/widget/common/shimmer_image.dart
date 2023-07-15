import 'package:flutter/material.dart';
import 'package:infinite_listview_bloc/presentation/theme/infinite_listview_theme.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerImage extends StatelessWidget {
  const ShimmerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Theme.of(context).colorScheme.surface,
      colorOpacity: .9, //Default value
      direction: const ShimmerDirection.fromLTRB(), //Default Value
      child: const SizedBox.expand(),
    );
  }
}

class CircularShimmer extends StatelessWidget {
  const CircularShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: InfiniteListViewTheme.of(context).skeletonColor,
      colorOpacity: .9, //Default value
      direction: const ShimmerDirection.fromLTRB(), //Default Value
      child: const SizedBox.expand(),
    );
  }
}
