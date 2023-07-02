import 'package:fridge_cook/src/app/CustomImages.dart';

class ProductCategory {
  final String _name;
  final String _image;
  get name => _name;
  get image => _image;
  const ProductCategory._internal(this._name, this._image);
  toString() => 'ProductCategory.$_name.$_image';

  static const vegetables = const ProductCategory._internal('Vegetables', CustomImages.vegetables);
  static const meat = const ProductCategory._internal('Meat', CustomImages.meat);
  static const fish = const ProductCategory._internal('Fish', CustomImages.fish);
  static const dairy = const ProductCategory._internal('Dairy', CustomImages.dairy);
  static const fruits = const ProductCategory._internal('Fruits', CustomImages.fruits);
  static const drinks = const ProductCategory._internal('Drinks', CustomImages.drinks);
  static const cereals = const ProductCategory._internal('Cereals', CustomImages.cereals);
  static const sugar = const ProductCategory._internal('Sugar', CustomImages.sugar);
  static const food = const ProductCategory._internal('Food', CustomImages.food);

  static ProductCategory fromName(String name) {
    ProductCategory category;
    switch (name.toLowerCase()) {
      case 'Vegetables':
      category = vegetables;
      break;
      case 'Meat':
      category = meat;
      break;
      case 'Fish':
      category = fish;
      break;
      case 'Dairy':
      category = dairy;
      break;
      case 'Fruits':
      category = fruits;
      break;
      case 'Drinks':
      category = drinks;
      break;
      case 'Cereals':
      category = cereals;
      break;
      case 'Sugar':
      category = sugar;
      break;
      case 'Food':
      category = food;
      break;
    }
    return category;
  }
}
