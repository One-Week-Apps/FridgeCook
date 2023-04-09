import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/usecases/add_product_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/delete_product_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_products_usecase.dart';

class ProductsListingPresenter extends Presenter {
  Function getAllProductsOnNext;
  Function addProductOnNext;
  Function deleteProductOnNext;

  final GetAllProductsUseCase getAllProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductsListingPresenter(productsRepo, productFetcher)
      : getAllProductsUseCase =
            GetAllProductsUseCase(productsRepo), addProductUseCase = AddProductUseCase(productsRepo, productFetcher), deleteProductUseCase = DeleteProductUseCase(productsRepo);

  void getAllProducts() {
    int productsToPerformCount = 5;
    getAllProductsUseCase.execute(_GetAllProductsUseCaseObserver(this),
        GetAllProductsUseCaseParams(productsToPerformCount));
  }

  void addProduct(String value) {
    addProductUseCase.execute(_AddProductUseCaseObserver(this),
        AddProductUseCaseParams(value));
  }

  void deleteProduct(String value) {
    deleteProductUseCase.execute(_DeleteProductUseCaseObserver(this),
        DeleteProductUseCaseParams(value));
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

class _AddProductUseCaseObserver extends Observer<AddProductUseCaseResponse> {
  final ProductsListingPresenter presenter;

  _AddProductUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.addProductOnNext(response.isAdded);
  }
}

class _DeleteProductUseCaseObserver extends Observer<DeleteProductUseCaseResponse> {
  final ProductsListingPresenter presenter;

  _DeleteProductUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.deleteProductOnNext(response.isDeleted);
  }
}
