import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';
import 'package:fridge_cook/src/domain/usecases/delete_product_usecase.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
  });

  test(
      'Given deleteProductUseCase when Parameters ingredient does NOT exist',
      () async {
    DeleteProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([Product("banana", ProductQuantity(1), ProductCategory.fruits, "")]);
    getUserUseCase = DeleteProductUseCase(repo);
    observer = _Observer();
    getUserUseCase.execute(observer, DeleteProductUseCaseParams('apple', true));
    while (!observer.status['progress']!.contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'unknown');
    expect(repo.products.isEmpty, false);
  });

  test(
      'Given deleteProductUseCase when Parameters ingredient exists',
      () async {
    DeleteProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([Product("banana", ProductQuantity(1), ProductCategory.fruits, "")]);
    getUserUseCase = DeleteProductUseCase(repo);
    observer = _Observer();
    getUserUseCase.execute(observer, DeleteProductUseCaseParams('banana', true));
    while (!observer.status['progress']!.contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'success');
    expect(repo.products.isEmpty, true);
  });

  test(
      'Given deleteOneProductUseCase when Parameters ingredient exists',
      () async {
    DeleteProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([Product("banana", ProductQuantity(3), ProductCategory.fruits, "")]);
    getUserUseCase = DeleteProductUseCase(repo);
    observer = _Observer();
    getUserUseCase.execute(observer, DeleteProductUseCaseParams('banana', false));
    while (!observer.status['progress']!.contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'success');
    expect(repo.products.isEmpty, false);
    expect(repo.products.first.quantity.value, 2);
  });

  test(
      'Given deleteOneProductUseCase when Parameters ingredient exists',
      () async {
    DeleteProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([Product("banana", ProductQuantity(1), ProductCategory.fruits, "")]);
    getUserUseCase = DeleteProductUseCase(repo);
    observer = _Observer();
    getUserUseCase.execute(observer, DeleteProductUseCaseParams('banana', false));
    while (!observer.status['progress']!.contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'success');
    expect(repo.products.isEmpty, true);
  });

  test(
      'Given deleteProductUseCase when Parameters ingredient exists among two items',
      () async {
    DeleteProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([Product("banana", ProductQuantity(1), ProductCategory.fruits, ""), Product("apple", ProductQuantity(1), ProductCategory.fruits, "")]);
    getUserUseCase = DeleteProductUseCase(repo);
    observer = _Observer();
    getUserUseCase.execute(observer, DeleteProductUseCaseParams('banana', true));
    while (!observer.status['progress']!.contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'success');
    expect(repo.products.isEmpty, false);
    expect(repo.products.first.name, "apple");
  });
}

class _Observer implements Observer<DeleteProductUseCaseResponse> {
  final status = {'progress': 'starting', 'result': ''};
  @override
  void onNext(DeleteProductUseCaseResponse? response) {
    expect(DeleteProductUseCaseResponse, response.runtimeType);
    status['progress'] = 'done';
    status['result'] = response!.isDeleted ? 'success' : 'unknown';
  }

  @override
  void onComplete() {}

  @override
  void onError(dynamic e) {
    status['progress'] = 'done';
    status['result'] = 'failed';
  }
}

