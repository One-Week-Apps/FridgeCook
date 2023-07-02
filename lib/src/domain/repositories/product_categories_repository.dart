import 'package:fridge_cook/src/domain/entities/product_category.dart';

abstract class ProductCategoriesRepository {
  Future<List<ProductCategory>> getAllCategories();
}
