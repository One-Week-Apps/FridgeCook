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
    
    var formattedName = sut.getRecipeName("""\n\nName: Apple Pie\n\n  Ingredients: Flour, sugar, salt, butter, egg, ice water, apple, lemon juice, cinnamon, nutmeg,
      allspice\n\nRecipe:\n\n1. Preheat oven to 375 degrees F (190 degrees C).\n2. Line pie dish with one pie crust. In a large bowl,
      combine sugar, flour, salt, and butter. Cut in butter until it resembles coarse crumbs. Stir in egg and just enough ice water to
      make dough come together.\n3. In a separate bowl, mix together apples, lemon juice, sugar, cinnamon, nutmeg, and allspice.\n4. Pour
      apple mixture into the crust, and top with the other crust. Crimp and flute edges. Cut slits in top crust to vent.\n5. Bake pie on
      lower shelf of oven for about 50 minutes, or until crust is golden brown.""");

    expect(formattedName, "Apple Pie");
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
      """\n\nName: Apple Pie\n\n  Ingredients: Flour, sugar, salt, butter, egg, ice water, apple, lemon juice, cinnamon, nutmeg, allspice\n\nRecipe:\n\n1. Preheat oven to 375 degrees F (190 degrees C).\n2. Line pie dish with one pie crust. In a large bowl, combine sugar, flour, salt, and butter. Cut in butter until it resembles coarse crumbs. Stir in egg and just enough ice water to make dough come together.\n3. In a separate bowl, mix together apples, lemon juice, sugar, cinnamon, nutmeg, and allspice.\n4. Pour apple mixture into the crust, and top with the other crust. Crimp and flute edges. Cut slits in top crust to vent.\n5. Bake pie on lower shelf of oven for about 50 minutes, or until crust is golden brown.""",
      imageUrl,
      products
    );

    expect(formattedResponse.name, "Apple Pie");
    expect(formattedResponse.ingredients, 
    [
      "Flour",
      "sugar",
      "salt",
      "butter",
      "egg",
      "ice water",
      "apple",
      "lemon juice",
      "cinnamon",
      "nutmeg",
      "allspice",
    ]);
    expect(formattedResponse.directions,
    [
      """Preheat oven to 375 degrees F (190 degrees C).""",
      """Line pie dish with one pie crust. In a large bowl, combine sugar, flour, salt, and butter. Cut in butter until it resembles coarse crumbs. Stir in egg and just enough ice water to make dough come together.""",
      """In a separate bowl, mix together apples, lemon juice, sugar, cinnamon, nutmeg, and allspice.""",
      """Pour apple mixture into the crust, and top with the other crust. Crimp and flute edges. Cut slits in top crust to vent.""",
      """Bake pie on lower shelf of oven for about 50 minutes, or until crust is golden brown.""",
    ]);
    expect(formattedResponse.image, isNot(null));
    expect(formattedResponse.products, products);
  });

}
