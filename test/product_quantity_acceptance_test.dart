import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_product_fetcher.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_products_repository.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';
import 'package:fridge_cook/src/domain/usecases/add_product_usecase.dart';

/// Acceptance Test: ProductQuantity Validation
///
/// This test specifies the behavior from the user's perspective:
/// - Products should only be added with valid quantities (1-9)
/// - Quantities outside this range should be rejected
void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Product Quantity Acceptance Tests', () {
    test('should successfully add product with valid quantity (1)', () async {
      // Arrange
      final repo = InMemoryProductsRepository([]);
      final validProduct = Product(
        'apple',
        ProductQuantity(1),
        ProductCategory.fruits,
        'test_image_url',
      );
      final fetcher = InMemoryProductFetcher(validProduct);
      final useCase = AddProductUseCase(repo, fetcher);
      final observer = _AddProductObserver();

      // Act
      useCase.execute(observer, AddProductUseCaseParams('apple'));
      while (!observer.status['progress']!.contains('done')) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Assert
      expect(observer.status['result'], 'success');
      expect(repo.products.first.quantity.value, 1);
    });

    test('should successfully add product with valid quantity (9)', () async {
      // Arrange
      final repo = InMemoryProductsRepository([]);
      final validProduct = Product(
        'banana',
        ProductQuantity(9),
        ProductCategory.fruits,
        'test_image_url',
      );
      final fetcher = InMemoryProductFetcher(validProduct);
      final useCase = AddProductUseCase(repo, fetcher);
      final observer = _AddProductObserver();

      // Act
      useCase.execute(observer, AddProductUseCaseParams('banana'));
      while (!observer.status['progress']!.contains('done')) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Assert
      expect(observer.status['result'], 'success');
      expect(repo.products.first.quantity.value, 9);
    });

    test('should reject product with invalid quantity (0)', () {
      // This should throw when attempting to create a ProductQuantity with 0
      expect(
        () => ProductQuantity(0),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should reject product with invalid quantity (negative)', () {
      // This should throw when attempting to create a ProductQuantity with negative value
      expect(
        () => ProductQuantity(-1),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should reject product with invalid quantity (greater than 9)', () {
      // This should throw when attempting to create a ProductQuantity > 9
      expect(
        () => ProductQuantity(10),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('should increment quantity when adding existing product', () async {
      // Arrange
      final existingProduct = Product(
        'banana',
        ProductQuantity(1),
        ProductCategory.fruits,
        '',
      );
      final repo = InMemoryProductsRepository([existingProduct]);
      final fetcher = InMemoryProductFetcher(null);
      final useCase = AddProductUseCase(repo, fetcher);
      final observer = _AddProductObserver();

      // Act
      useCase.execute(observer, AddProductUseCaseParams('banana'));
      while (!observer.status['progress']!.contains('done')) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Assert
      expect(observer.status['result'], 'success');
      expect(repo.products.first.quantity.value, 2);
    });

    test('should not increment quantity beyond 9', () async {
      // Arrange: product already at max quantity 9
      final existingProduct = Product(
        'banana',
        ProductQuantity(9),
        ProductCategory.fruits,
        '',
      );
      final repo = InMemoryProductsRepository([existingProduct]);
      final fetcher = InMemoryProductFetcher(null);
      final useCase = AddProductUseCase(repo, fetcher);
      final observer = _AddProductObserver();

      // Act
      useCase.execute(observer, AddProductUseCaseParams('banana'));
      while (!observer.status['progress']!.contains('done')) {
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Assert: quantity should stay at 9, operation fails
      expect(observer.status['result'], 'unrecognized');
      expect(repo.products.first.quantity.value, 9);
    });
  });
}

class _AddProductObserver implements Observer<AddProductUseCaseResponse> {
  final status = {'progress': 'starting', 'result': ''};

  @override
  void onNext(AddProductUseCaseResponse? response) {
    expect(AddProductUseCaseResponse, response.runtimeType);
    status['progress'] = 'done';
    status['result'] = response!.isAdded ? 'success' : 'unrecognized';
  }

  @override
  void onComplete() {}

  @override
  void onError(dynamic e) {
    status['progress'] = 'done';
    status['result'] = 'failed';
  }
}
