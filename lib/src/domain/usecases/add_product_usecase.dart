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
      AddProductUseCaseParams? params) async {
    final StreamController<AddProductUseCaseResponse> controller =
        StreamController();
    try {
      if (params == null) {
        controller.add(AddProductUseCaseResponse(false));
      } else {
        var existingProduct = await productsRepository.getProduct(params.id);

        if (existingProduct != null) {
          // Check if we can increment the quantity (Tell Don't Ask principle)
          if (!existingProduct.canIncrementQuantity) {
            // Cannot increment beyond maximum (9)
            controller.add(AddProductUseCaseResponse(false));
          } else {
            final newQuantity = existingProduct.quantity.increment();
            bool isUpdated = await productsRepository.updateProduct(
              existingProduct.name,
              newQuantity,
            );
            controller.add(AddProductUseCaseResponse(isUpdated));
          }
        } else {
          var identifiedProduct = await productFetcher.fetchProduct(params.id);

          if (identifiedProduct == null) {
            controller.add(AddProductUseCaseResponse(false));
          } else {
            bool isAdded = await productsRepository.add(identifiedProduct);
            controller.add(AddProductUseCaseResponse(isAdded));
          }
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
