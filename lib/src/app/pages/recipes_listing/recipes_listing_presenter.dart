import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_recipes_repository.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_recipes_usecase.dart';

class RecipesListingPresenter extends Presenter {
  Function getAllRecipesOnNext;

  final GetAllRecipesUseCase getAllRecipesUseCase;

  RecipesListingPresenter(recipesRepo)
      : getAllRecipesUseCase =
            GetAllRecipesUseCase(recipesRepo);

  void getAllRecipes() {
    int count = 5;
    getAllRecipesUseCase.execute(_GetAllRecipesUseCaseObserver(this),
        GetAllRecipesUseCaseParams(count));
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
