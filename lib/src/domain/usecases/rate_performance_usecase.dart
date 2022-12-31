import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/repositories/performance_repository.dart';

class RatePerformanceUseCase extends UseCase<RatePerformanceUseCaseResponse,
    RatePerformanceUseCaseParams> {
  final PerformanceRepository perfsRepository;
  RatePerformanceUseCase(this.perfsRepository);

  @override
  Future<Stream<RatePerformanceUseCaseResponse>> buildUseCaseStream(
      RatePerformanceUseCaseParams params) async {
    final StreamController<RatePerformanceUseCaseResponse> controller =
        StreamController();
    try {
      bool status = await perfsRepository.add(params.perf);
      controller.add(RatePerformanceUseCaseResponse(status));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class RatePerformanceUseCaseParams {
  Performance perf;
  RatePerformanceUseCaseParams(this.perf);
}

class RatePerformanceUseCaseResponse {
  bool status;
  RatePerformanceUseCaseResponse(this.status);
}
