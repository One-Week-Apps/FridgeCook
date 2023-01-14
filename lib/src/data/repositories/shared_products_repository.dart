import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/data/repositories/SharedPref.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/repositories/products_repository.dart';

class SharedPreferencesProductRepository extends ProductsRepository {

  final SharedPref _sharedPref = SharedPref();

  @override
  Future<bool> add(Product product) async {
    int productCount;
    try {
      productCount = await _sharedPref.read(SharedPreferencesKeys.productCount);
    } catch (e) {
      productCount = 0;
    }
    productCount++;
    await _sharedPref.save(SharedPreferencesKeys.productCount, productCount);

    var key = _makeProductKey(productCount);
    await _sharedPref.save(key, product);

    return true;
  }

  @override
  Future<List<Product>> getAllProducts() async {
    var prods = <Product>[];
    int productCount;
    try {
      productCount = await _sharedPref.read(SharedPreferencesKeys.productCount);
    } catch (e) {
      return [];
    }

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

}