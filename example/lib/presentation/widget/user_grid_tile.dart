import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../../core/remote_cache.dart';
import '../../model/user.dart';

class UserGridTile extends StatelessWidget {
  const UserGridTile({
    super.key,
    required this.index,
    required this.item,
    this.isSkeleton = false,
  });
  factory UserGridTile.skeleton(int index, {double? height}) {
    return UserGridTile(
      index: index,
      isSkeleton: true,
      item: null,
    );
  }
  final User? item;
  final bool isSkeleton;
  final int index;
  @override
  Widget build(BuildContext context) {
    final color = InfiniteListViewTheme.of(context).skeletonColor;
    final user = item;
    if (user == null) {
      // return Card(
      //   child: Column(
      //     children: [
      //       Expanded(child: SizedBox.expand()),
      //       ListTile(
      //         leading: CircleAvatar(
      //           backgroundColor: color,
      //           radius: 12,
      //         ),
      //         title: SizedBox(
      //           height: 16,
      //           child: FractionallySizedBox(
      //             alignment: Alignment.centerLeft,
      //             widthFactor: 0.7,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: color,
      //                 borderRadius: const BorderRadius.all(Radius.circular(8)),
      //               ),
      //               height: 16,
      //             ),
      //           ),
      //         ),
      //         subtitle: SizedBox(
      //           height: 14,
      //           child: FractionallySizedBox(
      //             alignment: Alignment.centerLeft,
      //             widthFactor: 0.5,
      //             child: Container(
      //               decoration: BoxDecoration(
      //                 color: color,
      //                 borderRadius: const BorderRadius.all(Radius.circular(8)),
      //               ),
      //               height: 10,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // );
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: color,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: color,
                ),
              ),
            ),
            Divider(
              indent: 4,
              endIndent: 4,
              height: 4,
              color: color,
            ),
            ListTile(
              dense: true,
              title: SizedBox(
                height: 14,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    height: 12,
                  ),
                ),
              ),
              subtitle: SizedBox(
                height: 12,
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    height: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              imageUrl: user.avatarUrl,
              cacheManager: RemoteCache(),
              fit: BoxFit.cover,
            ),
          ),
          Divider(
            indent: 4,
            endIndent: 4,
            height: 4,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          ListTile(
            dense: true,
            title: Text(user.nickName),
            subtitle: Text(
              user.email,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
