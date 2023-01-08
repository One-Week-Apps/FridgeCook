import 'package:fridge_cook/src/domain/entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getAllProducts();
}
