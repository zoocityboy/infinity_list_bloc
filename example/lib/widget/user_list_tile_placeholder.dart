import 'package:flutter/material.dart';

import 'card_container.dart';
import 'shimmer_image.dart';

class UserListSkeletonTile extends StatelessWidget {
  const UserListSkeletonTile({
    super.key,
    this.page,
    this.indexOnPage,
  });
  final int? page;
  final int? indexOnPage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final label = '$page / $indexOnPage';
    return CardContainer(
      margin: const EdgeInsets.all(8),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ShimmerImage(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 64,
            child: ListTile(
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
              subtitle: SizedBox(
                height: 14,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                    ),
                    height: 14,
                  ),
                ),
              ),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorScheme.surfaceVariant,
                ),
                width: 32,
                height: 32,
                alignment: Alignment.center,
              ),
              trailing: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
