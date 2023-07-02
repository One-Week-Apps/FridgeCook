import 'package:fridge_cook/src/domain/entities/product_category.dart';
import '../../domain/repositories/product_categories_repository.dart';

class DataProductCategoriesRepository extends ProductCategoriesRepository {
  List<ProductCategory> categories;
  static DataProductCategoriesRepository _instance = DataProductCategoriesRepository._internal();
  DataProductCategoriesRepository._internal() {
    categories = <ProductCategory>[];
    categories.addAll([
      ProductCategory.fruits,
      ProductCategory.dairy,
      ProductCategory.vegetables,
      ProductCategory.meat,
      ProductCategory.fish,
      ProductCategory.cereals,
      ProductCategory.drinks,
      ProductCategory.sugar,
      ProductCategory.food,
    ]);
  }
  factory DataProductCategoriesRepository() => _instance;

  @override
  Future<List<ProductCategory>> getAllCategories() async {
    return categories;
  }
}
