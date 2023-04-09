import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/repositories/openai/create_image_api.dart';

import '../entities/product.dart';
import '../repositories/products_repository.dart';

class DeleteProductUseCase
    extends UseCase<DeleteProductUseCaseResponse, DeleteProductUseCaseParams> {
  final ProductsRepository productsRepository;

  DeleteProductUseCase(this.productsRepository);

  @override
  Future<Stream<DeleteProductUseCaseResponse>> buildUseCaseStream(
      DeleteProductUseCaseParams params) async {
    final StreamController<DeleteProductUseCaseResponse> controller =
        StreamController();
    try {
      bool isDeleted = await productsRepository.delete(params.product);
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
  DeleteProductUseCaseParams(this.product);
}

class DeleteProductUseCaseResponse {
  bool isDeleted;
  DeleteProductUseCaseResponse(this.isDeleted);
}
