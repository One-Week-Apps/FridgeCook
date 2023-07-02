import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/repositories/products_repository.dart';

class SharedPreferencesProductRepository extends ProductsRepository {

  final SharedPref _sharedPref = SharedPref();

  @override
  Future<bool> add(Product product) async {
    print("DEBUG_SESSION OK3d1");
    int productCount = await getProductsCount();
    productCount++;
    await _sharedPref.save(SharedPreferencesKeys.productCount, productCount);
    print("DEBUG_SESSION OK3d2");

    var key = _makeProductKey(productCount);
    await _sharedPref.save(key, product.toJson());
    print("DEBUG_SESSION OK3d3");

    print("DEBUG_SESSION OK3dEND");
    return true;
  }

  @override
  Future<bool> delete(String id) async {
    int productCount = await getProductsCount();
    if (productCount == 0) {
      return false;
    }

    var found = false;
    List<Product> listToRebuild = [];

    for (var i = 1 ; i < (productCount + 1) ; i++) {
      var key = _makeProductKey(i);
      try {
        var prodJson = await _sharedPref.read(key);
        var prod = Product.fromJson(prodJson);
        await _sharedPref.remove(key);
        
        print("DEBUG_SESSION HEIDI[$id], CANDIDATE = $i $key => $prodJson ${prod.name}");
        if (prod.name == id) {
          await _sharedPref.remove(key);
          await _sharedPref.save(SharedPreferencesKeys.productCount, productCount - 1);

          found = true;
        } else {
          // keep track of all items since we want to rebuild the list
          listToRebuild.add(prod);
        }
      } catch (e) {
        print("error: $id ${e.toString()}");
      }
    }

    // rebuild the whole list
    for (var i = 1 ; i < ((productCount - 1) + 1) ; i++) {
      var key = _makeProductKey(i);
      try {
        await _sharedPref.save(key, listToRebuild[i - 1]);
      } catch (e) {
        print("error: $id ${e.toString()}");
      }
    }

    return found;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    int productCount = await getProductsCount();

    if (productCount == 0) {
      return [];
    }

    var prods = <Product>[];
    for (var i = 1 ; i < (productCount + 1) ; i++) {
      var key = _makeProductKey(i);
      try {
        var prodJson = await _sharedPref.read(key);
        var prod = Product.fromJson(prodJson);
        prods.add(prod);
      } catch (e) {
        print("error: ${e.toString()}");
      }
    }

    return prods;
  }

  String _makeProductKey(int count) {
    return SharedPreferencesKeys.product + count.toString();
  }

  Future<int> getProductsCount() async {
    int productCount;

    try {
      productCount = await _sharedPref.read(SharedPreferencesKeys.productCount);
    } catch (e) {
      productCount = 0;
    }

    return productCount;
  }
  
  @override
  Future<Product> getProduct(String id) async {
    int productCount = await getProductsCount();
    if (productCount == 0) {
      return null;
    }

    for (var i = 1 ; i < (productCount + 1) ; i++) {
      var key = _makeProductKey(i);
      try {
        var prodJson = await _sharedPref.read(key);
        var prod = Product.fromJson(prodJson);
        if (prod.name == id) {
          return prod;
        }
      } catch (e) {
        print("error: $id ${e.toString()}");
      }
    }

    return null;
  }
  
  @override
  Future<bool> updateProduct(String id, int newQuantity) async {
    int productCount = await getProductsCount();
    if (productCount == 0) {
      return null;
    }

    for (var i = 1 ; i < (productCount + 1) ; i++) {
      var key = _makeProductKey(i);
      try {
        var prodJson = await _sharedPref.read(key);
        var prod = Product.fromJson(prodJson);
        prod = Product(prod.name, newQuantity, ProductCategory.food, prod.image);
        if (prod.name == id) {
          await _sharedPref.save(key, prod.toJson());
          return true;
        }
      } catch (e) {
        print("error: $id ${e.toString()}");
      }
    }

    return null;
  }

}