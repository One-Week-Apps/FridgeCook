import 'package:fridge_cook/src/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<bool> add(Product product);
  Future<bool> delete(String id);
  Future<List<Product>> getAllProducts();
  Future<Product?> getProduct(String id);
  Future<bool> updateProduct(String id, int newQuantity);
}
