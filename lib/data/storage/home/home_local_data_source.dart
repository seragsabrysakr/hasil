import 'package:hassel/core/data/network/error_handler.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:injectable/injectable.dart';

const cashCategory = "cashCategory";
const cashProducts = "cashProducts";
// const CACHE_VIEW_CART_INTERVAL = 20 * 1000; // 1 minute cache in millis

abstract class HomeLocal {
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProducts();
  Future<void> saveCategoriesToCache(List<CategoryModel> items);
  Future<void> saveProductsToCache(List<ProductModel> items);
  clearCache();

  void removeFromCache(String key);
}

@Singleton(as: HomeLocal)
class CartLocalDataSourceImpl implements HomeLocal {
  Map<String, CachedItem> cacheMap = Map();
  Map<String, CachedItem> cacheMap1 = Map();

  @override
  void clearCache() {
    cacheMap.clear();
    cacheMap1.clear();
    print('cashed clear $cacheMap');
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    CachedItem? cachedItem = cacheMap[cashCategory];
    // return cachedItem?.data;
    if (cachedItem != null) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    CachedItem? cachedItem = cacheMap1[cashProducts];
    // return cachedItem?.data;
    if (cachedItem != null) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveCategoriesToCache(List<CategoryModel> items) async {
    cacheMap[cashCategory] = CachedItem(items);
  }

  @override
  Future<void> saveProductsToCache(List<ProductModel> items) async {
    cacheMap1[cashProducts] = CachedItem(items);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    // expirationTimeInMillis -> 60 sec
    // currentTimeInMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}
