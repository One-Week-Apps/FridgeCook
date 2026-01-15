import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/product_category.dart';
import '../repositories/product_categories_repository.dart';

class GetAllCategoriesUseCase
    extends UseCase<GetAllCategoriesUseCaseResponse, GetAllCategoriesUseCaseParams> {
  final ProductCategoriesRepository categoriesRepository;

  GetAllCategoriesUseCase(this.categoriesRepository);

  @override
  Future<Stream<GetAllCategoriesUseCaseResponse>> buildUseCaseStream(
      GetAllCategoriesUseCaseParams? params) async {
    final StreamController<GetAllCategoriesUseCaseResponse> controller =
        StreamController();
    try {
      List<ProductCategory> categories = await categoriesRepository.getAllCategories();
      controller.add(GetAllCategoriesUseCaseResponse(categories));
      logger.finest('GetAllCategoriesUseCase successful: ${categories.length} ${categories.first.name}');
      logger.finest('=======================================================================');
      controller.close();
    } catch (e) {
      logger.severe('GetProductUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAllCategoriesUseCaseParams {
  GetAllCategoriesUseCaseParams();
}

class GetAllCategoriesUseCaseResponse {
  List<ProductCategory> categories;
  GetAllCategoriesUseCaseResponse(this.categories);
}
