import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// class RemoteCache {
//   static const key = 'remoteCacheKey';
//   // static CacheManager instance = CacheManager(
//   //   Config(
//   //     key,
//   //     stalePeriod: const Duration(days: 15),
//   //     maxNrOfCacheObjects: 20000,
//   //     repo: JsonCacheInfoRepository(databaseName: key),
//   //     fileService: HttpFileService(),
//   //   ),
//   // );
//   static CacheManager instance = ImageCacheManager() as CacheManager;
// }
class RemoteCache extends CacheManager with ImageCacheManager {
  static const key = 'libRemoteCachedImageData';

  static final RemoteCache _instance = RemoteCache._();

  factory RemoteCache() {
    return _instance;
  }

  RemoteCache._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 15),
            repo: JsonCacheInfoRepository()
          ),
        );
}
