import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ItemAnimatedWrapper extends StatelessWidget {
  const ItemAnimatedWrapper({
    required this.child,
    required this.index,
    super.key,
    this.horizontalOffset = 0,
    this.verticalOffset = 0,
    this.duration = kThemeAnimationDuration,
  });
  final Widget child;
  final int index;
  final double horizontalOffset;
  final double verticalOffset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: duration,
      child: SlideAnimation(
        horizontalOffset: horizontalOffset,
        verticalOffset: verticalOffset,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}
