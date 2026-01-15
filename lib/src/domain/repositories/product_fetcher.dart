import 'package:fridge_cook/src/domain/entities/product.dart';

abstract class ProductFetcher {
  Future<Product?> fetchProduct(String id);
}
