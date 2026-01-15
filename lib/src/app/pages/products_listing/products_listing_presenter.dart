import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/usecases/add_product_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/delete_product_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_categories_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_products_usecase.dart';

class ProductsListingPresenter extends Presenter {
  late Function getAllCategoriesOnNext;
  late Function getAllProductsOnNext;
  late Function addProductOnNext;
  late Function deleteProductOnNext;

  final GetAllCategoriesUseCase getAllCategoriesUseCase;
  final GetAllProductsUseCase getAllProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductsListingPresenter(categoriesRepo, productsRepo, productFetcher)
      : getAllCategoriesUseCase = GetAllCategoriesUseCase(categoriesRepo), getAllProductsUseCase =
            GetAllProductsUseCase(productsRepo), addProductUseCase = AddProductUseCase(productsRepo, productFetcher), deleteProductUseCase = DeleteProductUseCase(productsRepo);

  void getAllCategories() {
    getAllCategoriesUseCase.execute(_GetAllCategoriesUseCaseObserver(this),
        GetAllCategoriesUseCaseParams());
  }

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
        DeleteProductUseCaseParams(value, true));
  }

  void deleteOne(String value) {
    deleteProductUseCase.execute(_DeleteProductUseCaseObserver(this),
        DeleteProductUseCaseParams(value, false));
  }

  @override
  void dispose() {
    getAllProductsUseCase.dispose();
  }
}

class _GetAllCategoriesUseCaseObserver extends Observer<GetAllCategoriesUseCaseResponse> {
  final ProductsListingPresenter presenter;

  _GetAllCategoriesUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    if (response != null) {
      presenter.getAllCategoriesOnNext(response.categories);
    }
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
    if (response != null) {
      presenter.getAllProductsOnNext(response.products);
    }
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
    if (response != null) {
      presenter.addProductOnNext(response.isAdded);
    }
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
    if (response != null) {
      presenter.deleteProductOnNext(response.isDeleted);
    }
  }
}
