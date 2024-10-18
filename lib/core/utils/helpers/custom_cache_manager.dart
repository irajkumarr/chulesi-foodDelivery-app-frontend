import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class MyCustomCacheManager extends CacheManager {
  static const key = 'customCache';

  static final MyCustomCacheManager _instance =
      MyCustomCacheManager._internal();

  factory MyCustomCacheManager() {
    return _instance;
  }

  MyCustomCacheManager._internal()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7), // Keep cache for 7 days
            maxNrOfCacheObjects: 100, // Max number of cached items
          ),
        );

  static MyCustomCacheManager get instance => _instance;
}

void checkCache(String url) async {
  final cacheManager = MyCustomCacheManager.instance;
  final file = await cacheManager.getFileFromCache(url);

  if (file != null) {
    print("Image is loaded from cache.");
  } else {
    print("Image is not cached, fetching from network...");
  }
}
