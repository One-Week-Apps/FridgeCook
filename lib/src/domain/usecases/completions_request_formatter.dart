import 'package:fridge_cook/src/domain/entities/product.dart';

class CompletionsRequestFormatter {
  String format(List<Product> products) {
    var productsMessage = products.map((e) => e.name).join(", ");
    return "Give the name and the recipe using ingredients $productsMessage.";
  }
}