import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_recipes_usecase.dart';

class RecipesListingPresenter extends Presenter {
  Function getAllRecipesOnNext;

  final GetAllRecipesUseCase getAllRecipesUseCase;

  RecipesListingPresenter(recipesRepo)
      : getAllRecipesUseCase =
            GetAllRecipesUseCase(recipesRepo);

  void getAllRecipes(List<Product> products) {
    int count = 2;
    getAllRecipesUseCase.execute(_GetAllRecipesUseCaseObserver(this),
        GetAllRecipesUseCaseParams(products, count));
  }

  @override
  void dispose() {
    getAllRecipesUseCase.dispose();
  }
}

class _GetAllRecipesUseCaseObserver extends Observer<GetAllRecipesUseCaseResponse> {
  final RecipesListingPresenter presenter;

  _GetAllRecipesUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.getAllRecipesOnNext(response.recipes);
  }
}
