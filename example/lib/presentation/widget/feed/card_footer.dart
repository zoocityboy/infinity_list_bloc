import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../model/post.dart';

class CardFooter extends StatelessWidget {
  const CardFooter({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: IconTheme(
            data: IconThemeData(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                weight: 700),
            child: Row(
              children: [
                Expanded(
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    alignment: MainAxisAlignment.start,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Symbols.favorite_rounded)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Symbols.maps_ugc_rounded)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Symbols.send_rounded))
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_outline_rounded))
              ],
            ),
          ),
        ),
        SizedBox(
          height: 72,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${post.likes}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(
                        text: ' Likes ',
                      ),
                    ],
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
                  RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: post.comments.first.user.nickName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: ' ${post.comments.first.message}',
                          ),
                        ],
                        style: Theme.of(context).textTheme.bodySmall,
                      )),
                  Text(
                    'Show all comments(${post.comments.length})',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ]),
          ),
        )
      ],
    );
  }
}

class CardFooterSkeleton extends StatelessWidget {
  const CardFooterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: IconTheme(
            data: IconThemeData(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                weight: 700),
            child: Row(
              children: [
                Expanded(
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    alignment: MainAxisAlignment.start,
                    buttonPadding: EdgeInsets.zero,
                    children: [
                      IconButton(
                        onPressed: null,
                        icon: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceVariant,
                          radius: 12,
                        ),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceVariant,
                          radius: 12,
                        ),
                      ),
                      IconButton(
                        onPressed: null,
                        icon: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceVariant,
                          radius: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: null,
                  icon: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceVariant,
                    radius: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 72,
        )
      ],
    );
  }
}
