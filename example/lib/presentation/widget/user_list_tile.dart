import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../../core/remote_cache.dart';
import '../../model/user.dart';

class UserListTile extends StatelessWidget {
  const UserListTile({
    super.key,
    required this.index,
    required this.item,
    this.isSkeleton = false,
    this.height,
  });
  factory UserListTile.skeleton(int index, {double? height}) {
    return UserListTile(
      index: index,
      isSkeleton: true,
      item: null,
      height: height,
    );
  }
  final User? item;
  final bool isSkeleton;
  final int index;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final color = InfiniteListViewTheme.of(context).skeletonColor;
    final user = item;
    if (user == null) {
      return SizedBox(
        height: height,
        width: double.maxFinite,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            radius: 12,
          ),
          title: SizedBox(
            height: 16,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
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
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                height: 10,
              ),
            ),
          ),
        ),
      );
    }
    final maxDimens = height != null
        ? (height! * MediaQuery.of(context).devicePixelRatio).toInt()
        : null;
    return SizedBox(
      height: height,
      child: ListTile(
        title: Text(user.nickName),
        leading: CircleAvatar(
          backgroundColor: color,
          backgroundImage: CachedNetworkImageProvider(
            user.avatarUrl,
            cacheManager: RemoteCache(),
            maxHeight: maxDimens,
            maxWidth: maxDimens,
          ),
          radius: 12,
        ),
        subtitle: Text(user.email),
      ),
    );
  }
}
