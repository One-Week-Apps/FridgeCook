import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';
import 'package:fridge_cook/src/domain/repositories/products_repository.dart';

class InMemoryProductsRepository extends ProductsRepository {
  List<Product> products;
  InMemoryProductsRepository(this.products);

  @override
  Future<Product?> getProduct(String id) async {
    try {
      return products.firstWhere((element) => element.name == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> updateProduct(String id, ProductQuantity newQuantity) async {
    int index = products.indexWhere((element) => element.name == id);
    if (index == -1) {
      return false;
    }
    products[index] = Product(
      products[index].name,
      newQuantity,
      products[index].category,
      products[index].image,
    );
    return true;
  }

  @override
  Future<bool> add(Product product) async {
    try {
      products.firstWhere((element) => element.name == product.name);
      return false; // Product already exists
    } catch (e) {
      products.add(product);
      return true;
    }
  }

  @override
  Future<bool> delete(String id) async {
    try {
      products.firstWhere((element) => element.name == id);
      products.removeWhere((item) => item.name == id);
      return true;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<List<Product>> getAllProducts() async {
    return products;
  }
  
}
