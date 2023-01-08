import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/product.dart';
import '../repositories/products_repository.dart';

class GetAllProductsUseCase
    extends UseCase<GetAllProductsUseCaseResponse, GetAllProductsUseCaseParams> {
  final ProductsRepository productsRepository;

  GetAllProductsUseCase(this.productsRepository);

  @override
  Future<Stream<GetAllProductsUseCaseResponse>> buildUseCaseStream(
      GetAllProductsUseCaseParams params) async {
    final StreamController<GetAllProductsUseCaseResponse> controller =
        StreamController();
    try {
      List<Product> products = await productsRepository.getAllProducts();
      controller.add(GetAllProductsUseCaseResponse(products));
      logger.finest('GetProductUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetProductUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class GetAllProductsUseCaseParams {
  int count;
  GetAllProductsUseCaseParams(this.count);
}

class GetAllProductsUseCaseResponse {
  List<Product> products;
  GetAllProductsUseCaseResponse(this.products);
}
