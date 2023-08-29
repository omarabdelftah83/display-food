
import 'package:mina/data/network/error_handle.dart';

import '../response/response.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 10000; //1 MIN CACHE

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImp implements LocalDataSource {
  ///run time cache
  Map<String, CacheItem> cacheMap = Map();


  @override
  Future<HomeResponse> getHomeData() {
    CacheItem? cacheItem = cacheMap[CACHE_HOME_KEY];
    if (cacheItem != null && cacheItem.isValid(CACHE_HOME_INTERVAL)) {
      return cacheItem.data;
      //return response to cache
    } else {
      throw ErrorHandle.handle(DataSource.CACHE_ERROR);
    }
  }


  @override
  void clearCache() {
  cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async{
    cacheMap[CACHE_HOME_KEY] = CacheItem(homeResponse);
  }
}

//save cache//
class CacheItem {
  dynamic data;
  int cacheTime = DateTime.now().microsecondsSinceEpoch;
  CacheItem(this.data);
}
///
extension CachedItemExtension on CacheItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    //time now_time save <= .expirationTimeInMillis
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
