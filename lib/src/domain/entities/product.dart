import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';

class Product {
  final String name;
  final ProductQuantity quantity;
  final ProductCategory category;
  final String image;

  Product(this.name, this.quantity, this.category, this.image);

  @override
  String toString() =>
      '$name, ${quantity.value}, $category, $image';

  Product.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      quantity = ProductQuantity.fromJson(json['quantity']),
      category = ProductCategory.fromName(json['category']),
      image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'quantity': this.quantity.toJson(),
        'category': this.category.name,
        'image': this.image
      };

  /// Creates a copy of this Product with the quantity incremented.
  ///
  /// Throws [ArgumentError] if quantity is already at maximum (9).
  Product incrementQuantity() {
    return Product(name, quantity.increment(), category, image);
  }

  /// Creates a copy of this Product with the quantity decremented.
  ///
  /// Throws [ArgumentError] if quantity is already at minimum (1).
  Product decrementQuantity() {
    return Product(name, quantity.decrement(), category, image);
  }

  /// Returns true if the product quantity can be incremented.
  bool get canIncrementQuantity => quantity.canIncrement;

  /// Returns true if the product quantity can be decremented.
  bool get canDecrementQuantity => quantity.canDecrement;

  /// Creates a copy of this Product with the specified quantity.
  Product copyWithQuantity(ProductQuantity newQuantity) {
    return Product(name, newQuantity, category, image);
  }
}
