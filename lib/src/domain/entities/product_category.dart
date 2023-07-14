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

  static List<String> getValues() {
    return ["vegetables", "meat", "fish", "dairy", "fruits", "drinks", "cereals", "sugar"];
  }

  static ProductCategory fromName(String name) {
    ProductCategory category = food;
    switch (name.toLowerCase()) {
      case 'vegetables':
      category = vegetables;
      break;
      case 'meat':
      category = meat;
      break;
      case 'fish':
      category = fish;
      break;
      case 'dairy':
      category = dairy;
      break;
      case 'fruits':
      category = fruits;
      break;
      case 'drinks':
      category = drinks;
      break;
      case 'cereals':
      category = cereals;
      break;
      case 'sugar':
      category = sugar;
      break;
      case 'food':
      category = food;
      break;
    }
    return category;
  }
}
