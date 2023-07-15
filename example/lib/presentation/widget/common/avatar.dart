import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_listview_bloc/infinite_listview_bloc.dart';

import '../../../core/remote_cache.dart';
import '../../../model/user.dart';
import 'shimmer_image.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.user, this.radius = 24});
  final User user;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: radius * 2,
      child: CachedNetworkImage(
        cacheManager: RemoteCache(),
        imageUrl: user.avatarUrl,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: InfiniteListViewTheme.of(context).skeletonColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        placeholder: (context, url) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: InfiniteListViewTheme.of(context).skeletonColor,
          ),
          child: const ShimmerImage(),
        ),
      ),
    );
  }
}
