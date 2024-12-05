import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
  static final instance = DefaultCacheManager();
  
  static Future<void> preloadImage(String url) async {
    await instance.downloadFile(url);
  }

  static Future<void> clearCache() async {
    await instance.emptyCache();
  }
} 