import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import '../repositories/products_repository.dart';

class DeleteProductUseCase
    extends UseCase<DeleteProductUseCaseResponse, DeleteProductUseCaseParams> {
  final ProductsRepository productsRepository;

  DeleteProductUseCase(this.productsRepository);

  @override
  Future<Stream<DeleteProductUseCaseResponse>> buildUseCaseStream(
      DeleteProductUseCaseParams? params) async {
    final StreamController<DeleteProductUseCaseResponse> controller =
        StreamController();
    try {
      bool isDeleted = false;
      if (params != null) {
        if (params.shouldRemoveAllItems) {
          isDeleted = await productsRepository.delete(params.product);
        } else {
          var existingProduct = await productsRepository.getProduct(params.product);

          if (existingProduct != null && existingProduct.canDecrementQuantity) {
            // Use Tell Don't Ask - let ProductQuantity handle the decrement
            final newQuantity = existingProduct.quantity.decrement();
            isDeleted = await productsRepository.updateProduct(params.product, newQuantity);
          } else if (existingProduct != null) {
            // Quantity is 1, so delete the product entirely
            isDeleted = await productsRepository.delete(params.product);
          }
        }
      }
      controller.add(DeleteProductUseCaseResponse(isDeleted));
      logger.finest('DeleteProductUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('DeleteProductUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}

class DeleteProductUseCaseParams {
  String product;
  bool shouldRemoveAllItems;
  DeleteProductUseCaseParams(this.product, this.shouldRemoveAllItems);
}

class DeleteProductUseCaseResponse {
  bool isDeleted;
  DeleteProductUseCaseResponse(this.isDeleted);
}
