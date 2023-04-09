import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_product_fetcher.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/usecases/add_product_usecase.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
  });

  test(
      'Given addProductUseCase when Parameters ingredient already exists increases quantity',
      () async {
    AddProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([Product("banana", 1, "")]);
    var fetcher = InMemoryProductFetcher(null);
    getUserUseCase = AddProductUseCase(repo, fetcher);
    observer = _Observer();
    getUserUseCase.execute(observer, AddProductUseCaseParams('banana'));
    while (!observer.status['progress'].contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'success');
    expect(repo.products.first.quantity, 2);
  });

  test(
      'Given addProductUseCase when Parameters ingredient NOT RECOGNIZED return failure',
      () async {
    AddProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([]);
    var fetcher = InMemoryProductFetcher(null);
    getUserUseCase = AddProductUseCase(repo, fetcher);
    observer = _Observer();
    getUserUseCase.execute(observer, AddProductUseCaseParams('banana'));
    while (!observer.status['progress'].contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'unrecognized');
    expect(repo.products.isEmpty, true);
  });

  test(
      'Given addProductUseCase when Parameters ingredient RECOGNIZED return successfull',
      () async {
    AddProductUseCase getUserUseCase;
    _Observer observer;
    var repo = InMemoryProductsRepository([]);
    var fetcher = InMemoryProductFetcher(Product("banana", 1, "test_image_url"));
    getUserUseCase = AddProductUseCase(repo, fetcher);
    observer = _Observer();
    getUserUseCase.execute(observer, AddProductUseCaseParams('banana'));
    while (!observer.status['progress'].contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], 'success');
    expect(repo.products.first.quantity, 1);
    expect(repo.products.first.image, "test_image_url");
  });
}

class _Observer implements Observer<AddProductUseCaseResponse> {
  final status = {'progress': 'starting', 'result': ''};
  @override
  void onNext(response) {
    expect(AddProductUseCaseResponse, response.runtimeType);
    status['progress'] = 'done';
    status['result'] = response.isAdded ? 'success' : 'unrecognized';
  }

  @override
  void onComplete() {}

  @override
  void onError(e) {
    status['progress'] = 'done';
    status['result'] = 'failed';
  }
}

