import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/post_repository.dart';

class DemoItem extends StatelessWidget {
  const DemoItem({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(style: textTheme.bodySmall, children: [
            TextSpan(
              text: '$value\n',
              style: textTheme.titleMedium,
            ),
            TextSpan(
              text: label,
              style: textTheme.bodySmall,
            ),
          ])),
    );
  }
}

class AppBarContent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarContent({super.key});

  @override
  PreferredSize build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Center(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DemoItem(
                label: 'Total Count',
                value: context.read<PostRepository>().totalCount.toString(),
              ),
              const SizedBox(
                height: 32,
                child: VerticalDivider(
                  width: 4,
                ),
              ),
              DemoItem(
                label: 'Total Pages',
                value: context.read<PostRepository>().totalPages.toString(),
              ),
              const SizedBox(
                height: 32,
                child: VerticalDivider(
                  width: 4,
                ),
              ),
              DemoItem(
                label: 'Page Size',
                value: context.read<PostRepository>().pageSize.toString(),
              ),
            ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
