import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/repositories/performance_repository.dart';

class GetPerformancesUseCase extends UseCase<GetAllPerformancesUseCaseResponse,
    GetAllPerformancesUseCaseParams> {
  final PerformanceRepository perfsRepository;

  GetPerformancesUseCase(this.perfsRepository);

  @override
  Future<Stream<GetAllPerformancesUseCaseResponse>> buildUseCaseStream(
      GetAllPerformancesUseCaseParams params) async {
    final StreamController<GetAllPerformancesUseCaseResponse> controller =
        StreamController();
    try {
      List<Performance> perfs = await perfsRepository.all();
      controller.add(GetAllPerformancesUseCaseResponse(perfs));
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetAllPerformancesUseCaseParams {
  GetAllPerformancesUseCaseParams();
}

/// Wrapping response inside an object makes it easier to change later
class GetAllPerformancesUseCaseResponse {
  List<Performance> perfs;
  GetAllPerformancesUseCaseResponse(this.perfs);
}
