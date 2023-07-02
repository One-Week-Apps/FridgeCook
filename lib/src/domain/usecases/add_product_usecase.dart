import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/repositories/product_fetcher.dart';
import '../repositories/products_repository.dart';

class AddProductUseCase
    extends UseCase<AddProductUseCaseResponse, AddProductUseCaseParams> {
  final ProductsRepository productsRepository;
  final ProductFetcher productFetcher;

  AddProductUseCase(this.productsRepository, this.productFetcher);

  @override
  Future<Stream<AddProductUseCaseResponse>> buildUseCaseStream(
      AddProductUseCaseParams params) async {
    final StreamController<AddProductUseCaseResponse> controller =
        StreamController();
    try {
      var existingProduct = await productsRepository.getProduct(params.id);

      if (existingProduct != null) {
        bool isUpdated = await productsRepository.updateProduct(existingProduct.name, existingProduct.quantity + 1);
        controller.add(AddProductUseCaseResponse(isUpdated));
      } else {
        var identifiedProduct = await productFetcher.fetchProduct(params.id);

        if (identifiedProduct == null) {
          controller.add(AddProductUseCaseResponse(false));
        } else {
          print("DEBUG_SESSION OK3");
          bool isAdded = await productsRepository.add(identifiedProduct);
          print("DEBUG_SESSION OK3b");
          controller.add(AddProductUseCaseResponse(isAdded));
        }        
      }
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class AddProductUseCaseParams {
  String id;
  AddProductUseCaseParams(this.id);
}

class AddProductUseCaseResponse {
  bool isAdded;
  AddProductUseCaseResponse(this.isAdded);
}
