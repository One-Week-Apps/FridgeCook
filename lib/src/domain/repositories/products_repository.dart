import 'package:fridge_cook/src/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<bool> add(Product product);
  Future<List<Product>> getAllProducts();
}
