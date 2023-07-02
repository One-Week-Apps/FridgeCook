import 'package:fridge_cook/src/domain/entities/product_category.dart';

class Product {
  final String name;
  final int quantity;
  final ProductCategory category;
  final String image;

  Product(this.name, this.quantity, this.category, this.image);

  @override
  String toString() =>
      '$name, $quantity, $category, $image';

  Product.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      quantity = json['quantity'],
      category = ProductCategory.fromName(json['category']),
      image = json['image'];

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'quantity': this.quantity,
        'category': this.category.name,
        'image': this.image
      };
}
