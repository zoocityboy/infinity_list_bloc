import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';
import 'card_container.dart';
import 'shimmer_image.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.item,
    this.page,
    this.indexOnPage,
  });
  final User item;
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
          CachedNetworkImage(
            imageUrl: item.imageUrl,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            placeholder: (context, url) => const ShimmerImage(),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ListTile(
              key: ValueKey(item),
              title: Text(item.fullName),
              subtitle: Text(item.email),
              leading: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorScheme.surfaceVariant,
                ),
                width: 32,
                height: 32,
                alignment: Alignment.center,
                child: Text(item.initials),
              ),
              trailing: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
