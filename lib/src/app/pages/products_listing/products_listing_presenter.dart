import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_products_usecase.dart';

class ProductsListingPresenter extends Presenter {
  Function getAllProductsOnNext;

  final GetAllProductsUseCase getAllProductsUseCase;

  ProductsListingPresenter(productsRepo)
      : getAllProductsUseCase =
            GetAllProductsUseCase(productsRepo);

  void getAllProducts() {
    int productsToPerformCount = 5;
    getAllProductsUseCase.execute(_GetAllProductsUseCaseObserver(this),
        GetAllProductsUseCaseParams(productsToPerformCount));
  }

  @override
  void dispose() {
    getAllProductsUseCase.dispose();
  }
}

class _GetAllProductsUseCaseObserver extends Observer<GetAllProductsUseCaseResponse> {
  final ProductsListingPresenter presenter;

  _GetAllProductsUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.getAllProductsOnNext(response.products);
  }
}
