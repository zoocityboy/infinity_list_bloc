import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/remote_cache.dart';
import '../../../model/post.dart';
import '../common/shimmer_image.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key, required this.item});
  final Post item;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: item.imageUrl,
      cacheManager: RemoteCache(),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) => const ShimmerImage(),
    );
  }
}
