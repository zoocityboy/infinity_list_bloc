import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    super.key,
    this.icon,
    this.title,
    this.message,
  });
  final Widget? icon;
  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Center(
            child: icon ??
                const Icon(
                  Icons.error,
                  size: 64,
                ),
          ),
        ),
        const SizedBox(height: 16),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title ?? "We couldn't find anything",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              message ?? 'Try changing your search query',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
