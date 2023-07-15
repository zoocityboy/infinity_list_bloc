import 'package:example/model/post.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../common/avatar.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return SizedBox(
      height: kToolbarHeight,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        leading: Avatar(user: post.user),
        title: RichText(
          text: TextSpan(
            style: textTheme.titleMedium,
            children: [
              TextSpan(
                text: post.user.nickName,
              ),
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(
                  Symbols.verified,
                  size: 16,
                  color: colorScheme.primary,
                  fill: 1,
                ),
              )),
            ],
          ),
        ),
        trailing: const Icon(Symbols.more_vert_rounded),
      ),
    );
  }
}

class CardHeaderSkeleton extends StatelessWidget {
  const CardHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return SizedBox(
      height: kToolbarHeight,
      child: IconTheme(
        data: IconThemeData(color: colorScheme.surfaceVariant),
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          leading: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surfaceVariant,
              )),
          title: SizedBox(
            height: 16,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                height: 16,
              ),
            ),
          ),
          trailing: const Icon(Symbols.more_vert_rounded),
        ),
      ),
    );
  }
}
