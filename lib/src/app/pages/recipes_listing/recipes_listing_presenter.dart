import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_recipes_repository.dart';
import 'package:fridge_cook/src/data/repositories/random_products_generator.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_products_usecase.dart';

class RecipesListingPresenter extends Presenter {
  Function getAllRecipesOnNext;

  final GetAllProductsUseCase getAllRecipesUseCase;

  RecipesListingPresenter(recipesRepo)
      : getAllRecipesUseCase =
            GetAllProductsUseCase(recipesRepo);

  void getAllProducts() {
    int count = 5;
    getAllRecipesUseCase.execute(_GetAllProductsUseCaseObserver(this),
        GetAllProductsUseCaseParams(count));
  }

  @override
  void dispose() {
    getAllRecipesUseCase.dispose();
  }
}

class _GetAllProductsUseCaseObserver extends Observer<GetAllProductsUseCaseResponse> {
  final RecipesListingPresenter presenter;

  _GetAllRecipesUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.getAllProductsOnNext(response.products);
  }
}
