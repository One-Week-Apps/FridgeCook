import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_moves_repository.dart';
import 'package:fridge_cook/src/data/repositories/in_memory_performance_repository.dart';
import 'package:fridge_cook/src/domain/entities/move.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/entities/performance_score.dart';
import 'package:fridge_cook/src/domain/repositories/random_generator.dart';
import 'package:fridge_cook/src/domain/usecases/get_all_moves_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/get_performances_usecase.dart';
import 'package:fridge_cook/src/domain/usecases/rate_performance_usecase.dart';

class RandomGeneratorMock implements RandomGenerator {
  RandomGeneratorMock(List<Move> value) { 
    this.value = value;
  }
  List<Move> value;
  
  @override
  List<Move> rand(List<Move> moves) {
    return this.value;
  }

}

void main() {
  test('Staged moves randomly chosed', () async {
    var moves = [
      Move("Sombrero", "", "", "", 1), 
      Move("El Uno", "", "", "", 2),
      Move("El Dos", "", "", "", 3),
      Move("Exhibela", "", "", "", 2)
    ];
    var expected = [
      Move("El Uno", "", "", "", 2),
      Move("Exhibela", "", "", "", 2)
    ];
    
    var movesRepo = InMemoryMovesRepository(moves);
    var randomGenerator = RandomGeneratorMock(expected);
    var count = 2;

    var sut = GetAllMovesUseCase(movesRepo, randomGenerator);

    var response = await sut.buildUseCaseStream(GetAllMovesUseCaseParams(count));
    response.forEach((element) {
      expect(element.moves, expected);
    });
  });

  test('Validate performance', () async {
    var expectedId = 1;
    var expectedPerformanceScore = PerformanceScore(1, 2, 3, 4, 5, 1, 2);
    var expectedDateTime = DateTime.now();
    var performance = Performance(expectedId, expectedPerformanceScore, expectedDateTime);

    var perfsRepo = InMemoryPerformanceRepository([]);
    var sut = RatePerformanceUseCase(perfsRepo);

    var response = await sut.buildUseCaseStream(RatePerformanceUseCaseParams(performance));
    response.forEach((element) async {
      expect(element.status, true);
      var all = await perfsRepo.all();
      all.forEach((element) {
        expect(element.id, expectedId);
        expect(element.score, expectedPerformanceScore);
        expect(element.dateTime, expectedDateTime);
      });
    });
  });

  test('Retrieve preformances', () async {
    var expectedId = 1;
    var expectedPerformanceScore = PerformanceScore(1, 2, 3, 4, 5, 1, 2);
    var expectedDateTime = DateTime.now();
    var performance = Performance(expectedId, expectedPerformanceScore, expectedDateTime);

    var perfsRepo = InMemoryPerformanceRepository([performance]);
    var sut = GetPerformancesUseCase(perfsRepo);

    var response = await sut.buildUseCaseStream(GetAllPerformancesUseCaseParams());
    response.forEach((element) async {
      expect(element.perfs, [performance]);
    });
  });
}


