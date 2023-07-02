import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/repositories/products_repository.dart';

class InMemoryProductsRepository extends ProductsRepository {
  List<Product> products;
  InMemoryProductsRepository(this.products);

  @override
  Future<Product> getProduct(String id) async {
    Product foundProduct;

    try {
      foundProduct = products.firstWhere((element) => element.name == id);
    } catch (e) {
      foundProduct = null;
    }

    return foundProduct;
  }

  @override
  Future<bool> updateProduct(String id, int newQuantity) async {
    int index = products.indexWhere((element) => element.name == id);
    if (index == -1)
      return false;
    products[index] = Product(products[index].name, newQuantity, products[index].category, products[index].image);
    return true;
  }

  @override
  Future<bool> add(Product product) async {

    Product existingProduct;

    try {
      existingProduct = products.firstWhere((element) => element.name == product.name);
    } catch (e) {
      existingProduct = null;
    }

    if(existingProduct != null) {
      return false;
    }

    products.add(product);
    return true;
  }

  @override
  Future<bool> delete(String id) async {

    Product existingProduct;

    try {
      existingProduct = products.firstWhere((element) => element.name == id);
    } catch (e) {
      existingProduct = null;
    }

    if(existingProduct == null) {
      return false;
    }

    products.removeWhere((item) => item.name == id);
    return true;
  }
  
  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }
  
}
