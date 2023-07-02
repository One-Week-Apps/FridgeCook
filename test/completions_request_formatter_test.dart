import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:flutter/widgets.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/usecases/completions_request_formatter.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
  });

  test('should format completion request correctly', () async {
    var sut = CompletionsRequestFormatter();

    var request = sut.format([
      Product(
        "Orange",
        1,
        ProductCategory.fruits,
        "https://st.depositphotos.com/1000141/1941/i/600/depositphotos_19418467-stock-photo-ripe-orange-with-leaf.jpg",
      ),
      Product(
        "Apple",
        1,
        ProductCategory.fruits,
        "https://media.istockphoto.com/id/184276818/fr/photo/pomme-rouge.jpg?s=612x612&w=0&k=20&c=yk9viCWt8_VHAvSvzPuqZI-A79xkestBMyCf1AEyhrc=",
      ),
    ]);

    expect(request, """I want you to act as a recipe generator. You will have to follow the below format with the provided ingredients. Specify only the ingredients used in the recipe in the generated "Ingredients" section.


  Ingredients: flour, salt, baking soda, butter, sugar, egg, milk, vanilla extract, banana

  Name: Sugar Cookies

  Ingredients: flour, salt, baking soda, butter, sugar, egg, milk, vanilla extract

  Recipe:
  1. Whisk flour, salt, and baking soda together in a bowl. In a separate bowl, cream the butter, white sugar, and brown sugar together until mixture is light and fluffy, 3 to 4 minutes. Add the egg, milk, and vanilla extract. Whisk liquids together in small areas around the bowl, then all together to avoid separation.

  2. Pour dry ingredients into the wet ingredients; stir until flour is thoroughly mixed in. Stir in the chocolate chips.

  3. Transfer dough to a resealable plastic bag. Refrigerate until dough is firm, at least 2 hours.

  4. Preheat oven to 375 degrees F (190 degrees C). Line baking sheet with parchment paper.

  5. Scoop out rounded tablespoons of dough and place on prepared baking sheet, leaving 4 inches of space between cookies (about 8 per sheet). Bake in preheated oven until cookies are golden brown, about 12 minutes. Slide parchment and cookies onto a cooling rack for a few minutes. Remove parchment and finish cooling the cookies on the rack.

  Ingredients: butter, shrimp, olive oil, pepper, salt, shallots, linguine, red pepper flakes, garlic, shallots, orange

  Name: Shrimp Scampi

  Ingredients: butter, shrimp, olive oil, pepper, salt, shallots, linguine, red pepper flakes, garlic, shallots

  Recipe:
  1. Bring a large pot of salted water to a boil; cook linguine in boiling water until nearly tender, 6 to 8 minutes. Drain.

  2. Melt 2 tablespoons butter with 2 tablespoons olive oil in a large skillet over medium heat. Cook and stir shallots, garlic, and red pepper flakes in the hot butter and oil until shallots are translucent, 3 to 4 minutes. Season shrimp with kosher salt and black pepper; add to the skillet and cook until pink, stirring occasionally, 2 to 3 minutes. Remove shrimp from skillet and keep warm.

  3. Pour white wine and lemon juice into skillet and bring to a boil while scraping the browned bits of food off of the bottom of the skillet with a wooden spoon. Melt 2 tablespoons butter in skillet, stir 2 tablespoons olive oil into butter mixture, and bring to a simmer. Toss linguine, shrimp, and parsley in the butter mixture until coated; season with salt and black pepper. Drizzle with 1 teaspoon olive oil to serve.

  Ingredients: Orange, Apple

    """);
  });

}

