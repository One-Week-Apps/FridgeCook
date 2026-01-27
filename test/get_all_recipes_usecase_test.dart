import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_recipes_repository.dart';
import 'package:fridge_cook/src/domain/entities/product.dart';
import 'package:fridge_cook/src/domain/entities/product_category.dart';
import 'package:fridge_cook/src/domain/entities/product_quantity.dart';
import 'package:fridge_cook/src/domain/entities/recipe.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_recipes_usecase.dart';

void main() {

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() async {
  });

  test(
      'Given getAllRecipesUseCase should return recipes',
      () async {
    GetAllRecipesUseCase getUserUseCase;
    _Observer observer;
    var recipes = [Recipe('banana cake', [''], [''], '', [Product("banana", ProductQuantity(1), ProductCategory.fruits, "")])];
    var repo = InMemoryRecipesRepository(recipes);
    getUserUseCase = GetAllRecipesUseCase(repo);
    observer = _Observer();
    getUserUseCase.execute(observer, GetAllRecipesUseCaseParams([Product('banana', ProductQuantity(1), ProductCategory.fruits, ''), Product('milk', ProductQuantity(1), ProductCategory.dairy, '')], 1));
    while (!observer.status['progress']!.contains('done')) {
      await Future.delayed(const Duration(seconds: 1));
    }
    expect(observer.status['result'], recipes.toString());
  });
}

class _Observer implements Observer<GetAllRecipesUseCaseResponse> {
  final status = {'progress': 'starting', 'result': ''};
  @override
  void onNext(GetAllRecipesUseCaseResponse? response) {
    expect(GetAllRecipesUseCaseResponse, response.runtimeType);
    status['progress'] = 'done';
    status['result'] = response!.recipes.toString();
  }

  @override
  void onComplete() {}

  @override
  void onError(dynamic e) {
    status['progress'] = 'done';
    status['result'] = 'failed';
  }
}

