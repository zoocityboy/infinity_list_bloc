import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerImage extends StatelessWidget {
  const ShimmerImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Theme.of(context).colorScheme.surface,
      colorOpacity: .9, //Default value
      direction: const ShimmerDirection.fromLTRB(), //Default Value
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
