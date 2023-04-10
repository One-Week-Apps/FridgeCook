import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/app/pages/recipes_listing/recipes_listing_presenter.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';

class RecipesListingController extends Controller {
  List<Recipe> _recipes = [];
  
  // data used by the View
  List<Recipe> get recipes => _recipes;
  
  final RecipesListingPresenter presenter;
  // Presenter should always be initialized this way
  RecipesListingController(productsRepo)
      : presenter = RecipesListingPresenter(productsRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {

    presenter.getAllRecipesOnNext = (List<Recipe> recipes) {
      print(recipes.toString());
      _recipes = recipes;
      refreshUI();
    };
  }

  void getAllRecipes(List<Product> products) => presenter.getAllRecipes(products);

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
