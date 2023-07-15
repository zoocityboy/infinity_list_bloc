import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget with PostWidgetMixin {
  const PostWidget({super.key, required this.child});
  factory PostWidget.video({required Widget child}) => PostWidget(
        child: child,
      );
  factory PostWidget.post({required Widget child}) => PostWidget(
        child: child,
      );
  factory PostWidget.image({required Widget child}) => PostWidget(
        child: child,
      );
  factory PostWidget.gallery({required Widget child}) => PostWidget(
        child: child,
      );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(children: [
        const Expanded(child: CardContent()),
        Divider(
          endIndent: 8,
          indent: 8,
          height: 2,
          color: Theme.of(context).colorScheme.outline,
        ),
        const CardFooter(),
      ]),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand();
  }
}

class CardFooter extends StatelessWidget {
  const CardFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 64,
    );
  }
}

mixin PostWidgetMixin on StatelessWidget {
  Widget card(Widget child) {
    return Card(child: child);
  }
}
