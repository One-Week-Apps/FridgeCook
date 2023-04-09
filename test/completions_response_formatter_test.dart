import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/usecases/completions_response_formatter.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
  });

  test('should format name correctly', () async {
    var sut = CompletionsResponseFormatter();
    
    var formattedName = sut.getRecipeName("\n\nApple Banana Bread Recipe\n\nIngredients:\n\n1 cup mashed ripe bananas\n\n1/2 cup unsweetened applesauce\n\n1/4 cup vegetable oil\n\n2 eggs\n\n1 teaspoon vanilla extract\n\n1 3/4 cups all-purpose flour\n\n1 cup sugar\n\n1 teaspoon baking soda\n\n1 teaspoon baking powder\n\n1/2 teaspoon salt\n\n1/2 teaspoon ground cinnamon\n\nDirections:\n\n1. Preheat oven to 350°. Grease a 9x5-in. loaf pan with cooking spray.\n\n2. In a large");

    expect(formattedName, "Apple Banana Bread Recipe");
  });

  test('should format response correctly', () async {
    var sut = CompletionsResponseFormatter();
    final imageUrl = "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg";
    final products = [
      Product(
        "Apple",
        1,
        "https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc="
      ),
    ];

    var formattedResponse = sut.format(
      "\n\nApple Banana Bread Recipe\n\nIngredients:\n\n1 cup mashed ripe bananas\n\n1/2 cup unsweetened applesauce\n\n1/4 cup vegetable oil\n\n2 eggs\n\n1 teaspoon vanilla extract\n\n1 3/4 cups all-purpose flour\n\n1 cup sugar\n\n1 teaspoon baking soda\n\n1 teaspoon baking powder\n\n1/2 teaspoon salt\n\n1/2 teaspoon ground cinnamon\n\nDirections:\n\n1. Preheat oven to 350°. Grease a 9x5-in. loaf pan with cooking spray.\n\n2. In a large",
      imageUrl,
      products
    );

    expect(formattedResponse.name, "Apple Banana Bread Recipe");
    expect(formattedResponse.ingredients, 
    [
      "1 cup mashed ripe bananas",
      "1/2 cup unsweetened applesauce",
      "1/4 cup vegetable oil",
      "2 eggs",
      "1 teaspoon vanilla extract",
      "1 3/4 cups all-purpose flour",
      "1 cup sugar",
      "1 teaspoon baking soda",
      "1 teaspoon baking powder",
      "1/2 teaspoon salt",
      "1/2 teaspoon ground cinnamon",
    ]);
    expect(formattedResponse.directions,
    [
      "Preheat oven to 350°. Grease a 9x5-in. loaf pan with cooking spray.",
      "In a large"
    ]);
    expect(formattedResponse.image, isNot(null));
    expect(formattedResponse.products, products);
  });

}
