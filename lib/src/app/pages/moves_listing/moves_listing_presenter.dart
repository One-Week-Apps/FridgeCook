import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_performance_repository.dart';
import 'package:fridge_cook/src/data/repositories/random_moves_generator.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/usecases/get_performances_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/rate_performance_usecase.dart';

import '../../../domain/usecases/get_all_moves_usecase.dart';

class MovesListingPresenter extends Presenter {
  Function getAllMovesOnNext;

  Function addPerformanceOnNext;

  Function getPerformancesOnNext;

  final GetAllMovesUseCase getAllMovesUseCase;
  final RatePerformanceUseCase ratePerformanceUseCase;
  final GetPerformancesUseCase getPerformancesUseCase;

  MovesListingPresenter(movesRepo)
      : getAllMovesUseCase =
            GetAllMovesUseCase(movesRepo, RandomMovesGenerator()),
        getPerformancesUseCase =
            GetPerformancesUseCase(SharedPreferencesPerformanceRepository()),
        ratePerformanceUseCase =
            RatePerformanceUseCase(SharedPreferencesPerformanceRepository());

  void getAllMoves() {
    int movesToPerformCount = 5;
    getAllMovesUseCase.execute(_GetAllMovesUseCaseObserver(this),
        GetAllMovesUseCaseParams(movesToPerformCount));
  }

  void addPerformance(Performance perf) {
    ratePerformanceUseCase.execute(
        _AddPerformanceUseCaseObserver(this),
        RatePerformanceUseCaseParams(perf)
    );
  }

  void getAllPerformances() {
    getPerformancesUseCase.execute(
        _GetAllPerformancesUseCaseObserver(this),
        GetAllPerformancesUseCaseParams());
  }

  @override
  void dispose() {
    getAllMovesUseCase.dispose();
  }
}

class _AddPerformanceUseCaseObserver extends Observer<RatePerformanceUseCaseResponse> {
  final MovesListingPresenter presenter;

  _AddPerformanceUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.addPerformanceOnNext();
  }

}

class _GetAllPerformancesUseCaseObserver extends Observer<GetAllPerformancesUseCaseResponse> {
  final MovesListingPresenter presenter;

  _GetAllPerformancesUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    assert(presenter.getPerformancesOnNext != null);
    presenter.getPerformancesOnNext(response.perfs);
  }
}

class _GetAllMovesUseCaseObserver extends Observer<GetAllMovesUseCaseResponse> {
  final MovesListingPresenter presenter;

  _GetAllMovesUseCaseObserver(this.presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {}

  @override
  void onNext(response) {
    presenter.getAllMovesOnNext(response.moves);
  }
}
